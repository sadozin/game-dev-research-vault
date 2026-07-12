---
title: "Source: Epic — Viewport Modes: Shader Complexity"
type: source
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "https://dev.epicgames.com/documentation/unreal-engine/viewport-modes-in-unreal-engine"
tags: [source, game-development, optimization, rendering, unreal]
---

# Source: Epic — Viewport Modes: Shader Complexity

- **Author:** Epic Games
- **Published:** Undated (Unreal Engine 5.8 documentation)
- **URL:** https://dev.epicgames.com/documentation/unreal-engine/viewport-modes-in-unreal-engine
- **Retrieved:** 2026-07-11

## Summary

Unreal's Shader Complexity view visualizes the instruction count used to calculate each pixel, with
colors moving from inexpensive to expensive. Epic cautions that instruction count is only an
indication: texture lookups can be slower than arithmetic, and loops may not be represented exactly.
The view is therefore a practical hotspot finder, not a substitute for GPU timing on the target
platform.

## Compiled into

- [[overdraw-and-transparency-cost]] — why screen-space diagnostics must be paired with real profiling
