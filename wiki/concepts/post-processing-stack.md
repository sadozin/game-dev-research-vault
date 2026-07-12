---
title: Post-processing stack
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[unity-render-pipelines-tonemapping]]"
tags: [game-development, rendering, optimization]
---

# Post-processing stack

Post-processing applies screen-space image operations after or between rendering stages.

## Why it works

Bloom, exposure, tone mapping, color grading, and depth effects can give a scene a coherent display
transform without changing every material or light.

## The catch

Effects consume bandwidth and can require full-resolution buffers, history, depth, or motion vectors.
Stack order changes meaning: bloom before tone mapping is not the same as bloom after it.

## In practice

Treat the stack as a budgeted pipeline, disable effects by platform tier, and profile at native
resolution with representative transparencies and UI.

