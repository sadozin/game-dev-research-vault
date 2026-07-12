---
title: Unity Animation Rigging
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[unity-movement-content-and-audio]]"
tags: [game-development, unity, animation]
---

# Unity Animation Rigging

Animation Rigging applies runtime constraints such as two-bone IK, aim, and multi-parent relationships
to an authored animation hierarchy.

## Why it works

Constraints adapt feet, hands, weapons, and aim to changing gameplay conditions without requiring a
separate clip for every pose.

## The catch

Constraint evaluation costs CPU and can expose unreachable targets, conflicting weights, or unstable
contact points. A rig can make an authored animation worse when its targets are noisy.

## In practice

Filter targets, clamp reach, blend weights, and keep a clean authored fallback for failed contacts.

