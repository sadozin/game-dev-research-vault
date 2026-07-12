---
title: Inverse kinematics
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[unity-animation-rigging-and-ik]]"
tags: [game-development, animation]
---

# Inverse kinematics

Inverse kinematics solves joint transforms needed to place an end effector at a target.

## Why it works

The solver adapts authored motion to terrain, held objects, and aiming targets without requiring an
animation clip for every pose.

## The catch

Targets can be unreachable, noisy, or geometrically conflicting. Unbounded weights produce foot
sliding, knee pops, or hands that pass through objects.

## In practice

Clamp reach, filter targets, blend constraints over time, and preserve authored animation as the
fallback when contact confidence is low.

