---
title: "Source: Microsoft — DirectX 12 resource binding overview"
type: source
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "https://learn.microsoft.com/en-us/windows/win32/direct3d12/resource-binding-flow-of-control"
tags: [source, game-development, optimization, rendering, textures, directx]
---

# Source: Microsoft — DirectX 12 resource binding overview

- **Author:** Microsoft
- **Published:** 2022-10-25 (last updated)
- **URL:** https://learn.microsoft.com/en-us/windows/win32/direct3d12/resource-binding-flow-of-control
- **Retrieved:** 2026-07-11

## Summary

Direct3D 12 represents shader resources with descriptors grouped into descriptor tables inside
shader-visible heaps. Shaders can select resources from those tables by index, including large static
sets selected by a material ID. The application owns heap versioning and must avoid overwriting
descriptors still referenced by in-flight command lists, typically using frame allocation and fences.
This model reduces per-draw binding work but deliberately leaves lifetime and synchronization decisions
to the engine.

## Compiled into

- [[bindless-textures]] — descriptor heaps, shader indexing, and in-flight resource lifetime
