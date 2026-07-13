---
title: Ragdoll and physics animation
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[gameplay-motion-and-architecture]]"
tags: [game-development, animation, physics]
---

# Ragdoll and physics animation

Ragdoll systems replace or blend authored skeletal motion with physics-driven bodies during impacts,
death, or recovery.

## Why it works

Physics supplies reactive secondary motion and contact response that would be expensive to author for
every impact pose.

## The catch

Unstable constraints, foot penetration, sudden momentum changes, and transitions back to animation can
look worse than a controlled clip. Ragdolls also complicate replication and gameplay targeting.

## In practice

Blend impulses and constraints deliberately, capture a recoverable pose, and define which ragdoll state
is cosmetic versus authoritative.

