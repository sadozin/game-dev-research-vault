---
title: 'Source: Flow Field Pathfinding for Tower Defense'
type: source
status: active
created: 2026-07-14
updated: 2026-07-14
verified: 2026-07-14
sources:
  - raw/tower-defense-flow-field-pathfinding.md
tags: [source, game, tower-defense, pathfinding]
---

# Source: Flow Field Pathfinding for Tower Defense

- **Author:** Amit J. Patel, Red Blob Games
- **Published:** 2014; updated through 2026
- **URL:** https://www.redblobgames.com/pathfinding/tower-defense/
- **Retrieved:** 2026-07-14
- **Raw:** raw/tower-defense-flow-field-pathfinding.md (provenance only)

## Summary

Patel constructs pathfinding backward from the shared destination. One BFS computes distances for an
equal-cost grid; Dijkstra generalizes the field to weighted edges. Every enemy then chooses a neighbor
with lower distance rather than running a separate A* search.

The shared field fits tower-defense swarms because the goal is common and topology changes less often
than enemies move. It also supports route preview and placement validation: unreachable cells remain
infinite and local gradients show the chosen direction. Stable equal-cost ties and dynamic-update
policy remain explicit game rules.

## Compiled into

- [[tower-defense-pathing-and-placement]]
