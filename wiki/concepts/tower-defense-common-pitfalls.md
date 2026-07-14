---
title: Tower-defense common pitfalls
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
  - [[fix-your-timestep]]
  - [[dungeon-defenders-store-description]]
  - [[kingdom-rush-battles-beginners-guide]]
tags: [game, design, tower-defense, pitfalls, debugging, production]
---

# Tower-defense common pitfalls

The most damaging tower-defense failures break causality: the player cannot connect preparation to
outcome, while the developer cannot reproduce or measure the run.

## Design and balance

| Pitfall | Symptom | Prevention or repair |
|---|---|---|
| Designing the roster before the path model | Placement, enemies, and UI keep being rewritten | Freeze the movement and blockage contract first |
| Pricing from nominal DPS | Splash, slow, range, and overkill dominate unexpectedly | Price marginal contribution in canonical scenarios |
| Scaling only health and count | Late waves become long rather than interesting | Compose density, speed, armor, support, lanes, and timing |
| Raising every variable together | Difficulty spikes reveal no lesson | Change one pressure, repeat it, then combine |
| Hard counters without preview | A legal build becomes an unavoidable loss | Telegraph rule-breakers before the commitment window |
| Win-more economy | One early leak causes irreversible collapse | Add baseline income, recovery tools, bounded bonuses, or respec space |
| Mandatory economy tower | Every opening is solved | Vary pressure and payback; preserve viable conservative play |
| Upgrade tree of percentages | Choice is arithmetic, not strategy | Make branches change role, target set, timing, or topology |
| Permanent progression hides balance | Grinding substitutes for learning | Test base levels at controlled power and separate breadth from strength |
| One bot defines difficulty | Levels fit one policy and fail humans or other strategies | Use policy portfolios, seeds, telemetry, and human explanation |

## Pathing and combat engineering

| Pitfall | Symptom | Prevention or repair |
|---|---|---|
| Placement commits before reachability | Towers seal routes or strand enemies | Tentative occupancy, validate, then atomically charge/commit |
| A* per enemy per frame | Swarm waves collapse CPU time | Waypoints or one reverse field per shared goal |
| Unstable equal-cost ties | Enemies flicker routes; replays diverge | Stable IDs and deterministic tie-breaking |
| Eligibility mixed with priority | Towers “ignore” obvious targets | Filter eligibility, rank priority, then break ties |
| Implicit projectile death policy | Shots vanish or hit pooled/dead targets | Define retarget, miss, seek, or impact behavior explicitly |
| Event-order ambiguity | Double rewards, double leaks, save/load changes outcome | Publish one tick order and golden-test simultaneous events |
| Render objects own game truth | Frame rate and VFX change combat | Keep authoritative state in the simulation layer |
| Fixed step assumed to guarantee determinism | Same seed diverges across runs or devices | Stabilize order, RNG, math, callbacks, commands, and hashes |
| Pooling without reset contracts | Old target/status state reappears | Centralize spawn/despawn reset and test lifecycle invariants |
| Optimizing average load only | Boss or death wave hitches | Profile p95/p99 and worst concurrent entity/effect counts |

## UX and production

| Pitfall | Symptom | Prevention or repair |
|---|---|---|
| Effects obscure rules | Players cannot see lanes, targets, or status | Give gameplay contrast priority; aggregate cosmetic noise |
| Tooltip-first onboarding | Players can recite rules but choose poorly | Teach through a safe action and visible payoff |
| Range/UI disagrees with simulation | Edge targets feel random | Use one shared query/definition for display and truth |
| Building content instead of tools | Every balance change requires code edits | Use validated data definitions, wave editor, replay, and telemetry |
| Too many scope multipliers | Prototype needs nav, netcode, loot, PCG, and combat simultaneously | Choose one hook and defer other axes |
| Adding co-op/PvP late | Ownership, pause, currency, and sync rules conflict | Treat multiplayer as an architectural and product decision |
| Procedural generation used as a hook alone | Infinite levels repeat the same decision or create unfair seeds | Generate meaningful constraints, validate, curate, and communicate |
| Hidden adaptive waves counter the player | Planning feels rigged | Use explicit presets or bounded, promised adaptation |
| Balancing before rules are legible | Tuning compensates for confusion | Fix preview, feedback, and attribution before numbers |
| No diagnostic capture | Bugs disappear when developers watch | Save seed, commands, data version, path version, IDs, and hashes |

## The pre-mortem questions

Before production, answer: what can permanently invalidate a build; how does the player know before it
matters; what is the cheapest recovery after a mistake; what is the maximum legal entity/effect load;
which state owns money and death; how is every route validated; what happens when a target dies in
flight; and which feature would be cut first if the vertical slice is not fun?

## Related

- [[tower-defense-readability-and-onboarding]]
- [[tower-defense-simulation-architecture]]
- [[tower-defense-content-production]]
