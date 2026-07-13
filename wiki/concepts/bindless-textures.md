---
title: Bindless textures
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[vulkan-descriptor-indexing]]"
  - "[[directx12-resource-binding]]"
tags: [game-development, optimization, rendering, textures, graphics-api]
---

# Bindless textures

Bindless textures are shader-visible arrays of texture descriptors that the shader selects by an
index, instead of requiring the CPU to bind a small texture set for every material or draw. The name
does not mean that textures have no binding or hardware limit; it means the shader can address a large
resource table through data such as a material or instance ID. This is the third answer beside
[[texture-atlasing]] and [[texture-arrays-vs-atlases]].

## Why it works

The renderer creates a large descriptor table or descriptor set, stores texture views in it, and
passes each object a compact index. The shader uses that index to select the sampled image while the
draw keeps its pipeline and geometry state. Vulkan descriptor indexing provides runtime-sized arrays,
partially bound arrays, update-after-bind, and dynamic non-uniform indexing as separate features;
Direct3D 12 exposes the same general shape through shader-visible descriptor heaps, tables, and shader
indexing. Unlike an atlas, each texture keeps its own dimensions, wrap mode, mip chain, format, and
filtering behavior.

## The catch

Descriptor indexing moves complexity into resource lifetime and shader correctness. The application
must respect device limits, keep descriptors valid while in-flight work can read them, and use the
API's feature flags and non-uniform annotations correctly. Divergent texture indices in a pixel quad
can cost more sampling work, and a descriptor table index outside the valid range can become undefined
or trigger validation/device problems. A large table also does not eliminate texture bandwidth,
shading, overdraw, or material pipeline changes; it mainly removes repeated descriptor binding and
the atlas's packing constraints.

## In practice here

Use a stable global texture registry with handles that are never recycled until the GPU is finished
with old frames. Store the handle in material or instance data, validate it in debug builds, and keep a
fallback texture for missing content. Query the exact Vulkan descriptor-indexing features or D3D12
heap limits at startup, then measure descriptor updates, cache behavior, texture bandwidth, and frame
time in [[game-performance-profiling]]. Prefer atlases or texture arrays when their uniformity is a
benefit; bindless is most useful when many unrelated textures must coexist in the same draw or material
system.
