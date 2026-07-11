---
title: "Source: Godot — importing 3D scenes and formats"
type: source
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "raw/godot-importing-3d-scenes.md"
tags: [source, godot, game-development, assets]
---

# Source: Godot — importing 3D scenes and formats

- **Author:** Godot Engine documentation contributors
- **Published:** Godot 4.x stable documentation
- **URLs:**
  - https://docs.godotengine.org/en/stable/tutorials/assets_pipeline/importing_3d_scenes/index.html
  - https://docs.godotengine.org/en/stable/tutorials/assets_pipeline/importing_3d_scenes/available_formats.html
- **Retrieved:** 2026-07-11
- **Raw:** `raw/godot-importing-3d-scenes.md` (provenance only)

## Summary

Godot imports whole 3D **scenes**, not only lone meshes. **glTF 2.0** (`.glb` / `.gltf`) is
recommended. Alternatives: `.blend` (needs Blender installed; exports to glTF under the hood),
FBX (ufbx default in modern Godot 4), OBJ (limited: no skin/anim/PBR), DAE (legacy). Drop
files into the project; editor imports on focus. Prefer metric scale and sensible backface
culling from Blender. Node name suffixes can customize imported node types.

## Compiled into

- [[godot-asset-placement]]
- [[godot-3d-rendering-basics]]
- [[blender-game-asset-pipeline]]
