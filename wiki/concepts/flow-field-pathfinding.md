---
title: Flow-field pathfinding
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[utility-ai-and-flow-fields]]"
tags: [game-development, ai, pathfinding]
---

# Flow-field pathfinding

A flow field stores the best-known cost and direction from every traversable cell toward a shared
destination.

## Why it works

One reverse search serves many agents, so a crowd follows local directions instead of each agent
running a separate full path search.

## The catch

The field consumes memory and can become stale when obstacles or destinations change. Narrow doors,
dynamic avoidance, and agents with different sizes still need local steering.

## In practice

Build fields per meaningful destination or destination cluster, invalidate them deliberately, and
combine them with collision-aware local movement.

