---
title: Unreal Insights profiling
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[unreal-build-profiling-and-platforms]]"
tags: [game-development, unreal, optimization]
---

# Unreal Insights profiling

Unreal Insights analyzes engine traces across threads, CPU scopes, loading, memory, and other runtime
events.

## Why it works

Trace timelines connect spikes to phases and dependencies, making it possible to compare a hitch’s
game thread, render thread, task work, and asset loading rather than optimizing a single counter.

## The catch

Tracing adds overhead and large traces can obscure the relevant interval. A profile from the editor or
wrong hardware may describe tooling rather than the shipped experience.

## In practice

Capture targeted windows on representative builds, annotate important gameplay phases, and verify a
proposed fix with the same trace dimensions.

