---
title: Unreal Landscape and foliage
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[unreal-world-ui-data-online]]"
tags: [game-development, unreal, environment-art]
---

# Unreal Landscape and foliage

Unreal Landscape provides terrain authoring and streaming-oriented world surfaces; foliage tools
instance vegetation and environmental assets across that surface.

## Why it works

Artists can sculpt large terrain, layer materials, and distribute many instances without hand-placing
every object.

## The catch

Landscape layers, collision, foliage density, shadows, and streaming cells all consume budgets. A
visually dense landscape can become a memory, draw-call, or navigation problem.

## In practice

Set density and material budgets per platform, validate collision and navigation, and inspect streaming
transitions rather than judging only the editor view.

