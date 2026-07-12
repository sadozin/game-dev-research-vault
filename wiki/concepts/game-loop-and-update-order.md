---
title: Game loop and update order
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[gameplay-motion-and-architecture]]"
tags: [game-development, architecture, simulation]
---

# Game loop and update order

The game loop advances input, simulation, physics, animation, presentation, and I/O through ordered
phases.

## Why it works

Separating fixed simulation from variable rendering improves stability, while explicit phase ownership
lets systems know when state is valid and when changes become visible.

## The catch

Unbounded work causes spirals of delay; inconsistent callback ordering creates one-frame bugs and
non-deterministic interactions. “Update” is not a universal synchronization point.

## In practice

Define phase contracts, cap accumulated work, isolate side effects, and record tick/frame identifiers
when diagnosing ordering bugs.

