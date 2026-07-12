---
title: Unreal World Partition
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[unreal-world-partition-overview]]"
  - "[[unreal-world-partition-builders-and-hlod]]"
tags: [game-development, unreal, world-building, streaming, optimization]
---

# Unreal World Partition

World Partition is Unreal's automatic data-management and distance-based streaming system for large
worlds. It stores a world in one persistent level and divides it into runtime grid cells that stream
around active sources such as players.

## Why it works

Spatially loaded actors are assigned to grid cells, while streaming sources determine which cells are
resident. One File Per Actor reduces contention when multiple people edit the world, and Data Layers
let gameplay or environment variants load independently. HLOD builders generate distant proxy actors,
so unloaded detail can be represented more cheaply instead of simply disappearing.

## The catch

Automatic streaming does not remove memory, IO, or authoring budgets. Cell size, source radii, actor
references, Data Layers, HLOD generation, and teleport destinations all affect hitching and residency.
Actors with cross-cell references may load together, and widely reused assets or excessive Data Layer
membership can degrade streaming. A world can therefore be partitioned correctly yet still over-load
or stall at runtime.

## In practice here

Start with representative travel routes and define cell size and loading ranges from measured memory
and IO budgets. Test fast travel, multiple players, editor collaboration, Data Layer transitions, and
HLOD silhouettes. Prebuild HLODs and other derived data with World Partition builders, and profile
cell load timing before tuning visual detail in isolation.
