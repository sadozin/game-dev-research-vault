---
title: 'Source: The AI of DOOM (1993)'
type: source
status: active
created: 2026-07-14
updated: 2026-07-14
verified: 2026-07-14
sources:
  - raw/doom-1993-ai-gamedeveloper.md
tags: [source, game, shooter, doom, ai]
---

# Source: The AI of DOOM (1993)

- **Author:** Tommy Thompson (AI and Games), Game Developer
- **URL:** https://www.gamedeveloper.com/game-platforms/the-ai-of-doom-1993
- **Retrieved:** 2026-07-14
- **Raw:** raw/doom-1993-ai-gamedeveloper.md (provenance only)

## Summary

Doom's enemies are finite state machines (SPAWN, SEE, MELEE, RANGE, PAIN, DIE, XDIE, and the
Arch-Vile's RAISE) whose action functions are attached to individual animation frames, so behavior
and animation cannot drift apart. Perception is 180° sight with no distance limit, prefiltered by
the precomputed REJECT sector-visibility table, plus the soundtarget flood fill. There is no
pathfinding: monsters step directly toward the target on the blockmap and bounce semi-randomly off
walls, which stays convincing because levels are built as open connected fields rather than mazes.

Pain interruption is probabilistic per damage instance — an Imp flinches at 200/256, a Cyberdemon
at 5/256 — and pellet weapons roll per pellet, which is why shotguns feel stunning. Infighting is
simple retargeting-on-damage with hand-picked exceptions (same-species Baron/Hell Knight immunity;
the Arch-Vile cannot be targeted). The article's larger point: apparent sophistication comes from
level designers composing 130+ linedef triggers, ambush flags, teleport closets, and sound-pipe
corridors around very simple per-monster logic.

## Compiled into

- [[classic-doom-engine-internals]]
- [[doom-style-shooter-weapon-and-enemy-design]]
