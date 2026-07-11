---
title: "Source: Unity Manual — target-device profiling"
type: source
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "raw/unity-profiling-target-device.md"
tags: [source, optimization, profiling]
---

# Source: Unity Manual — target-device profiling

- **Author:** Unity Technologies
- **Published:** Unity 2022.2 Manual
- **URL:** https://docs.unity3d.com/2022.2/Documentation/Manual/profiler-profiling-applications.html
- **Retrieved:** 2026-07-11
- **Raw:** `raw/unity-profiling-target-device.md` (provenance only)

## Summary

The central profiling rule is engine-independent: measure a release-like development build on the
hardware and platform that will ship. Editor play-mode profiling is useful for rapid iteration,
but shares resources with the editor and consequently produces distorted CPU, GPU, memory, and
render timing. A measured improvement must return to the target device for validation.

Profiling instrumentation also has a cost. Unity's deep profiling adds overhead, so broad traces
should identify the suspect subsystem first; expensive detail capture should then be used briefly
to explain that bottleneck.

## Compiled into

- [[game-performance-profiling]] — repeatable measure-change-validate loop
- [[frame-pacing]] — evaluate frame-time distribution on the target device
