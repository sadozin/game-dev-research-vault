---
title: "Source: Epic — Texture Streaming Metrics"
type: source
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "https://dev.epicgames.com/documentation/unreal-engine/texture-streaming-metrics-in-unreal-engine"
tags: [source, game-development, optimization, memory, rendering, unreal]
---

# Source: Epic — Texture Streaming Metrics

- **Author:** Epic Games
- **Published:** Undated (Unreal Engine 5.8 documentation)
- **URL:** https://dev.epicgames.com/documentation/unreal-engine/texture-streaming-metrics-in-unreal-engine
- **Retrieved:** 2026-07-11

## Summary

Unreal's streaming metrics distinguish the total texture pool from the streaming, wanted, visible,
hidden, forced, cached, temporary, and safety portions inside it. The safety pool absorbs unexpected
non-streaming fluctuations; the temporary pool covers allocations made while resizing textures; and
the streaming pool is what remains for resident mip data. If required mips exceed the pool, the
streamer compromises on resolution. A safety pool that is too small can cause repeated budget
adaptation and streaming cycles, while a temporary pool that is too large wastes memory.

## Compiled into

- [[platform-memory-budgets]] — budgeting categories and the tradeoff between headroom and residency
