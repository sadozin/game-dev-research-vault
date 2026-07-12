---
title: "Source: Unity — GPU instancing"
type: source
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "https://docs.unity3d.com/2023.2/Documentation/Manual/GPUInstancing.html"
tags: [source, game-development, optimization, rendering, unity]
---

# Source: Unity — GPU instancing

- **Author:** Unity Technologies
- **Published:** 2024-04-25 (Unity Manual publication date; page revised 2017-10-24)
- **URL:** https://docs.unity3d.com/2023.2/Documentation/Manual/GPUInstancing.html
- **Retrieved:** 2026-07-11

## Summary

Unity describes GPU instancing as rendering multiple copies of a mesh with the same material in one
draw call, while allowing per-instance values such as color and scale. Its managed path requires a
shader that supports instancing and generally groups objects sharing a mesh and material; it does not
support SkinnedMeshRenderer, and SRP Batcher-compatible GameObjects use the SRP Batcher instead.
Unity also warns that very small meshes may not distribute enough work to use the GPU efficiently,
and recommends a single combined buffer for heavily repeated low-vertex meshes.

## Compiled into

- [[gpu-instancing]] — engine constraints, batching interaction, and the small-mesh failure mode
