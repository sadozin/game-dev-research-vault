---
title: 'Source: Godot Navigation Documentation'
type: source
status: active
created: 2026-07-14
updated: 2026-07-14
verified: 2026-07-14
sources:
  - raw/godot-navigation-documentation.md
tags: [source, game, engine, godot, navigation, pathfinding]
---

# Source: Godot Navigation Documentation

- **Author:** Godot Engine contributors
- **Version:** Stable documentation, observed as Godot 4.7
- **URL:** https://docs.godotengine.org/en/stable/tutorials/navigation/index.html
- **Retrieved:** 2026-07-14
- **Raw:** raw/godot-navigation-documentation.md (provenance only)

## Summary

Godot exposes graph, navigation-map, region, mesh, path-query, agent, obstacle, link, layer, debug,
and performance tools for 2D and 3D movement. The breadth matters because “use navigation” is not a
complete tower-defense decision: a fixed waypoint path, grid distance field, irregular navmesh, and
dynamic obstacle system have different validation and rebuild costs.

Choose the simplest representation that matches the path contract. Maze placement still needs an
explicit transactional reachability check even when an engine supplies navigation and avoidance.

## Compiled into

- [[tower-defense-pathing-and-placement]]
- [[tower-defense-simulation-architecture]]
