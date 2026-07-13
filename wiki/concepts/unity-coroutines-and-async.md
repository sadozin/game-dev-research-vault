---
title: Unity coroutines and async workflows
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[unity-lifecycle-serialization-architecture]]"
tags: [game-development, unity, programming]
---

# Unity coroutines and async workflows

Coroutines schedule resumable work through Unity’s player loop; async workflows represent completion
of operations that may use tasks, threads, or engine-specific awaitables.

## Why it works

Coroutines make frame-spanning gameplay readable, while async abstractions compose I/O and cancellation
without manually polling every operation.

## The catch

Neither automatically makes code run off the main thread. Cancellation, object destruction, exception
handling, and thread affinity can turn a convenient sequence into a leaked or invalid callback.

## In practice

Choose by lifetime and execution domain, propagate cancellation, and marshal engine API work back to
the main thread explicitly.

