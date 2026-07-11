---
title: "Source: Unity — Draw Call Batching and the SRP Batcher"
type: source
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "https://docs.unity3d.com/2022.3/Documentation/Manual/DrawCallBatching.html"
tags: [source, unity, optimization]
---

# Source: Unity — Draw Call Batching and the SRP Batcher

- **Author:** Unity Technologies
- **Published:** Unity Manual, 2022.3 LTS
- **URL:** https://docs.unity3d.com/2022.3/Documentation/Manual/DrawCallBatching.html
- **Also:** https://docs.unity3d.com/2022.3/Documentation/Manual/SRPBatcher.html
- **Retrieved:** 2026-07-11

## Summary

Unity documents several methods that reduce or cheapen draw calls, all of which require objects to
share render state. Static batching combines stationary GameObjects that share a material into one
buffer, rendered together while each mesh keeps individual culling, at the cost of memory and build
size. Dynamic batching transforms the vertices of small meshes on the CPU to group compatible
geometry into a single call; it helps only for low-vertex meshes because the per-frame CPU transform
can cost more than it saves, and it is unsupported in HDRP. GPU instancing draws many copies of one
mesh in a single call with per-instance data, suiting repeated geometry such as foliage or crowds,
and Unity disables it on objects it has already static-batched.

The SRP Batcher (URP, HDRP, and custom SRPs) works differently: it does not lower the call count but
keeps per-material data resident in GPU memory and reduces the CPU render-state changes between draw
calls whose materials use the same shader variant. It is incompatible with GPU instancing and with
MaterialPropertyBlocks. Across all methods, sharing materials and atlasing textures preserve
batches, whereas reading `Renderer.material` clones the material and silently breaks batching—
`Renderer.sharedMaterial` preserves it. Pipeline support and specific limits vary by Unity version,
so confirm them against the version in use.

## Compiled into

- [[draw-call-batching]] — static, dynamic, instancing, and SRP Batcher tradeoffs
