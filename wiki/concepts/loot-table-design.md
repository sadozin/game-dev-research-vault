---
title: Loot Table Design
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[defining-loot-tables-arpg]]"
  - "[[gacha-pricing-pity-research]]"
tags: [game-development, design, economy, loot, progression]
---

# Loot Table Design

A loot table maps an event to weighted outcomes, often through sequential rolls for category, rarity,
item, and affixes. Good tables make rewards legible, preserve excitement, and keep expected power and
inventory volume within the progression budget.

## Why it works

Separate rolls let designers control broad rarity from specific item identity, while pity or guarantees
bound unlucky streaks. Conditional pools can match level, class, location, or activity without putting
every possible item in one opaque distribution.

## The catch

Weights are not player-perceived value: a rare junk item can feel worse than a common useful one.
Multiple rolls, duplicate protection, pity carry-over, and bundle openings change the actual distribution;
average drops conceal variance and worst-case frustration.

## In practice here

Write the roll sequence and probabilities explicitly, simulate long runs, measure duplicate and inventory
rates, and publish guarantees where spending or durable progression is involved. Treat the reward budget,
not the headline rarity, as the balancing unit.
