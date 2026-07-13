---
title: Animation compression
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[unity-animation-compression]]"
tags: [game-development, animation, optimization]
---

# Animation compression

Animation compression reduces clip storage and streaming cost by quantizing, removing, or sharing
motion data within an error tolerance.

## Why it works

Rotation and position tracks usually contain redundancy; key reduction and quantization preserve the
motion envelope while shrinking memory and bandwidth. Compression also improves cache behavior.

## The catch

Small numeric errors accumulate visibly in feet, hands, and additive layers. Aggressive reduction can
save memory while causing foot sliding or broken contacts that are expensive to diagnose from a clip.

## In practice

Set tolerances by body part, inspect representative clips at runtime, and measure decompression cost
as well as asset size.

