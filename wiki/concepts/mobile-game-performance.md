---
title: Mobile game performance
type: concept
status: active
created: 2026-07-20
updated: 2026-07-20
verified: 2026-07-20
sources: []
tags: [game-development, mobile, performance, optimization, gpu, rendering]
---

# Mobile game performance

Mobile performance is a thermal problem first, a GPU problem second, and a memory problem
third. A phone has no fan: sustained high load raises die temperature until the OS throttles
clock speeds, and the game that ran at 60 fps in the first two minutes drops to 30 fps
after ten. Every optimization decision must target *sustained* frame rate, not peak frame
rate.

## The thermal envelope

### Why mobile throttles

Phones and tablets cool passively through their chassis. The SoC (CPU + GPU + NPU on one
die) has a thermal design power of roughly 3–6 W. When the game sustains load above that
envelope, the silicon heats up, the OS reduces clock frequency (thermal throttling), and
frame rate drops. This is not a bug — it is the physics of a sealed glass-and-metal slab.

### Designing for sustained performance

- **Target 30 fps for complex 3D, 60 fps for 2D/casual.** A locked 30 fps that never
  throttles is better than 60 fps that drops to 25 after five minutes.
- **Leave GPU headroom.** If the GPU is at 95% utilization in the editor, it will throttle
  on device. Aim for 60–70% utilization on the target device to leave thermal margin.
- **Use adaptive quality.** Detect thermal state (iOS `ProcessInfo.thermalState`,
  Android `PowerManager` thermal API) and reduce shadow resolution, particle count,
  or post-processing when the device heats up.
- **Avoid sustained CPU spikes.** Garbage collection, asset loading, and physics bursts
  cause frame hitches that compound with thermal throttling. Spread work across frames
  ([[pool-warmup-and-budgeting]]).

## Mobile GPU architecture

### Tile-based deferred rendering (TBDR)

Most mobile GPUs (ARM Mali, Qualcomm Adreno, Apple GPU, Imagination PowerVR) are
tile-based: they divide the screen into small tiles (typically 16×16 or 32×32 pixels),
process all geometry for a tile in on-chip memory, then write the result to main memory
once. This is fundamentally different from desktop immediate-mode GPUs.

**What TBDR rewards:**
- Opaque geometry drawn front-to-back (early-Z rejects hidden fragments before shading).
- Fewer render targets and framebuffer operations.
- Keeping geometry within a tile (avoid geometry that spans many tiles).

**What TBDR punishes:**
- **Overdraw.** Every transparent layer forces the tile to re-read and re-blend.
  Four overlapping transparent quads cost 4× the fill rate. This is the single biggest
  mobile GPU killer.
- **Framebuffer fetches / read-backs.** Reading the depth or color buffer mid-frame
  forces a tile flush to main memory (a "resolve"), which is expensive.
- **Full-screen post-processing passes.** Each pass is a full-framebuffer resolve and
  re-read. Bloom + SSAO + tone mapping + FXAA = 4 extra full-screen passes.
- **Alpha-tested (cutout) geometry.** Discards fragments after shading, defeating
  early-Z. Use opaque or pre-multiplied alpha instead where possible.

### Fill rate is the budget

Mobile GPUs are fill-rate-limited, not vertex-limited. A scene with 100k triangles and
no overdraw will outperform a scene with 20k triangles and 4× overdraw. Optimize for
pixels touched, not polygons submitted.

Practical limits (mid-range 2024-class device, 1080p):
- **2–3× overdraw** for opaque + 1 transparent layer is the comfort zone.
- **4+× overdraw** causes visible frame drops.
- **Full-screen transparent effects** (fog planes, screen-space overlays) are expensive;
  use them sparingly.

## Rendering budget

### Draw calls

Each draw call has CPU overhead (command buffer submission, state validation). Mobile
CPUs handle roughly 100–300 draw calls per frame at 60 fps before the CPU becomes the
bottleneck. Batch aggressively:

- **Static batching** — combine static meshes sharing a material into one draw call.
- **Dynamic batching** — engine combines small meshes at runtime (Unity: <300 verts;
  Godot: limited).
- **GPU instancing** — draw many copies of the same mesh with per-instance data.
  Ideal for vegetation, particles, repeated props.
- **Texture atlases and arrays** — reduce material count so more geometry shares a
  draw call ([[texture-atlasing]], [[texture-arrays-vs-atlases]]).

### Shader complexity

Mobile fragment shaders run on limited ALU per pixel. Keep fragment shaders under
~20–30 instructions for mid-range devices. Avoid:
- Dependent texture reads (reading a texture with coordinates from another texture).
- Complex branching (if/else in fragment shaders).
- Multiple dynamic lights per pixel (use baked lighting or 1–2 real-time lights max).

### Texture memory

Mobile GPUs share memory with the CPU. A 2048×2048 RGBA8 texture is 16 MB uncompressed;
with mipmaps, ~21 MB. Ten such textures consume 200+ MB. Use:
- **ASTC** (Adaptive Scalable Texture Compression) — the standard mobile format.
  ASTC 6×6 gives ~3.5 bits/pixel with good quality. ASTC 8×8 for less critical textures.
