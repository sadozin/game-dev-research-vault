---
title: Tower-defense content production
type: concept
status: active
created: 2026-07-14
updated: 2026-07-14
verified: 2026-07-14
sources:
  - [[wiki/sources/mda-game-design-framework|mda-game-design-framework]]
  - [[wiki/sources/procedural-generation-of-tower-defense-levels|procedural-generation-of-tower-defense-levels]]
  - [[wiki/sources/neat-tower-defense-wave-generation|neat-tower-defense-wave-generation]]
  - [[wiki/sources/tower-defense-strategic-control-agents|tower-defense-strategic-control-agents]]
  - [[wiki/sources/unity-scriptableobject|unity-scriptableobject]]
  - [[wiki/sources/kingdom-rush-press-kit|kingdom-rush-press-kit]]
  - [[wiki/sources/bloons-td6-store-description|bloons-td6-store-description]]
tags: [game, design, tower-defense, production, balance, playtesting]
---

# Tower-defense content production

Build one diagnostic vertical slice before multiplying content. A tower-defense roster creates a
combinatorial test surface: every tower, upgrade, enemy, wave, map topology, economy state, and
strategy can interact. Data-driven definitions make this surface editable; they do not make it small.

## Dependency order

1. Write the path, placement, leak, targeting, damage, refund, and pause contracts.
2. Build one route, one ordinary enemy, one tower, one wave, and a fixed logical tick.
3. Make placement, target acquisition, attack, death, reward, and leak observable in debug UI.
4. Add economy and one meaningful upgrade decision.
5. Add swarm and runner roles to test area damage and coverage.
6. Add one control/support role and one armor or trait interaction.
7. Author six waves: teach, repeat, combine, recover, pressure, mastery.
8. Add a seeded smoke replay, event log, and basic metrics. Treat state hashing, headless strategy
   portfolios, and search agents as an advanced harness tier rather than a beginner prerequisite.
9. Validate readability and onboarding with new players.
10. Multiply maps and content only after failures are attributable.

## Content matrices

Give each tower a role, strength, weakness, target set, range/exposure profile, economy timing, and
upgrade choice. Give each enemy a threat role, readable tell, counter set, path rule, reward, and
introduction wave. Give each map a route topology, build-space budget, coverage opportunities,
multi-lane demand, recovery space, and signature rule. Give each wave a teaching purpose and a threat
composition rather than only a power number.

The matrix should expose duplicate roles and unsupported counters. More content is not more depth if
several towers solve the same scenario with different particles.

## Balance workflow

Begin with dimensional sanity checks—time in range, shots to kill, spawn density, payback wave,
upgrade marginal value, and theoretical coverage—then test actual scenarios. Use sparse, swarm,
runner, armor, split-lane, support, boss, and low-capital recovery cases. Run economy-first,
tower-spam, upgrade-first, counter-aware, random-valid, and search-based policies across many seeds.

Track distributions as the project matures: win/leak, first leak, resources, spend time, tower contribution, overkill,
control uptime, overlap, sells, strategy diversity, restarts, and p95/p99 performance. A 50-percent
win rate from one agent is neither fair nor diverse. EA SEED found useful automated performance but
poor unseen-level generalization ([[wiki/sources/tower-defense-strategic-control-agents|tower-defense-strategic-control-agents]]).

## Procedural and adaptive content

Procedural generation can produce candidates quickly, but path, tower sites, waves, economy, and
strategy interact ([[wiki/sources/procedural-generation-of-tower-defense-levels|procedural-generation-of-tower-defense-levels]]). Hind and Harvey found no
discernible reported-experience difference between their NEAT-generated and human waves, while the
engagement result remained inconclusive ([[wiki/sources/neat-tower-defense-wave-generation|neat-tower-defense-wave-generation]]). Generate, validate,
curate, and teach; do not equate novelty with quality.

Hidden adaptation is especially dangerous in a planning game because it can punish the build the
player correctly chose from available information. Prefer explicit difficulty presets or tightly
bounded assistance. If the director reacts, define its signals, range, persistence, and player-facing
promise.

## Scope ladder

The cheapest expansion is more authored waves using existing roles. New enemies and towers are
moderate because they expand the interaction matrix. New route rules, mazing, procedural levels,
heroes, co-op, PvP, action combat, and persistent loot are high-cost because each changes core
systems or adds a new product layer. Budget UI, audio, tutorial, tools, accessibility, performance,
save/replay, and testing alongside visible content.

## Engine and production choice

For a first 2D or simple 3D learning project, Godot keeps iteration and distribution light; Unity is
a strong fit when C# and its mature asset/tool ecosystem are already familiar; Unreal becomes more
attractive when the identity depends on high-end 3D action, but brings more engine surface than a
small classic defense needs. The architecture above transfers between them, so familiarity and the
chosen interaction model matter more than a universal engine ranking.

A mechanical graybox can take days or several weekends; a small polished commercial game usually
takes months, and action/co-op/live-service hybrids can take years. These are order-of-magnitude
planning bands, not estimates: art, platform count, online services, content volume, experience, and
whether tooling already exists dominate the schedule.

Choose the business model early enough to shape the product honestly. Premium, ad-supported,
free-to-play unlock economies, expansions, and live-service events demand different progression,
analytics, consent/privacy, content cadence, server, support, and balance work. A learning project
should usually defer monetization systems until the core loop is trustworthy.

## Related

- [[tower-defense-genre-taxonomy]]
- [[tower-defense-simulation-architecture]]
- [[tower-defense-common-pitfalls]]
