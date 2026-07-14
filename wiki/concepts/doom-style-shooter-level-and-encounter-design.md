---
title: Doom-style shooter level and encounter design
type: concept
status: active
created: 2026-07-14
updated: 2026-07-14
verified: 2026-07-14
sources:
  - [[doom-at-30-romero-retrospective]]
  - [[doom-push-forward-combat-gdc]]
tags: [game, design, shooter, doom, level-design, encounters]
---

# Doom-style shooter level and encounter design

Classic Doom level rhythm alternates combat with exploration and orientation. John Romero describes
large contrasting spaces, stairs, windows, ledges, secret corridors, glimpses of desirable
destinations, and time to stop and route-find ([[doom-at-30-romero-retrospective]]). Continuous
lock-in arenas are one modern branch, not the entire lineage.

Use loops, keys, switches, glimpses, shortcuts, secrets, and landmarks. Backtracking should change
state, reveal a faster route, or present a new decision. Landmarks must be unique, visible at decision
points, and tied to route structure; exits, locks, interactables, hazards, and pickups need distinct
visual and audio language.

Combat arenas need several circulation loops, cross-routes, sight breaks that do not trap AI, escape
options, vertical opportunities, landmarks, and safe-enough microbeats to reassess. Telegraph
reinforcement doors and avoid unavoidable attacks behind the player. Scale geometry to player speed,
stopping distance, collision radius, FOV, projectile width, and enemy size.

Budget simultaneous threat decisions rather than raw monster count. Compose projectile pressure,
melee route pressure, anchors, support, and relief roles. Push-forward encounters must preserve a
viable low-resource recovery action ([[doom-push-forward-combat-gdc]]).

## Related

- [[doom-style-shooter-combat-profiles]]
- [[doom-style-shooter-weapon-and-enemy-design]]
- [[classic-doom-engine-quirks-and-bugs]]
- [[visibility-culling]]
- [[real-time-lighting-budget]]
