---
title: Unity CharacterController versus Rigidbody
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[unity-movement-content-and-audio]]"
tags: [game-development, unity, physics, movement]
---

# Unity CharacterController versus Rigidbody

CharacterController provides collision-constrained kinematic movement; Rigidbody participates in the
physics simulation and responds to forces.

## Why it works

The controller gives direct character-gameplay control without solving a full body, while Rigidbody
supports physical interaction, impulses, and solver-driven motion.

## The catch

Mixing authority between them causes tunneling, jitter, or duplicated movement. A controller does not
automatically behave like a physical body, and a Rigidbody does not guarantee responsive platforming.

## In practice

Choose the movement authority per actor, integrate it in the appropriate update phase, and define how
moving platforms, slopes, pushes, and network corrections cross the boundary.

