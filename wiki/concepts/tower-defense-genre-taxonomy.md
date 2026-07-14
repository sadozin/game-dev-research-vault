---
title: Tower-defense genre taxonomy
type: concept
status: active
created: 2026-07-14
updated: 2026-07-14
verified: 2026-07-14
sources:
  - [[wiki/sources/plants-vs-zombies-onboarding-gdc|plants-vs-zombies-onboarding-gdc]]
  - [[wiki/sources/procedural-generation-of-tower-defense-levels|procedural-generation-of-tower-defense-levels]]
  - [[wiki/sources/kingdom-rush-press-kit|kingdom-rush-press-kit]]
  - [[wiki/sources/dungeon-defenders-store-description|dungeon-defenders-store-description]]
  - [[wiki/sources/kingdom-rush-battles-beginners-guide|kingdom-rush-battles-beginners-guide]]
  - [[wiki/sources/bloons-td6-store-description|bloons-td6-store-description]]
  - [[wiki/sources/orcs-must-die-official-description|orcs-must-die-official-description]]
  - [[wiki/sources/legion-td2-official-description|legion-td2-official-description]]
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
[[wiki/sources/dungeon-defenders-store-description|dungeon-defenders-store-description]] illustrates one package that also includes character classes,
gear, varied missions, and co-op. Those features imply additional camera, combat, networking, and
balance work. Competitive variants likewise add adversarial economy, synchronization, matchmaking,
anti-cheat considerations, and live balance work; [[wiki/sources/kingdom-rush-battles-beginners-guide|kingdom-rush-battles-beginners-guide]] is one current
competitive example, while the production implications are derived.

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

The major lineages are broader than three famous examples. Bloons TD represents roster, branching
upgrade, hero, co-op, meta-progression, and live-content breadth
([[wiki/sources/bloons-td6-store-description|bloons-td6-store-description]]). Orcs Must Die represents weapon-and-trap action defense
([[wiki/sources/orcs-must-die-official-description|orcs-must-die-official-description]]). Legion TD 2 represents the send-creep PvP economy in which
defense, offense, and growth compete for attention ([[wiki/sources/legion-td2-official-description|legion-td2-official-description]]). Reverse/tower-offense,
RTS-colony defense, merge/idle defense, and automation-defense hybrids sit at the genre edges and
should be described by their added decision system rather than folded into “classic TD.”

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
