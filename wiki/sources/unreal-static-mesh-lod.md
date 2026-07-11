---
title: "Source: Epic — Static Mesh LODs"
type: source
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "raw/unreal-static-mesh-lod.md"
tags: [source, 3d, optimization, lod]
---

# Source: Epic — Static Mesh LODs

- **Author:** Epic Games
- **Published:** Unreal Engine 5.8 documentation
- **URL:** https://dev.epicgames.com/documentation/en-us/unreal-engine/static-mesh-automatic-lod-generation-in-unreal-engine
- **Retrieved:** 2026-07-11
- **Raw:** `raw/unreal-static-mesh-lod.md` (provenance only)

## Summary

Unreal generates lower-detail static mesh versions through quadratic mesh simplification and can
choose them by screen size. Epic recommends project-level LOD group presets over hand-tuning every
asset, because categories such as architecture, small props, and high-detail assets need different
reduction and visual-error policies.

## Compiled into

- [[level-of-detail]] — screen-space-driven visual budgets
- [[game-performance-profiling]] — validate LOD transitions in target scenes
