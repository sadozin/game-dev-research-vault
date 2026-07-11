---
title: "Source: Unity — Occlusion Culling"
type: source
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "raw/unity-occlusion-culling.md"
tags: [source, 3d, optimization, culling]
---

# Source: Unity — Occlusion Culling

- **Author:** Unity Technologies
- **Published:** Unity Manual
- **URL:** https://docs.unity3d.com/Manual/OcclusionCulling.html
- **Retrieved:** 2026-07-11
- **Raw:** `raw/unity-occlusion-culling.md` (provenance only)

## Summary

Frustum culling removes off-camera objects; occlusion culling additionally avoids render work for
objects fully hidden behind solid geometry. Unity's implementation bakes visibility cells and
queries them at runtime, which consumes CPU time and memory. It is most useful in separated indoor
spaces such as rooms and corridors, not runtime-generated geometry or open scenes with little
occlusion.

## Compiled into

- [[visibility-culling]] — choose culling from scene topology and bottleneck
- [[game-performance-profiling]] — confirm that culling saves more than it costs
