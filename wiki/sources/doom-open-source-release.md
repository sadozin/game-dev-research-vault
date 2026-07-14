---
title: 'Source: DOOM Open Source Release'
type: source
status: active
created: 2026-07-14
updated: 2026-07-14
verified: 2026-07-14
sources:
  - raw/doom-open-source-release.md
tags: [source, game, shooter, doom, source-code, engine]
---

# Source: DOOM Open Source Release

- **Author:** id Software; release note by John Carmack
- **Published:** 1997-12-23
- **URL:** https://github.com/id-Software/DOOM
- **Retrieved:** 2026-07-14
- **Raw:** raw/doom-open-source-release.md (provenance only)

## Summary

The released Linux Doom 1.10 source is the strongest evidence for shipped classic runtime behavior.
It uses a 35 Hz timebase, fixed-point math, tick-driven thinkers and commands, data-driven actor and
weapon states, BSP rendering, and WAD assets. Enemy code acquires targets through sight or sector
sound, chases with simple movement direction, and chooses melee or missile states. Weapon code
combines hitscan, auto-aim, spread, pellets, and moving projectiles.

Carmack's release note distinguishes successful concepts from implementation misses. He praises the
basic rendering model while saying BSP should also have supported environment tests; movement and
line-of-sight line checking were messier than necessary. The code is the Linux port, not the original
DOS source, which could not be released because of a copyrighted sound library.

These mechanics explain classic Doom but are not universal modern requirements.

## Compiled into

- [[doom-style-shooter-combat-profiles]]
- [[doom-style-shooter-weapon-and-enemy-design]]
- [[doom-style-shooter-testing-and-architecture]]
- [[classic-doom-engine-internals]]
- [[classic-doom-engine-quirks-and-bugs]]
