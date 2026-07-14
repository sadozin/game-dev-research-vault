---
title: Classic Doom engine internals
type: concept
status: active
created: 2026-07-14
updated: 2026-07-14
verified: 2026-07-14
sources:
  - [[doom-open-source-release]]
  - [[doom-1993-ai-gamedeveloper]]
  - [[doom-engine-internals-doomwiki]]
tags: [game, shooter, doom, engine, ai, architecture]
---

# Classic Doom engine internals

How the 1993 engine actually works, at the level a rebuild needs. These are shipped mechanisms,
documented from the released source and DoomWiki — copy the *shape*, not the constants.

## Simulation

Everything runs on a 35 Hz fixed tick with fixed-point math. All randomness comes from one shared
256-entry table (`P_Random`) consumed in strict call order, which is what makes demos replayable —
and why any change in call order desyncs them. The lesson generalizes: a fixed timestep plus a
single ordered RNG stream buys you input-recording replays and deterministic tests almost for free,
and it is nearly impossible to retrofit ([[doom-style-shooter-testing-and-architecture]]).

## Enemy AI

Enemies are finite state machines (SPAWN, SEE, MELEE, RANGE, PAIN, DIE, XDIE, RAISE) whose action
functions hang off individual animation frames, so tells and behavior can never desynchronize.
Perception is 180° sight with no distance cutoff, prefiltered by the precomputed REJECT
sector-visibility table. There is **no pathfinding**: monsters step toward the target in one of
eight directions on the blockmap grid and bounce semi-randomly off walls. This holds up because
Doom maps are open connected arenas, not mazes — the AI and the level design are one system.

Pain interruption is a per-hit probability (Imp 200/256, Cyberdemon 5/256), rolled per pellet for
spread weapons — the mechanical reason shotguns feel like stun tools. Infighting is plain
retarget-on-damage with hand-picked exceptions (same-species Barons/Hell Knights immune to each
other; Arch-Viles untargetable), and it doubles as a player resource in classic attrition play
([[doom-style-shooter-combat-profiles]]).

## Sound as a gameplay system

"Sound propagation" is not audio. Pressing the attack button (whether or not the shot lands) calls
P_NoiseAlert, which flood-fills a soundtarget through sector adjacency. A sound-blocking line only
attenuates once; it takes **two** to stop a sound. Ambush-flagged monsters wake on sound but hold
until visual contact, then gain 360° perception; soundtargets persist and wake monsters spawned
later. Designers exploited this deliberately — sound-pipe corridors routing noise to monster
closets are a core encounter tool ([[doom-style-shooter-level-and-encounter-design]]).

## Spatial structures

Three parallel structures answer different queries: the **BSP tree** answers rendering order, the
**blockmap** (128×128-unit grid of thing/line lists) answers collision and movement, and the
**REJECT table** answers "can sector A possibly see sector B" before a real sight line is traced.
The modern takeaway is the separation itself: rendering visibility, collision, and AI perception
are distinct query workloads and deserve distinct structures.

## Related

- [[classic-doom-engine-quirks-and-bugs]]
- [[doom-style-shooter-weapon-and-enemy-design]]
- [[doom-style-shooter-testing-and-architecture]]
