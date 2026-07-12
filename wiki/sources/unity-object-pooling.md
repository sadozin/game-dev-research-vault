---
title: "Source: Unity — Pooling and reusing objects"
type: source
status: active
created: 2026-07-12
updated: 2026-07-12
verified: 2026-07-12
sources:
  - "https://docs.unity3d.com/Manual/performance-reusable-code.html"
tags: [source, unity, optimization, memory]
---

# Source: Unity — Pooling and reusing objects

- **Author:** Unity Technologies
- **Published:** Unity Manual (Unity 6 docs; `UnityEngine.Pool` since Unity 2021)
- **URL:** https://docs.unity3d.com/Manual/performance-reusable-code.html
- **Also:** https://docs.unity3d.com/6000.0/Documentation/ScriptReference/Pool.ObjectPool_1.html
- **Retrieved:** 2026-07-12

## Summary

Unity documents object pooling as returning frequently used instances to a pool to cut instantiate/
destroy overhead and limit allocations that drive managed GC cost. `ObjectPool<T>` is a stack-based
main-thread pool: constructor callbacks cover create, get, release, and destroy; default capacity
and max size bound growth; optional collection checks catch double-release in the Editor.

Get activates and prepares; Release deactivates and should reset state (velocity, particles,
coroutines, events). When the pool is empty, create runs; when full on release, destroy runs.
Projectiles are the canonical example—fire with Get, self-Release after timeout or hit. The same
namespace pools collections (`List`, `Dictionary`, …) so per-frame temporary containers can be
reused. Scene unload destroys pooled GameObjects unless the pool root is kept alive carefully;
clear between levels when appropriate.

## Compiled into

- [[object-pooling]] — engine API shape, reset hooks, GC motivation, when not to over-pool
