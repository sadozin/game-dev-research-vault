---
title: Tower-defense targeting and balance
type: concept
status: active
created: 2026-07-14
updated: 2026-07-14
verified: 2026-07-14
sources:
  - [[tower-defense-strategic-control-agents]]
  - [[procedural-generation-of-tower-defense-levels]]
tags: [game, design, tower-defense, combat, balance, testing]
---

# Tower-defense targeting and balance

Target selection has three separate stages: eligibility, priority, and stable tie-breaking.
Eligibility checks life, type, range, line of sight, and attack rules. Priority may choose most
progress, strongest, nearest, lowest health, or another policy. Stable entity or spawn IDs resolve
ties so outcomes do not change with container iteration.

Tower value is not nominal DPS. Effective contribution includes armor and resistance, range exposure,
targeting uptime, projectile travel, overkill, enemy density, status caps, and synergy. Price and test
towers against canonical sparse, swarm, runner, armor, split-lane, support, boss, and recovery cases.
Upgrade branches should change a decision, not only increase a percentage.

Use a deterministic logical tick, seeded randomness, stable ordering, command logs, and state hashes
for replayable balance simulation. Test formulas and event order, then assert invariants: accepted
placement leaves required paths, dead enemies neither leak nor pay twice, currency stays nonnegative
after valid commands, and the same seed plus commands reproduces the same state.

The exact target policies, tick order, and metrics here are derived engineering doctrine. Research
supports multi-component level evaluation and multi-strategy automated testing, while also showing
that agents can fail to generalize ([[tower-defense-strategic-control-agents]]).

## Related

- [[tower-defense-economy-and-wave-design]]
- [[tower-defense-pathing-and-placement]]
- [[fixed-timestep-and-determinism]]
- [[game-performance-profiling]]
