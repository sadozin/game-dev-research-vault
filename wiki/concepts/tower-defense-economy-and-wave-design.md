---
title: Tower-defense economy and wave design
type: concept
status: active
created: 2026-07-14
updated: 2026-07-14
verified: 2026-07-14
sources:
  - [[plants-vs-zombies-onboarding-gdc]]
  - [[procedural-generation-of-tower-defense-levels]]
  - [[tower-defense-strategic-control-agents]]
  - [[neat-tower-defense-wave-generation]]
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
messages, and clear first actions ([[plants-vs-zombies-onboarding-gdc]]).

Author waves as threat compositions. Density tests area damage, speed tests exposure and reaction,
armor tests damage diversity, split lanes test distribution, support units test priority, and bosses
test sustained output plus learned mechanics. Introduce one role safely, repeat it with variation,
combine it with an earlier role, then test mastery. Preview any rule capable of invalidating an
otherwise legal build.

Automated play is useful for solvability and balance distributions but not a universal difficulty
oracle. Procedural research combines road maps, tower locations, monster sequences, and automated
playtesting; EA SEED's learned/scripted agent outperformed its heuristic baseline on tested levels
but generalized poorly to unseen ones ([[tower-defense-strategic-control-agents]]). Hind and Harvey
found no discernible reported-experience difference between NEAT-generated and human waves, while
the engagement result remained inconclusive ([[neat-tower-defense-wave-generation]]). Use multiple
strategy bots, seeds, telemetry, and humans; generated waves are candidates, not a fairness proof.

## Related

- [[tower-defense-pathing-and-placement]]
- [[tower-defense-targeting-and-balance]]
- [[tower-defense-content-production]]
- [[difficulty-dynamic-adjustment]]
