---
title: Unreal Chaos physics
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[unreal-chaos-physics-docs]]"
tags: [game-development, unreal, physics]
---

# Unreal Chaos physics

Chaos is Unreal’s physics and destruction framework for rigid bodies, constraints, vehicles, and
fractured geometry.

## Why it works

The solver provides collision, constraints, and simulation tools that can drive convincing interactions
without hand-integrating every body.

## The catch

Physics is timestep-, collision-, and solver-budget dependent. Destruction and many dynamic bodies can
consume CPU, memory, and replication bandwidth while remaining difficult to reproduce exactly.

## In practice

Use simple collision where possible, cap physical complexity, separate cosmetic destruction from
authoritative gameplay, and test bad-contact and sleep/wake cases.