- **ETC2** for OpenGL ES 3.0 fallback (Android minimum).
- **PVRTC** only if targeting very old iOS devices (pre-A8).
- Maximum 1024×1024 for most textures; 2048 only for hero assets.
- Mipmaps on everything that is not UI ([[mipmapping-and-texture-streaming]]).

## CPU budget

### Frame budget at 60 fps: 16.6 ms total

Typical allocation:
- Game logic / AI / physics: 4–6 ms
- Animation: 1–2 ms
- Rendering submission (draw call prep): 3–5 ms
- OS / engine overhead: 2–3 ms
- **Margin for GC, loading, thermal variance: 2–4 ms**

At 30 fps the budget doubles to 33.3 ms, but the thermal argument still applies —
sustained 33 ms frames are better than 16 ms frames that degrade.

### Garbage collection

C# (Unity) and GDScript (Godot) both allocate on the heap. GC pauses cause frame
hitches. Mitigate:
- Object pooling for bullets, particles, enemies, UI elements
  ([[pool-warmup-and-budgeting]]).
- Avoid per-frame allocations (new arrays, string concatenation, LINQ in hot paths).
- Use struct/value types where possible in Unity.
- In Godot, reuse arrays and dictionaries; avoid `new()` in `_process()`.

### Asset loading

Loading a texture or mesh on the main thread causes a frame spike. Use:
- Async loading (Unity `Addressables`, Godot `ResourceLoader.load_threaded`).
- Preload during loading screens or natural pauses.
- Streaming for open-world content.

## Memory budget

### Typical device memory

| Tier | RAM | Available to game |
|---|---|---|
| Low-end (2024) | 4 GB | ~1.5–2 GB |
| Mid-range | 6–8 GB | ~3–4 GB |
| High-end | 12–16 GB | ~6–8 GB |

The OS, background apps, and GPU framebuffer consume 1–3 GB before the game starts.
Target 1.5 GB total for a mid-range game; 800 MB for a casual game targeting low-end.

### What eats memory

- Textures (see above — the biggest consumer by far).
- Meshes with many vertices and multiple UV channels.
- Audio (uncompressed PCM; use compressed formats — AAC, Vorbis, ADPCM).
- Script VMs and engine runtime overhead.
- Asset bundles loaded but not unloaded.

### Memory hygiene

- Unload assets when leaving a scene/level.
- Use texture compression (ASTC) — reduces both memory and bandwidth.
- Limit simultaneous audio sources; pool them.
- Profile memory on the lowest target device, not the editor.

## Battery

Battery drain is a retention metric. A game that drains 20% battery in 30 minutes gets
uninstalled. The GPU and screen are the biggest consumers. Mitigations:
- Cap frame rate at 30 fps for complex scenes (halves GPU power).
- Reduce rendering resolution (render at 0.7× native, upscale) — the GPU does less work.
- Pause rendering when the game is idle (menus, dialog boxes).
- Avoid keeping the screen at max brightness; let the system manage it.

## Profiling on device

- **Unity:** Unity Profiler (USB or Wi-Fi), Frame Debugger, GPU Profiler (Snapdragon
  Profiler for Adreno, ARM Performance Studio for Mali, Xcode GPU Capture for Apple GPU).
- **Godot:** Remote debug over USB/Wi-Fi, `--profiling` flag, monitor draw calls and
  objects in the debugger panel ([[godot-debug-and-profiler]]).
- **Unreal:** GPU Visualizer, `stat unit`, `stat gpu`, Unreal Insights.
- **Platform:** Xcode Instruments (Time Profiler, GPU, Energy), Android GPU Inspector
  (AGI), Snapdragon Profiler.

Profile on the *lowest-spec target device*, not the newest flagship. The flagship will
hide problems that the mid-range device exposes.

## Quick checklist

- [ ] Target frame rate chosen (30 or 60) and locked
- [ ] Overdraw ≤ 3× on the target device
- [ ] Draw calls ≤ 200 per frame (mid-range target)
- [ ] Textures compressed (ASTC/ETC2), max 1024 for non-hero
- [ ] Mipmaps enabled on all world textures
- [ ] Object pooling for all frequently spawned objects
- [ ] No per-frame heap allocations in hot paths
- [ ] Asset loading is async, not on the main thread
- [ ] Memory ≤ 1.5 GB on mid-range target
- [ ] Thermal throttle test: 15-minute sustained play session
- [ ] Battery drain test: 30-minute session, measure % drop
- [ ] Tested on lowest-spec target device, not just the editor

## Related

- [[mobile-game-development]] · [[mobile-game-design-principles]]
- [[frame-pacing]] · [[game-performance-profiling]] · [[texture-atlasing]] ·
  [[texture-arrays-vs-atlases]] · [[mipmapping-and-texture-streaming]] ·
  [[level-of-detail]] · [[pool-warmup-and-budgeting]] · [[visibility-culling]] ·
  [[real-time-lighting-budget]]
- [[godot-mobile-export]] · [[godot-debug-and-profiler]]
