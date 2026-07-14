---
title: Tower-defense core loop and player decisions
type: concept
status: active
created: 2026-07-14
updated: 2026-07-14
verified: 2026-07-14
sources:
  - [[mda-game-design-framework]]
  - [[plants-vs-zombies-onboarding-gdc]]
  - [[kingdom-rush-press-kit]]
tags: [game, design, tower-defense, core-loop, strategy]
---

# Tower-defense core loop and player decisions

Tower defense is delayed-feedback capital allocation. The player reads a future threat, commits
scarce money and space, observes automated combat, intervenes within the rules, and uses the outcome
to revise the next commitment. Automation is not the absence of play: it is what lets an earlier
decision reveal its consequences.

## The operating loop

1. **Preview:** read route, wave traits, lane, timing, money, and legal placement.
2. **Plan:** compare coverage, specialization, upgrades, economy, abilities, and reserve.
3. **Commit:** place, upgrade, sell, target, activate, or deliberately hold resources.
4. **Observe:** see acquisition, fire, control, overkill, kills, and leaks.
5. **Intervene:** use the actions the chosen subgenre allows without erasing planning.
6. **Resolve:** apply rewards, lives, cooldowns, progression, and wave completion.
7. **Explain and revise:** understand the result before the next irreversible decision.

The loop breaks when the preview omits a decisive rule, presentation hides causality, a single
opening dominates every threat, or failure removes the resources needed to try a different response.

## The decision layers

Spatial decisions choose coverage, chokepoints, overlap, lane distribution, topology, and safe room
for later construction. Economic decisions choose immediate defense, specialization, production,
upgrade timing, refund loss, and reserve. Combat decisions choose target policy, damage type,
control, armor break, burst timing, and active abilities. Portfolio decisions choose which towers,
heroes, cards, or upgrades enter a level. Campaign decisions choose unlocks and risk across levels.

Each added layer needs information, counterplay, and a time horizon. If the answer is obvious without
considering the next wave, the layer is busywork rather than strategy.

## Causal design with MDA

[[mda-game-design-framework]] provides a useful chain. Costs, ranges, wave schedules, targeting, and
refunds are mechanics. They produce dynamics such as kill zones, hoarding, greed, specialization,
panic selling, and recovery. Those dynamics create anticipation, mastery, relief, discovery, or
frustration. Design backward from the desired experience and test forward from the implemented rule.

For example, “tense greed” requires a visible future threat, an investment with a known delayed
payoff, a viable conservative option, and enough recovery space that greed is a gamble rather than a
coin flip. Merely adding an income tower does not produce that experience.

## Fairness and attribution

A fair loss is predictable enough to plan for, readable while it happens, and explainable afterward.
Fair does not mean easy or fully disclosed. It means the player can identify the decisive causal
chain and imagine a legal alternative. Reveal traits that invalidate normal rules—flight, stealth,
immunity, route breaking, disabling, or shield timing—before the commitment window closes.

The post-wave state should answer: what leaked, where damage stopped landing, which tower could not
target it, what resource was missing, and whether a different placement, priority, or purchase would
have mattered. [[tower-defense-readability-and-onboarding]] turns this contract into UI and feedback.

## Related

- [[tower-defense-economy-and-wave-design]]
- [[tower-defense-targeting-and-balance]]
- [[tower-defense-genre-taxonomy]]
