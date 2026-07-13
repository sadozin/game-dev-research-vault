---
title: Draw call batching
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[nvidia-batch-batch-batch]]"
  - "[[unity-draw-call-batching]]"
tags: [game-development, optimization, rendering]
---

# Draw call batching

A draw call is a command from the CPU telling the GPU to render one batch of geometry, and each call
carries a fixed cost to set up render state and dispatch the work. A batch is a group of objects
submitted together so that setup is paid once instead of per object. Because that per-call CPU
overhead—not triangle count—is often what a frame hits first, consolidating or reducing draw calls
is a primary way to move a CPU-bound renderer back under budget.

## Why it works

The classic result is that below a small per-call triangle count a scene is entirely CPU-bound: the
processor cannot issue calls fast enough to keep the GPU busy, so triangles added inside an existing
call are nearly free. The ceiling is batches per frame, not triangles per frame, and because GPU
throughput has outpaced single-thread CPU performance the gap has only widened.

Objects can share a batch only when they share render state—the same material and shader variant and
a compatible renderer type. The available techniques trade different costs against that rule. Static
batching merges stationary meshes that share a material into one buffer, keeping per-object culling
at the price of memory and build size. Dynamic batching transforms small meshes on the CPU to group
them into one call, worthwhile only when the meshes are cheap enough that the transform costs less
than the call it saves. GPU instancing draws one mesh many times in a single call with per-instance
data, which fits repeated geometry like foliage or crowds. The SRP Batcher takes a different route:
rather than cutting the call count it keeps material data resident on the GPU and removes the CPU
render-state changes between calls that share a shader variant. Sharing materials and atlasing
textures is what keeps objects batchable in the first place.

## The catch

Batching is neither free nor universal. Static batching spends memory and build size to save calls;
dynamic batching loses when meshes are too complex; the SRP Batcher is mutually exclusive with GPU
instancing and forbids MaterialPropertyBlocks. Transparent geometry must draw back-to-front, which
breaks batches that opaque geometry would keep. A subtle trap is that touching `Renderer.material`
clones the material and silently ends batching, where `Renderer.sharedMaterial` preserves it. Above
all, fewer draw calls only helps a frame that is actually CPU-bound on submission—so confirm the
bottleneck before merging anything, because a GPU-bound frame needs a different fix entirely.

## In practice here

Treat draw-call count as one of the limiting subsystems to classify during
[[game-performance-profiling]]: a CPU-bound frame made of many small submissions is a batching
problem, while spikes that persist after batching belong to [[frame-pacing]]. On avatars, the
material-slot and renderer counts that [[vrchat-avatar-optimization]] reports are the same
batchable-unit counts described here, which is why merging meshes and atlasing textures both improve
VRChat rank and reduce draw calls for one underlying reason.
