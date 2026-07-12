---
title: Crafting system design
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[coster-unbroke-crafting-system]]"
  - "[[unreal-data-driven-items]]"
tags: [game-development, game-design, economy, crafting]
---

# Crafting system design

A crafting system turns gathered inputs and learned recipes into useful outputs, creating a resource
loop between exploration, progression, inventory, and economy. Its quality depends less on the number
of recipes than on whether recipes create readable choices, useful sinks, and a reason to engage with
the world beyond buying the best item directly.

## Why it works

Recipes can gate power, convert surplus materials, and connect locations or activities to player goals.
A data-driven recipe definition can express ingredients, output, station, unlock, quantity, and time
without hardcoding each item. Staged discovery lets the player learn a small actionable set, then
expand through exploration; intermediate products can make the chain itself a progression loop.

## The catch

Showing every recipe at once overwhelms players and encourages a spreadsheet-optimal rush to the best
station. Long chains can become busywork, while recipes that only convert materials at a loss feel like
taxes unless they provide meaningful choice. Crafting can also print value if output sells for more than
its inputs, or destroy value if rare ingredients are consumed by weak, obsolete outputs.

## In practice here

Expose recipes by context and unlock them at the moment they solve a problem. Give every major input a
purpose and every output a role, but provide salvage or alternate recipes for dead-end materials. Model
crafting as a source and sink with [[economy-sinks-and-faucets]], test the cheapest and most profitable
paths, and keep recipe data separate from inventory code so balance changes remain cheap.
