---
title: Tower-defense genre taxonomy
type: concept
status: active
created: 2026-07-14
updated: 2026-07-14
verified: 2026-07-14
sources:
  - [[plants-vs-zombies-onboarding-gdc]]
  - [[procedural-generation-of-tower-defense-levels]]
  - [[kingdom-rush-press-kit]]
  - [[dungeon-defenders-store-description]]
  - [[kingdom-rush-battles-beginners-guide]]
tags: [game, design, tower-defense, genre, taxonomy]
---

# Tower-defense genre taxonomy

Tower defense is best classified on three independent axes. Treating every hybrid as one flat list
conceals the systems it adds and leads teams to underestimate scope.

## Axis one: who controls the route?

| Path model | Main player problem | Main implementation burden |
|---|---|---|
| Fixed route, free placement | Find coverage, overlap, specialization, and timing around a known route | Range geometry, dominant build spots, route readability |
| Fixed route, build pads | Allocate scarce locations and upgrade branches | Pad authoring, site value, less placement freedom |
| Lane or row defense | Match local counters and timing to parallel lanes | Lane state, cross-lane rules, avoiding solved recipes |
| Player-built maze | Spend space to change route topology and exposure | Transactional connectivity, rerouting, anti-sealing rules |
| Open field or navmesh | Control fronts and approach vectors in irregular space | Dynamic navigation, ambiguity, camera and threat communication |
| Hybrid or dynamic route | Combine coverage with topology changes or route events | Rule communication, path versioning, expensive validation |

[[tower-defense-pathing-and-placement]] is authoritative for the movement contract. Fixed routes are
the safest first project because the team can learn economy, waves, targeting, and readability before
making player placement alter navigation.

## Axis two: how directly does the player intervene?

Planning-heavy games emphasize placement and upgrades, while active-ability designs add spells,
heroes, retargeting, or manual triggers. Action hybrids add a directly controlled combat character;
[[dungeon-defenders-store-description]] demonstrates that this also adds character feel, gear,
camera, encounters, and often co-op. Competitive variants add adversarial balance, networking,
matchmaking, synchronization, and live operations ([[kingdom-rush-battles-beginners-guide]]).

Co-op is not simply “single player with more cursors.” Shared currency, ownership, build permissions,
pause rules, role division, disconnect recovery, scaling, and grief prevention all need a contract.

## Axis three: what structures repeated play?

- **Authored level puzzle:** known map and waves reward learning and optimization.
- **Campaign:** maps, towers, enemies, and mechanics unlock in a teaching sequence.
- **Endless/survival:** the content system must scale composition and performance, not only health.
- **Roguelite run:** randomized maps, rewards, and build pools trade perfect fairness for adaptation.
- **Meta-progression:** permanent unlocks widen or strengthen the portfolio between levels.
- **Sandbox/challenge:** modifiers or constrained loadouts turn the same systems into new problems.

These structures change balance. A level-puzzle game can assume a known legal toolkit; a roguelite
must survive unlucky offers; permanent power progression can make old levels trivial or disguise
whether the base game is balanced.

## Common named families

“Classic fixed-path,” “mazing,” “lane defense,” “hero defense,” “action tower defense,” “tower
offense/PvP,” “roguelite tower defense,” and “survival-defense hybrid” are useful market labels, but
the three-axis description is the production truth. Two games with the same store tag may need
fundamentally different pathing, UI, test harnesses, and content pipelines.

## First-project recommendation

Start with one fixed route, free placement or explicit pads, two ordinary tower roles plus one
control/support role, three enemy roles, six authored waves, one upgrade decision per tower, and no
meta progression. Add one distinctive hook only after that slice makes every leak explainable. A
maze, action hero, co-op, PvP, procedural maps, and roguelite progression are each separate scope
multipliers; combining them before the foundation works hides the cause of every problem.

## Related

- [[tower-defense-core-loop-and-player-decisions]]
- [[tower-defense-content-production]]
- [[tower-defense-common-pitfalls]]
