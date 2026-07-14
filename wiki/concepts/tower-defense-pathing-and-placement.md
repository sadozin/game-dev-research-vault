---
title: Tower-defense pathing and placement
type: concept
status: active
created: 2026-07-14
updated: 2026-07-14
verified: 2026-07-14
sources:
  - [[tower-defense-flow-field-pathfinding]]
  - [[procedural-generation-of-tower-defense-levels]]
tags: [game, design, tower-defense, pathfinding, level-design]
---

# Tower-defense pathing and placement

The path model is a tower-defense game's central rule. Fixed paths make coverage and timing the main
spatial decisions; player-built mazes make placement change movement topology; lanes emphasize local
counters; hybrids combine those decisions at a much higher communication and validation cost.

For many enemies sharing a goal, compute one reverse BFS or Dijkstra distance field rather than A*
per enemy. BFS fits equal-cost grids and Dijkstra supports weighted edges. Enemies follow decreasing
cost, with stable tie-breaking at equal-cost branches. [[tower-defense-flow-field-pathfinding]]
documents the shared-field construction.

Maze placement must be transactional: apply occupancy tentatively, recompute reachability, validate
every required spawn-to-goal route and active ground unit, then commit both tower and cost or reject
them together. The game must define full blockage, active-enemy rerouting, diagonal corner cutting,
minimum corridor width, multiple exits, and path-rule breakers such as flying enemies.

Path length, turns, branches, and tower coverage are balance controls. Procedural-level research finds
that longer or more turning routes often increase exposure and cross-coverage, but topology, tower
positions, waves, and play strategy interact; no path metric alone proves difficulty
([[procedural-generation-of-tower-defense-levels]]).

## Related

- [[tower-defense-economy-and-wave-design]]
- [[tower-defense-targeting-and-balance]]
- [[godot-navigation]]
- [[godot-navmesh-baking]]
