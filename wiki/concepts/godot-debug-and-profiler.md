---
title: Godot debug and profiler
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[godot-systems-batch-3-docs]]"
tags: [game-development, godot, optimization]
---

# Godot debug and profiler

Efficient AI-built games fail less when debugging is systematic: **see the tree**, **see
collisions**, **measure before optimizing**, **fix multiplayer with multi-instance**.

## Editor Debug menu (always know these)

| Option | Use |
|---|---|
| Visible Collision Shapes | Physics bounds + raycasts |
| Visible Navigation | Navmesh / polygons |
| Visible Avoidance | Agent avoidance radii |
| Visible Paths | Path/curve resources |
| Synchronize Scene/Script Changes | Live reload while game runs |
| Customize Run Instances | **N clients** for multiplayer |

## Remote scene dock

When the game runs: Scene dock → **Remote**. Inspect live nodes, change properties, verify
instancing and Autoload order. This is the #1 tool when "why is null?"

## Breakpoints

- Click gutter for red-dot breakpoints (editor-persistent).  
- `breakpoint` keyword in GDScript for VCS-friendly breaks.  
- Debugger: Continue / Step Over / Step Into.  

## Output and logging

- `print` / `push_warning` / `push_error`  
- Project Settings → Debug → File Logging for disk logs  
- Enable FPS print only while investigating  

## Profiler workflow (Knuth-aligned)

1. **Make the game correct** first.  
2. Profile to find the real bottleneck (CPU vs GPU).  
3. Optimize only that bottleneck.  
4. Re-profile.  

Types of slowness:

- Continuous low FPS (every frame cost)  
- Spikes (GC, loads, hitches)  
- Load stalls (level streaming)  

Hypothesis test: remove half the work (binary search) and measure.

```gdscript
var t0 := Time.get_ticks_usec()
# suspect work
print("us=", Time.get_ticks_usec() - t0)
```

Godot Profiler panel times scripts/functions. External GPU tools if GPU-bound.

### Bottleneck math

If A is 90% of frame, 9× on A wins huge. If GPU is 50 ms and CPU is 9 ms, CPU-only opts change
nothing. **Always identify which side is slow.**

## Performant design reminders

- Cache locality / fewer allocations in hot loops  
- Prefer sharing Resources; `duplicate()` only when needed  
- Object pools only after profiling spawn cost  
- Reduce lights/shadows, draw calls, overdraw ([[godot-3d-rendering-basics]])  
- Feature tags for web/mobile low settings ([[godot-web-export]])  

## Multiplayer debug

Customize Run Instances → 2–4 instances with different `--` user args if needed. Watch Remote
trees carefully — node names must match for RPCs ([[godot-multiplayer]]).

## Common "works in editor" checks

| Symptom | Check |
|---|---|
| No collision | Visible shapes; layers/masks; scaled shapes |
| No path | Visible nav; agent radius; await physics frame |
| Input dead | UI focus; unhandled path ([[godot-input-handling]]) |
| Web no audio | Click-to-start; Sample vs Stream ([[godot-web-export]]) |
| Save missing | `user://` persistence; private browsing |

## AI builder checklist

- [ ] Remote tree inspected when stuck  
- [ ] Collision/nav visibility used before rewriting systems  
- [ ] Profiler evidence before "optimizing everything"  
- [ ] Multi-instance for net features  
- [ ] Warnings enabled for unused vars / unsafe access  

## Related

- [[godot-physics-bodies]] · [[godot-navmesh-baking]] · [[godot-multiplayer]] ·
  [[game-performance-profiling]] · [[godot-ai-build-playbook]]
