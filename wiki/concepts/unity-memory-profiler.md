---
title: Unity Memory Profiler
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[unity-memory-profiler-docs]]"
tags: [game-development, unity, optimization]
---

# Unity Memory Profiler

Memory profiling explains which managed objects, native allocations, assets, and graphics resources
keep memory alive at a captured point in a running game.

## Why it works

Snapshots provide ownership and comparison context: a rising total becomes actionable when a retained
asset, duplicate object graph, or native allocation is visible.

## The catch

A snapshot is not a continuous trace. Captures cost time and memory, and platform allocators or GPU
drivers may hide the real high-water mark.

## In practice

Capture on target hardware at reproducible checkpoints, compare before/after scene transitions, and
pair snapshots with runtime memory and frame-time telemetry.
