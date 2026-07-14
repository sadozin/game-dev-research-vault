---
title: Tower-defense economy and wave design
type: concept
status: active
created: 2026-07-14
updated: 2026-07-14
verified: 2026-07-14
sources:
  - [[wiki/sources/plants-vs-zombies-onboarding-gdc|plants-vs-zombies-onboarding-gdc]]
  - [[wiki/sources/procedural-generation-of-tower-defense-levels|procedural-generation-of-tower-defense-levels]]
  - [[wiki/sources/tower-defense-strategic-control-agents|tower-defense-strategic-control-agents]]
  - [[wiki/sources/neat-tower-defense-wave-generation|neat-tower-defense-wave-generation]]
  - [[wiki/sources/dynamic-difficulty-adjustment-in-tower-defence|dynamic-difficulty-adjustment-in-tower-defence]]
  - [[wiki/sources/legion-td2-official-description|legion-td2-official-description]]
tags: [game, design, tower-defense, economy, difficulty, waves]
---

# Tower-defense economy and wave design

Tower-defense economy is capital allocation under uncertain future pressure: buy coverage, specialize,
upgrade, invest in production, or hold a reserve. Balance the whole curve - starting capital, passive
and kill income, wave rewards, upgrade costs, refunds, leak consequences, and the cheapest recovery
option - rather than isolated prices.

Plants vs. Zombies demonstrates that economy must be taught through play. When players failed to
understand resource-producing units, the team rebalanced the wider game and changed how the behavior
was introduced. Its broader onboarding method favors doing over text, gradual introduction, passive
messages, and clear first actions ([[wiki/sources/plants-vs-zombies-onboarding-gdc|plants-vs-zombies-onboarding-gdc]]).

Author waves as threat compositions. Density tests area damage, speed tests exposure and reaction,
armor tests damage diversity, split lanes test distribution, support units test priority, and bosses
test sustained output plus learned mechanics. Introduce one role safely, repeat it with variation,
combine it with an earlier role, then test mastery. Preview any rule capable of invalidating an
otherwise legal build.

Automated play is useful for solvability and balance distributions but not a universal difficulty
oracle. Procedural research combines road maps, tower locations, monster sequences, and automated
playtesting; EA SEED's learned/scripted agent outperformed its heuristic baseline on tested levels
but generalized poorly to unseen ones ([[wiki/sources/tower-defense-strategic-control-agents|tower-defense-strategic-control-agents]]). Hind and Harvey
found no discernible reported-experience difference between NEAT-generated and human waves, while
the engagement result remained inconclusive ([[wiki/sources/neat-tower-defense-wave-generation|neat-tower-defense-wave-generation]]). Use multiple
strategy bots, seeds, telemetry, and humans; generated waves are candidates, not a fairness proof.

Dynamic difficulty can alter health, lives, timing, composition, or recovery. A tower-defense
prototype demonstrates that adaptation from player-state signals is feasible
([[wiki/sources/dynamic-difficulty-adjustment-in-tower-defence|dynamic-difficulty-adjustment-in-tower-defence]]), but feasibility does not make hidden response
fair. [[difficulty-dynamic-adjustment]] defines the signals, bounds, timing, persistence, and
player-facing promise needed before using it.

## Related

- [[tower-defense-pathing-and-placement]]
- [[tower-defense-targeting-and-balance]]
- [[tower-defense-content-production]]
- [[difficulty-dynamic-adjustment]]
