---
title: Difficulty and dynamic adjustment
type: concept
status: active
created: 2026-07-14
updated: 2026-07-14
verified: 2026-07-14
sources:
  - [[wiki/sources/dynamic-difficulty-adjustment-in-tower-defence|dynamic-difficulty-adjustment-in-tower-defence]]
  - [[wiki/sources/neat-tower-defense-wave-generation|neat-tower-defense-wave-generation]]
tags: [game, design, difficulty, dynamic-difficulty, tower-defense]
---

# Difficulty and dynamic adjustment

Difficulty is multidimensional: required planning, execution speed, information, recovery margin,
content knowledge, economy pressure, and punishment can change independently. A difficulty preset
should state which dimensions it changes rather than silently multiplying every enemy statistic.

Dynamic difficulty adjustment observes play and changes later challenge. A tower-defense prototype
has used lives, enemy health, and selected passive skills as inputs
([[wiki/sources/dynamic-difficulty-adjustment-in-tower-defence|dynamic-difficulty-adjustment-in-tower-defence]]), while learned wave generation has produced
reported player experience comparable to human waves without conclusively increasing engagement
([[wiki/sources/neat-tower-defense-wave-generation|neat-tower-defense-wave-generation]]). These establish feasibility, not a universal benefit.

Hidden adaptation is risky when the genre's appeal is planning against stable rules. If the system
counters a player's build, improvement may appear to have no effect and authored solutions become
unreliable. Prefer explicit presets for puzzle-like levels. Bounded assistance can adjust recovery
income, optional hints, timing slack, or future composition without changing a wave already promised.

Document the observation signals, response limits, update timing, persistence, reset behavior, and
player-facing promise. Telemetry must distinguish natural level difficulty from director intervention,
and tests must cover exploitation such as deliberate poor play before a boss.

## Related

- [[tower-defense-economy-and-wave-design]]
- [[tower-defense-content-production]]
- [[tower-defense-common-pitfalls]]
