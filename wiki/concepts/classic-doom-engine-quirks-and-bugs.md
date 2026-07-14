---
title: Classic Doom engine quirks and bugs
type: concept
status: active
created: 2026-07-14
updated: 2026-07-14
verified: 2026-07-14
sources:
  - [[doom-engine-internals-doomwiki]]
  - [[doom-open-source-release]]
tags: [game, shooter, doom, engine, debugging]
---

# Classic Doom engine quirks and bugs

The 1993 engine's failure catalog, kept because each bug is a category a rebuild will hit again.

## Gameplay bugs

- **Blockmap edge paralysis** — things placed exactly on block boundaries or flush against walls
  can fail collision checks and freeze; monsters placed too close to walls never move. Category:
  spatial-grid boundary conditions. Test entities exactly on cell edges.
- **Intercepts overflow ("all-ghosts")** — a hitscan trace crossing more than 128 intercepts
  overruns a fixed array into live memory, after which things walk through walls. Category:
  fixed-capacity buffers on unbounded queries.
- **Spechits overflow** — crossing too many special lines in one move overruns another fixed
  array, corrupting triggers. Same category.
- **Lost soul limit** — a hard spawn cap silently swallows Pain Elemental attacks. Category:
  silent failure at a static limit instead of visible degradation.
- **Rocket passes through firer** — projectiles initially skip collision with their owner;
  necessary to not explode in the player's face, but the window is timing-based rather than
  ownership-based. Category: self-collision rules need explicit design, not a grace period.
- **Wallrunning and straferunning** — movement code applies thrust in a way that lets diagonal
  input (SR40/SR50) and wall contact exceed intended top speed. Both became beloved technique;
  speedrunning depends on them. Category: speed-cap math applied per-axis instead of to the vector.

## Rendering bugs

Visplane overflow (too many distinct floor/ceiling views crashes the frame), hall of mirrors
(missing textures), tutti-frutti (short textures on tall walls), medusa (multi-patch textures on
two-sided lines tanking the renderer), and slime trails (BSP splitting round-off). All are static
limits or precision issues; all are irrelevant to a modern renderer except as a reminder that
**map-data validation belongs in the toolchain**, not in the runtime crash handler.

## The two portable lessons

First: most of these are *fixed-capacity structures meeting unbounded player behavior*. A rebuild
in a modern language swaps buffer overruns for silent clamps or frame spikes, but the category
survives — budget and test the worst case ([[doom-style-shooter-testing-and-architecture]]).
Second: players canonized wallrunning, straferunning, and infighting abuse as *depth*. A remake or
homage that "fixes" the movement bugs without replacing the expressiveness they provided loses the
feel; decide deliberately which exploits are features ([[doom-style-shooter-combat-profiles]]).

## Related

- [[classic-doom-engine-internals]]
- [[doom-style-shooter-level-and-encounter-design]]
