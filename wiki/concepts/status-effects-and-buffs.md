---
title: Status effects and buffs
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[game-design-patterns-status-effects]]"
tags: [game-development, gameplay, combat]
---

# Status effects and buffs

Status effects are time-bounded or conditional modifiers applied to an entity.

## Why it works

Explicit effect instances can own duration, source, stack count, tick interval, and removal policy.
This makes dispels, refreshes, immunity, and UI display testable rules.

## The catch

Stacking semantics are where “simple buff” systems become ambiguous: additive, multiplicative,
refreshing, and strongest-only policies produce different balance and save behavior.

## In practice

Write stacking and expiration rules before content, use monotonic server time where needed, and test
simultaneous application and removal order.

