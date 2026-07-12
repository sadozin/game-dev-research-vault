---
title: Economy sinks and faucets
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[ludgate-mmo-faucets]]"
  - "[[virtual-currency-endowments-experiment]]"
tags: [game-development, game-design, economy, mmo, monetization]
---

# Economy sinks and faucets

A faucet creates currency or resources from the game system; a sink removes them or makes them
unavailable for future spending. Quests, enemy drops, and offline rewards are faucets. Vendor fees,
crafting costs, repairs, taxes, upgrades, and destruction are sinks. Player-to-player trades mostly
transfer currency, so they do not replace sinks in a persistent [[mmo-class-economics]] economy.

## Why it works

Tracking source and destination flows gives a designer a control surface for inflation and progression.
Faucets fund activity and make rewards feel valuable; sinks preserve scarcity and create decisions for
surplus resources. A healthy economy balances flows by resource and cohort rather than assuming that
one global gold total explains every market.

## The catch

Equal nominal inflow and outflow can still fail when timing, hoarding, bots, new-player grants, or
wealth concentration differ. A sink that is mandatory and too large feels like a tax; a cosmetic or
optional sink may not absorb enough currency. Increasing supply can raise prices and even increase
players' willingness to buy more currency, so a short-term engagement lift can worsen long-term
inflation.

## In practice here

Instrument every creation, destruction, transfer, balance, and source cohort. Track velocity, median
and percentile balances, prices, sinks by category, and new-player purchasing power. Prefer sinks that
create useful choices—crafting, customization, convenience, or prestige—over arbitrary fees, and
simulate new content's faucet before adding its rewards. Revisit the balance after exploits, events,
and population changes rather than tuning to launch-day totals.
