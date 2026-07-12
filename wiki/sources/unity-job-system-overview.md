---
title: "Source: Unity — Job system overview"
type: source
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "https://docs.unity3d.com/cn/2022.3/Manual/JobSystemOverview.html"
tags: [source, game-development, unity, optimization, jobs]
---

# Source: Unity — Job system overview

- **Author:** Unity Technologies
- **Published:** Unity 2022.3 manual
- **URL:** https://docs.unity3d.com/cn/2022.3/Manual/JobSystemOverview.html
- **Retrieved:** 2026-07-11

## Summary

Unity's Job System schedules multithreaded work across available CPU cores. Unity recommends combining
it with Burst for improved code generation and lower battery use, and notes that Jobs can be used
independently or with ECS for data-oriented code. The system's value depends on enough independent work
to amortize scheduling and synchronization overhead.

## Compiled into

- [[unity-dots-jobs-and-burst]] — parallel scheduling, Burst pairing, and workload sizing
