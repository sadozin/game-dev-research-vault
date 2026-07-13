---
title: "Source: Unity — MaterialPropertyBlock"
type: source
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "https://docs.unity3d.com/ScriptReference/MaterialPropertyBlock.html"
  - "https://docs.unity3d.com/ScriptReference/Renderer.SetPropertyBlock.html"
tags: [source, game-development, unity, materials, rendering]
---

# Source: Unity — MaterialPropertyBlock

- **Author:** Unity Technologies
- **Published:** Undated (Unity Scripting API)
- **URL:** https://docs.unity3d.com/ScriptReference/MaterialPropertyBlock.html
- **Retrieved:** 2026-07-11

## Summary

Unity documents MaterialPropertyBlock as a way to draw multiple objects with one Material while
varying selected properties. Renderer.SetPropertyBlock supports per-renderer or per-material overrides,
which is more memory-efficient than a complete Material copy for small differences. Unity also warns
that property blocks are not compatible with SRP Batcher and can reduce performance in SRP pipelines.

## Compiled into

- [[unity-mcp-material-setup]] — scope, property validation, sharing, and render-pipeline tradeoffs
