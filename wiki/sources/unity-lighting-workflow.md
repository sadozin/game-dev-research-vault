---
title: "Source: Unity — lighting workflow"
type: source
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "raw/unity-lighting-workflow.md"
tags: [source, 3d, lighting]
---

# Source: Unity — lighting workflow

- **Author:** Unity Technologies
- **Published:** Unity 6.5 Manual
- **URL:** https://docs.unity3d.com/Manual/lighting-configuration-workflow.html
- **Retrieved:** 2026-07-11
- **Raw:** `raw/unity-lighting-workflow.md` (provenance only)

## Summary

Unity's lighting workflow starts by choosing a render pipeline and a GI strategy—baked, realtime,
mixed, or none—then adds the corresponding light, reflection-probe, and light-probe setup. The
choice determines both visual behavior and runtime cost; dynamic objects need probe-based data to
belong convincingly in a baked scene.

## Compiled into

- [[real-time-lighting-budget]] — decide which lighting must be dynamic
- [[vrchat-homeworld]] — existing baked-world workflow context
