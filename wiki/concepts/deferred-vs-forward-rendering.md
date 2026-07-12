---
title: Deferred versus forward rendering
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[unity-rendering-paths-antialiasing]]"
tags: [game-development, rendering, optimization]
---

# Deferred versus forward rendering

Forward rendering shades objects as they are drawn; deferred rendering records surface data first
and evaluates many lights from that buffer.

## Why it works

Deferred lighting makes numerous opaque lights cheaper to reason about, while forward keeps material
and transparency paths simpler and can reduce buffer bandwidth.

## The catch

Deferred pipelines need G-buffers and special handling for transparency, MSAA, and low-end memory
budgets. Forward can pay repeatedly for lighting but often fits stylized or transparent-heavy scenes.

## In practice

Decide from light count, transparency, target bandwidth, and required material features.

