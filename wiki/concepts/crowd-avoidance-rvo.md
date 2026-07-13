---
title: Crowd avoidance with RVO
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[gameplay-motion-and-architecture]]"
tags: [game-development, ai, navigation]
---

# Crowd avoidance with RVO

Reciprocal velocity obstacles choose locally safe velocities by predicting how nearby agents share
responsibility for avoiding collisions.

## Why it works

Agents can steer around one another in real time without recomputing a full global path for every small
movement change.

## The catch

Local avoidance can deadlock in doors, oscillate in dense crowds, or violate formation and gameplay
intent. It does not solve global navigation or heterogeneous agent priorities.

## In practice

Combine a global path with bounded local steering, define priority and fallback behavior, and test
doorways, obstacles, and high-density crossings.

