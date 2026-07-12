---
title: Screen-space reflections
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[rendering-effects-and-animation]]"
tags: [game-development, rendering, optimization]
---

# Screen-space reflections

Screen-space reflections approximate reflective light by tracing the already-rendered depth and color
buffers in screen space.

## Why it works

The technique can add convincing wet floors, glass, and polished surfaces without a separate reflection
capture for every view.

## The catch

Off-screen objects, disocclusion, thin geometry, and rough reflections produce holes, popping, or noisy
fallbacks. Ray steps and history resolve also cost bandwidth and shader time.

## In practice

Provide probes or environment fallbacks, limit quality by roughness and distance, and profile at the
target resolution with camera motion.

