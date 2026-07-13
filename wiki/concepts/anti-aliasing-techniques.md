---
title: Anti-aliasing techniques
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[unity-rendering-paths-antialiasing]]"
tags: [game-development, rendering, optimization]
---

# Anti-aliasing techniques

Anti-aliasing reduces visible sampling error at geometric and shading edges.

## Why it works

MSAA samples coverage, post-process methods detect and filter edges, and temporal methods reuse
history to improve subpixel stability. Each spends a different combination of bandwidth, motion
vectors, and shader work.

## The catch

No method fixes every artifact: TAA can ghost, FXAA can blur, and MSAA costs more with deferred
lighting or heavy transparency. Resolution and content determine the useful choice.

## In practice

Choose after profiling representative foliage, particles, UI, and motion—not from a still screenshot.

