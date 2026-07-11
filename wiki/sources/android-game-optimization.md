---
title: "Source: Android Developers — game optimization"
type: source
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "raw/android-game-optimization.md"
tags: [source, optimization, android, frame-pacing]
---

# Source: Android Developers — game optimization

- **Author:** Android Developers
- **Published:** Continuously maintained documentation
- **URL:** https://developer.android.com/games/optimize/overview
- **Retrieved:** 2026-07-11
- **Raw:** `raw/android-game-optimization.md` (provenance only)

## Summary

Android's game guidance treats profiling, device capability, thermal state, memory, and frame
pacing as one system. Its tools cover GPU traces, system traces, CPU activity, memory snapshots,
and per-device quality or loading data; the important pattern is to select the tool that can
prove the suspected bottleneck rather than optimising from intuition.

The tracing guidance separates load time, CPU scheduling, render submission, GPU wait, I/O, and
presentation timing. It recommends lazy loading and smaller assets for load speed, and identifies
late frames or an overfull buffer queue as visible stutter even when average FPS looks acceptable.
The Android-specific APIs are not portable, but the diagnostic model applies to every real-time
engine, including Vulkan clients.

## Compiled into

- [[game-performance-profiling]] — choose traces that answer a specific bottleneck question
- [[frame-pacing]] — smooth presentation rather than average-FPS chasing
