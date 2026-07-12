---
title: MMO itemization and loot
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[unreal-data-driven-items]]"
  - "[[defining-loot-tables-arpg]]"
tags: [game-development, game-design, economy, mmo, loot]
---

# MMO itemization and loot

MMO itemization is the system that turns gear slots, base items, power budgets, rarity, affixes, and
sources into meaningful build choices. Loot generation usually separates the chance for an item from
its rarity, type, affixes, and numeric rolls. The goal is controlled variety: drops should create
decisions and long-term goals without making most rewards unreadable or automatically worthless.

## Why it works

A data-driven item definition gives the game a stable vocabulary for base type, slot, tags, and legal
affix pools; a loot table then selects and combines those pieces. Rarity can control affix count or
pool access, while item level and source context control the power range. This lets designers tune
encounters, crafting, salvage, and trading against a shared budget instead of hardcoding every drop.

## The catch

Independent rolls multiply quickly. A broad base pool, rarity roll, affix pool, and numeric range can
produce thousands of combinations, most of which may be inferior to the player's current item. If
rarity is only a higher number, upgrades become automatic and builds converge; if rare affixes are too
build-defining, progression becomes a lottery. Trade, bind rules, duplicate protection, and salvage
also change the value of every drop and can create inflation or a junk-loot problem.

## In practice here

Define a power budget per slot and content tier, constrain affix pools by item tags, and expose why an
item is valuable in the comparison UI. Simulate large batches of drops before shipping to measure
upgrade rate, duplicate rate, salvage value, and time to a viable build. Give bad drops a deterministic
exit through crafting or salvage, and keep rare build-enabling effects obtainable through more than
one path. Store item definitions and tables as data so balance changes do not require rewriting the
runtime item model.
