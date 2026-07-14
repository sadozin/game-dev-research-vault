---
title: 'Source: Dynamic Difficulty Adjustment in Tower Defence'
type: source
status: active
created: 2026-07-14
updated: 2026-07-14
verified: 2026-07-14
sources:
  - raw/dynamic-difficulty-adjustment-in-tower-defence.md
tags: [source, game, design, tower-defense, difficulty]
---

# Source: Dynamic Difficulty Adjustment in Tower Defence

- **Authors:** Rhio Sutoyo, Davies Winata, Katherine Oliviani, Dedy Martadinata Supriyadi
- **Published:** 2015, Procedia Computer Science 59, 435–444
- **URL:** https://doi.org/10.1016/j.procs.2015.07.563
- **Retrieved:** 2026-07-14
- **Raw:** raw/dynamic-difficulty-adjustment-in-tower-defence.md (provenance only)

## Summary

The paper implements a tower-defense difficulty system that reacts to player lives, enemy health,
and selected passive skills, producing different settings for best, average, and worst strategy
cases. It demonstrates one concrete adaptive approach; it does not establish that hidden adaptation
is universally fair, more enjoyable, or preferable to explicit difficulty choices.

In a planning-heavy game, changing pressure in response to the current build can invalidate the
player's mental model. Use dynamic adjustment only with an explicit experience goal, bounded response
range, stable signals, and a player-facing promise about what adapts.

## Compiled into

- [[difficulty-dynamic-adjustment]]
- [[tower-defense-economy-and-wave-design]]
- [[tower-defense-common-pitfalls]]
