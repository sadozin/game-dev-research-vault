---
title: "Source: Unity Manual — Prefab Variants and Overrides"
type: source
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "https://docs.unity3d.com/current/Manual/PrefabVariants.html"
  - "https://docs.unity3d.com/current/Manual/prefabs-override.html"
tags: [source, game-development, unity, prefabs, editor]
---

# Source: Unity Manual — Prefab Variants and Overrides

- **Author:** Unity Technologies
- **Published:** Undated (Unity Manual)
- **URL:** https://docs.unity3d.com/current/Manual/PrefabVariants.html
- **Retrieved:** 2026-07-11

## Summary

Unity describes Prefab Variants as reusable collections of overrides based on another Prefab. They can
add components or children and modify properties, but applying those overrides in Prefab Mode changes
the base asset, which is often not the intended variant behavior. Nested prefabs add further apply
levels, so the destination of an override must be explicit.

## Compiled into

- [[unity-mcp-prefab-workflow]] — source/instance/variant ownership and Apply hazards
