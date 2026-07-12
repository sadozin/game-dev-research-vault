---
title: "Source: Unity — Texture atlasing for batching and sprite atlases"
type: source
status: active
created: 2026-07-12
updated: 2026-07-12
verified: 2026-07-12
sources:
  - "https://docs.unity3d.com/2022.3/Documentation/Manual/DrawCallBatching.html"
tags: [source, unity, optimization, textures]
---

# Source: Unity — Texture atlasing for batching and sprite atlases

- **Author:** Unity Technologies
- **Published:** Unity Manual (Draw call batching, 2022.3 LTS; Sprite atlas landing, Unity 6 docs)
- **URL:** https://docs.unity3d.com/2022.3/Documentation/Manual/DrawCallBatching.html
- **Also:** https://docs.unity3d.com/Manual/sprite/atlas/atlas-landing.html
- **Retrieved:** 2026-07-12

## Summary

Unity batches draw calls for renderers that share a material. When two materials differ only by
which texture they reference, the manual recommends combining those textures into one larger image—
texture atlasing—so a single material can replace both. That shared material is what static and
dynamic batching need in order to group objects; atlasing is therefore an art-pipeline step that
enables the engine’s batching features rather than a separate renderer mode.

For 2D, Sprite Atlas assets pack many sprite textures into one atlas texture so Unity can issue
fewer GPU draws for those sprites. Variants and manual load APIs exist so platforms can ship
lower-resolution atlases or defer loading. Pipeline and feature support still vary (for example
dynamic batching is unavailable in HDRP), so version-specific manuals remain the check for limits.

## Compiled into

- [[texture-atlasing]] — definition, material-sharing purpose, engine tooling
- [[draw-call-batching]] — why shared materials and atlased textures preserve batches
