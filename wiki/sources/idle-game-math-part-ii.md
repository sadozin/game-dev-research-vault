---
title: "Source: Pecorella — The Math of Idle Games, Part II"
type: source
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "https://www.gamedeveloper.com/game-platforms/the-math-of-idle-games-part-ii"
tags: [source, game-design, clicker]
---

# Source: Pecorella — The Math of Idle Games, Part II

- **Author:** Anthony Pecorella
- **Published:** 2016-12-14
- **URL:** https://www.gamedeveloper.com/game-platforms/the-math-of-idle-games-part-ii
- **Retrieved:** 2026-07-11

## Summary

Part II steps away from the usual Cookie-Clicker layout—many generators each dumping into one
primary currency—and models a cascade where higher tiers produce lower-tier generators instead.
Each tier is the rate of change of the tier below it, so continuous approximation yields successive
integrals (`1`, `t`, `t²/2`, `t³/6`, …). With enough tiers the sum approaches `e^t`, but a finite
ladder stays sub-exponential. That keeps exponential costs ahead of production, so the familiar
slowdown wall still appears without every generator writing straight into cash.

The practical design problem is relevance: free auto-spawned lower tiers can make manual purchases
feel pointless. One fix used in Derivative Clicker is to price generators from the *purchased*
count while applying small production boosts to all buildings of a tier per purchase, so buying
still matters after owned counts explode. The article also points at multi-currency and
cross-dependency webs (generators that feed each other rather than a single pipeline) as a wider
design space worth simulating before shipping.

## Compiled into

- [[clicker-game-economy]] — cascading / derivative generator models and purchase relevance
- [[idle-game-prestige]] — why finite derivative ladders still leave a cost wall prestige can answer
