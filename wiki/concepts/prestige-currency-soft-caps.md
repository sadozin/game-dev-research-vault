---
title: Prestige currency soft caps
type: concept
status: active
created: 2026-07-12
updated: 2026-07-12
verified: 2026-07-12
sources:
  - "[[idle-game-math-part-iii]]"
  - "[[diminishing-returns-soft-caps]]"
tags: [game-design, clicker, idle, prestige, economy]
---

# Prestige currency soft caps

Soft caps on prestige currencies slow meta-progress as a stack grows without forbidding further
gains. Hard caps stop growth at a fixed ceiling. Together with *stacked* reset currencies—each
layer resetting the one below—they are how long idle curves stay readable after
[[idle-game-prestige]] has already solved the first run’s cost wall.

## Why it works

A prestige currency that scales linearly with run earnings eventually floods the meta shop and
collapses the next wall. Fractional-exponent or root curves (square root of lifetime or max
earnings, cube roots, flatter powers such as ~1/7) turn huge run numbers into slowly growing
tokens, so each reset still feels powerful without ending the economy in a week. That is already a
soft shape on *gain*; soft caps on *effect* go further: after a threshold, extra tokens buy less
production (for example map surplus *x* through `a · x / (x + n)` so the effective bonus approaches
`a` but never quite reaches a hard wall).

Lifetime vs run-based gain changes strategy. Lifetime or max-based formulas reward pushing farther
than last time and give little or nothing for identical resets; pure run-based formulas pay the
same for the same endpoint and can encourage short farm loops unless the curve is made very flat.
Hard caps elsewhere—offline hour limits, storage ceilings—force active decisions and must be
balanced against prestige cadence so AFK players are not silently stranded.

Stacked meta currencies (reincarnations above gems, “mega” layers above ordinary prestige) re-apply
the same idea at a slower scale: when the first prestige currency soft-caps into noise, a deeper
reset compresses it again and opens a new spend tree. Introduce each layer only when the previous
one has visibly plateaued.

## The catch

Too-aggressive soft caps feel like a brick wall with extra steps; too-weak caps make late prestige
irrelevant or force endless number inflation. Hidden soft caps on offline earnings or prestige gain
break trust—surface the rule. Multiple stacked currencies without clear “what this layer unlocks”
become chore ladders. Farm-friendly run-based formulas need extra friction (content gates, flat
gain curves, or content that rewards going farther) or optimal play becomes reset spam.

## In practice here

In the same simulator as [[clicker-game-economy]] and [[idle-game-prestige]], model at least three
curves: root-of-lifetime, root-of-max, and flat run-based power. Plot tokens to double the current
meta balance versus run multiple of the previous peak. Add one soft-capped spend effect and one hard
offline cap; verify first-time and optimising players still meet prestige on a similar session
rhythm. Prefer visible soft-cap thresholds and a second layer only after the first currency’s
marginal value has clearly collapsed.
