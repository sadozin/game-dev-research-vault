---
title: Clicker game economy
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[idle-game-math-part-i]]"
  - "[[idle-game-math-part-ii]]"
  - "[[idle-game-math-part-iii]]"
tags: [game-design, clicker, idle, economy]
---

# Clicker game economy

A clicker game's economy converts player actions and elapsed time into a primary currency, then
spends that currency on generators and upgrades that increase future production. It is a
compounding control system, not a list of arbitrary prices: the player must repeatedly see a
clear next goal, achieve it, and gain a meaningfully faster path to the following goal.

## Why it works

For a basic generator, model the next price as `C(n) = C0 * g^n` and production as
`P = baseProduction * owned * multipliers`. Exponential cost growth eventually overtakes ordinary
production growth; timed multipliers, new generators, and [[idle-game-prestige]] push the player
back into a faster section of the curve. Simulate the full economy in a spreadsheet or small test
harness before implementing it, including purchase time `C/P`, bulk purchases, upgrades, and
offline credit.

Multiple generators create decisions when their cost and production scale differently. Use the
income-to-cost ratio as a balancing diagnostic, not as a command that the human must calculate on
every click. Bulk-buy options and obvious milestone bonuses preserve readability; a perfectly
optimal but twitchy purchase sequence turns the genre into bookkeeping.

An alternative layout is a *cascade*: higher tiers produce lower-tier generators rather than the
primary currency itself. Approximating that chain continuously yields successive integrals over
time; a finite ladder approaches—but stays below—true exponential growth, so exponential costs can
still outrun production. Cascades feel good when lower tiers balloon visibly, but free auto-spawned
buildings can make manual purchases of those tiers feel worthless. Price from the *purchased*
count (not the inflated owned count) and attach a small permanent boost per purchase if you want
those buys to stay relevant.

## The catch

The visible currency total is not progression by itself. If waiting is always optimal, clicking
is cosmetic; if clicking always dominates, the game has failed to become idle. Define the active
action's purpose—accelerating early play, aiming an ability, or choosing investments—and make
automation intentionally take over the repetitive portion.

Offline progress is also a design choice. Calculate it from the same production model, record a
trusted last-save timestamp, and apply any cap as an explicit pacing decision. A silent or
arbitrary cap breaks the expectation that the economy has consistent rules.

## In practice here

This is a reusable game-design reference, not a claim that [[minecwaft]] is a clicker game. A
future incremental project should build an editable economy model before content production and
link its tuning sheet or simulator here.
