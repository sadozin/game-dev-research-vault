---
title: "Source: Blender Manual — Scene Units and Transforms"
type: source
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "https://docs.blender.org/manual/en/latest/scene_layout/scene/properties.html"
tags: [source, game-development, blender, assets, pipeline]
---

# Source: Blender Manual — Scene Units and Transforms

- **Author:** Blender Foundation
- **Published:** Undated (Blender Manual)
- **URL:** https://docs.blender.org/manual/en/latest/scene_layout/scene/properties.html
- **Retrieved:** 2026-07-11

## Summary

Blender exposes scene-level unit settings and object transforms separately. That distinction matters
for export: a scene can display a chosen unit system while an individual object's scale or rotation
remains unapplied. A reliable pipeline makes both the scene convention and export-time transform
policy explicit instead of assuming the viewport display defines the serialized mesh.

## Compiled into

- [[blender-to-engine-scale-and-axis]] — scene conventions, transform application, and reproducible export
