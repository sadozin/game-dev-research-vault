---
title: Impostors and billboards
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[rendering-effects-and-animation]]"
tags: [game-development, rendering, lod]
---

# Impostors and billboards

Impostors and billboards replace distant 3D geometry with camera-facing or view-dependent representations.

## Why it works

Far objects can keep visual presence with fewer vertices, materials, and animation updates, extending
scene scale within a fixed rendering budget.

## The catch

View transitions, silhouettes, lighting direction, parallax, and alpha sorting reveal the illusion.
One billboard angle is especially fragile for oblique cameras or VR.

## In practice

Choose capture angles and transition distances from camera behavior, fade or blend representations, and
keep collision and gameplay proxies independent.

