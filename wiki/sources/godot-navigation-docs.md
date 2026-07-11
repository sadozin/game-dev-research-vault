---
title: "Source: Godot — 2D navigation overview"
type: source
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "raw/godot-navigation-2d.md"
tags: [source, godot, game-development]
---

# Source: Godot — 2D navigation overview

- **Author:** Godot Engine documentation contributors
- **Published:** Godot 4.x stable documentation
- **URL:** https://docs.godotengine.org/en/stable/tutorials/navigation/navigation_introduction_2d.html
- **Retrieved:** 2026-07-11
- **Raw:** `raw/godot-navigation-2d.md` (provenance only)

## Summary

Two pathfinding styles: **point graphs** (`AStar2D` / `AStarGrid2D`) for discrete cells, and
**navigation meshes** via NavigationServer for free movement in polygons. Scene helpers:
NavigationRegion2D + NavigationPolygon, NavigationAgent2D on movers, optional links/obstacles.
Bake navmesh with margin from collision. Wait one physics frame after load before path queries.
3D uses matching *3D types.

## Compiled into

- [[godot-navigation]]
