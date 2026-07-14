---
title: Tower-defense simulation architecture
type: concept
status: active
created: 2026-07-14
updated: 2026-07-14
verified: 2026-07-14
sources:
  - [[fix-your-timestep]]
  - [[unity-scriptableobject]]
  - [[godot-navigation-documentation]]
  - [[tower-defense-flow-field-pathfinding]]
  - [[tower-defense-strategic-control-agents]]
tags: [game, engineering, tower-defense, architecture, simulation, testing]
---

# Tower-defense simulation architecture

Keep simulation truth separate from presentation. The simulation owns money, topology, progress,
targeting, attacks, status, death, rewards, leaks, and wave state. Visual objects consume events and
interpolate positions; they do not decide hits, pay rewards, or mutate authoritative state.

## Data, state, and systems

Immutable definitions describe tower, attack, enemy, status, upgrade, wave, difficulty, and level
rules. Runtime state holds entity IDs, health, progress, cooldowns, target IDs, active statuses,
currency, lives, path version, and timers. [[unity-scriptableobject]] is one engine-specific example
of asset-backed definitions; Godot Resources and Unreal Data Assets/Data Tables serve the same design
purpose.

Core systems are placement validation, navigation, spawning, movement/progress, target acquisition,
attack/projectile resolution, status/damage, lifecycle accounting, economy, wave control, save/replay,
telemetry, and presentation. Prefer explicit system boundaries over a tower subclass for every attack
type and an enemy subclass for every trait.

## One explicit logical tick

1. consume commands;
2. validate and atomically commit topology;
3. spawn scheduled entities;
4. move enemies and update route progress;
5. validate or acquire targets;
6. fire and advance projectiles;
7. apply statuses, shields, armor, and damage;
8. resolve death and rewards once;
9. resolve exits and leaks once;
10. advance wave state and emit presentation/telemetry events.

The exact order may differ, but it must be written and tested. Simultaneous lethal damage and exit,
selling during a shot, target death before projectile arrival, and on-death spawning expose implicit
ordering immediately.

[[fix-your-timestep]] supports a fixed or bounded step with render interpolation and enough headroom
to avoid catch-up collapse. Stable IDs, stable iteration, seeded random streams, command logs, and
state hashes make runs reproducible. A fixed tick alone is not cross-platform determinism.

## Navigation choice

Waypoints fit authored fixed paths. A reverse BFS or Dijkstra field fits many grid enemies sharing a
goal. A navmesh fits irregular free movement. A* fits occasional individual queries better than one
query per ordinary enemy per frame. Engine navigation, including the broad Godot stack documented in
[[godot-navigation-documentation]], supplies mechanisms but does not define the game's blockage,
reroute, diagonal, multi-goal, and active-enemy rules.

## Performance shape

The usual CPU risks are all-pairs range scans, per-enemy pathfinding, allocations, status/aura fanout,
chain/splash expansion, death storms, and excessive UI/VFX events. Partition candidates by lane,
progress bucket, grid, quadtree, or spatial hash; stagger scans when the rules allow it; pool visual
objects after profiling; and batch telemetry. Preserve simulation fidelity while reducing damage
numbers, particles, and cosmetic updates first.

Test worst-case concurrent enemies, projectiles, statuses, auras, deaths, reroutes, and save/replay
capture on target hardware. Average frame rate does not reveal a wave-transition spike or p99 tick.

## Testing layers

Unit tests cover formulas, accounting, targeting, stacking, timing, and data validation. Golden
micro-scenarios cover ties, travel, splash, rerouting, selling, simultaneous kill/leak, multiple
goals, and save/load mid-wave. Headless runs cover seeds and strategy portfolios. Human tests remain
necessary for comprehension, fairness, and fun because learned agents can generalize poorly
([[tower-defense-strategic-control-agents]]).

## Related

- [[tower-defense-pathing-and-placement]]
- [[tower-defense-targeting-and-balance]]
- [[fixed-timestep-and-determinism]]
- [[game-performance-profiling]]
