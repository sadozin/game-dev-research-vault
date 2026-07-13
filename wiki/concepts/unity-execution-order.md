---
title: Unity execution order
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[unity-lifecycle-serialization-architecture]]"
tags: [game-development, unity, gameplay]
---

# Unity execution order

Unity execution order is the lifecycle relationship among initialization, enablement, fixed updates,
frame updates, rendering callbacks, and destruction.

## Why it works

Explicit phases let systems establish references before use and keep physics work in fixed steps while
presentation follows frames. Script Execution Order can resolve deliberate dependencies.

## The catch

Scene loading, inactive objects, additive scenes, and runtime instantiation make local assumptions
fragile. A script’s `Start` order is not a general dependency-injection system.

## In practice

Keep initialization idempotent, express dependencies through explicit bootstrapping, and reserve
execution-order overrides for documented cross-system contracts.

