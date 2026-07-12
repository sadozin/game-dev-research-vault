---
title: Idle-game prestige
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[idle-game-math-part-i]]"
  - "[[idle-game-math-part-ii]]"
  - "[[idle-game-math-part-iii]]"
tags: [game-design, clicker, idle, prestige]
---

# Idle-game prestige

Prestige resets a run's temporary generators and multipliers in return for a persistent currency,
bonus, or unlock. It is the structural answer to the cost wall in a [[clicker-game-economy]]:
instead of leaving the player at an ever-longer wait, it turns accumulated progress into a
shorter, more powerful next run.

## Why it works

The reset both creates a visible "go farther this time" arc and compresses a runaway primary
currency into a slower meta-progression scale. Reward should derive from meaningful run progress
and grow more slowly than the run's headline currency—fractional-exponent curves are common—so
each reset accelerates the next run without instantly trivialising all future content. Cascading
generator models from [[clicker-game-economy]] do not remove the need for prestige: a finite
derivative ladder still grows slower than exponential costs, so the same wall—and the same
reset-as-relief—eventually reappears.

Offer prestige when the next meaningful purchase has slowed enough that resetting is attractive,
then make the early rebuild noticeably faster. The player must understand three values at the
moment of choice: what is lost, what permanent reward is gained, and roughly how much farther the
next run will reach.

## The catch

An identical rebuild with only larger numbers becomes chores. Persistent rewards should unlock a
new decision, automation, route, or build option over time, rather than merely multiply income.
Do not hide an offline-earnings cap inside prestige math: it changes return cadence and needs its
own player-facing rule.

## In practice here

Prototype prestige in the same simulator as [[clicker-game-economy]]. Test reset timing against
both a first-time player and an informed player who pursues high income-to-cost purchases; the
two should not encounter radically different pacing by accident.
