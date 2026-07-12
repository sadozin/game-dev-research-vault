---
title: Event bus messaging
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[gameplay-motion-and-architecture]]"
tags: [game-development, architecture, gameplay]
---

# Event bus messaging

An event bus routes named messages between publishers and subscribers without requiring a direct
reference between every participating system.

## Why it works

Events decouple producers from reactions such as UI, audio, quests, telemetry, and effects, making
cross-cutting responses easier to add.

## The catch

Hidden subscribers, unclear ordering, stale listeners, and broad event payloads create invisible
coupling. A bus can become a global dependency soup instead of a boundary.

## In practice

Scope buses, define ownership and lifetime, keep payloads stable, document ordering, and use direct
interfaces for synchronous invariants.

