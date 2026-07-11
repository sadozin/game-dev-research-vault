---
title: "Source: Pecorella — The Math of Idle Games, Part I"
type: source
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "raw/idle-game-math-part-i.md"
tags: [source, game-design, clicker]
---

# Source: Pecorella — The Math of Idle Games, Part I

- **Author:** Anthony Pecorella
- **Published:** 2016-10-04
- **URL:** https://blog.kongregate.com/the-math-of-idle-games-part-i/
- **Retrieved:** 2026-07-11
- **Raw:** `raw/idle-game-math-part-i.md` (provenance only)

## Summary

An idle game's economy is a race between production and cost. The article models a generator's
next purchase as an exponential cost curve, `baseCost * growthRate^owned`, while total production
is the combined generator output multiplied by upgrades. The curves must be simulated together:
cost eventually outruns ordinary linear or polynomial production, deliberately creating the
slowdown that makes a reset valuable.

With multiple generators, the mathematically best purchase is the highest income-to-cost ratio,
but a player should not be expected to execute a constantly changing, one-item purchase sequence.
Bulk purchases and visible multiplier thresholds make the economy legible while retaining enough
choice to reward attention.

## Compiled into

- [[clicker-game-economy]] — production, costs, and purchase decisions
- [[idle-game-prestige]] — the reset that relieves the cost wall
