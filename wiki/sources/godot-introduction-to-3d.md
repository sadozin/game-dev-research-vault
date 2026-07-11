---
title: "Source: Godot — introduction to 3D"
type: source
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "raw/godot-introduction-to-3d.md"
tags: [source, godot, game-development, 3d]
---

# Source: Godot — introduction to 3D

- **Author:** Godot Engine documentation contributors
- **Published:** Godot 4.x stable documentation
- **URL:** https://docs.godotengine.org/en/stable/tutorials/3d/introduction_to_3d.html
- **Retrieved:** 2026-07-11
- **Raw:** `raw/godot-introduction-to-3d.md` (provenance only)

## Summary

3D and 2D APIs are parallel (Node3D vs Node2D). **1 unit = 1 meter**; wrong scale breaks
physics and precision. Coordinate system: **Y-up**, right-handed; Z is typically "forward" for
cameras/lights. Node3D holds transform (position, Euler rotation, scale). A **Camera3D** is
required to see anything. Lights + **WorldEnvironment** control look; editor can preview sun/
environment when missing. Content usually comes from DCC tools (glTF etc.), CSG for prototypes,
or generated meshes. Gizmos: W/E/R move/rotate/scale; F frames selection.

## Compiled into

- [[godot-3d-rendering-basics]]
- [[godot-asset-placement]]
