---
title: Unity Addressables
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[unity-addressables-manual]]"
  - "[[unity-addressables-catalogs]]"
tags: [game-development, unity, assets, memory, streaming]
---

# Unity Addressables

Unity Addressables lets a game request an asset by address while the system resolves its dependencies
and loads from local or remote content asynchronously. It provides an asset-bundle workflow with
catalogs, groups, handles, and release operations, useful for reducing startup content and delivering
updates without rebuilding the whole player.

## Why it works

An address decouples gameplay code from an asset's physical location. Catalogs map keys to bundles and
dependencies; async operations let loading overlap with gameplay or transitions. Remote catalogs and
content update builds can point a shipped player at changed bundles, while reference-counted handles
keep shared dependencies alive until all users release them.

## The catch

Addressables does not remove memory management or deployment complexity. A forgotten handle keeps an
asset and its dependencies resident; releasing too early can invalidate a consumer. Bundle boundaries
can duplicate dependencies or create download and load spikes, and catalog updates can conflict with
already loaded bundles unless the update strategy accounts for bundle identity and lifetime. Remote
content also adds cache, versioning, failure, and offline behavior that local testing may hide.

## In practice here

Group assets by loading lifetime and update cadence, not only by folder. Wrap handles in ownership that
releases exactly once, preload before a visible transition, and test cold cache, warm cache, failed
download, catalog update, and scene unload. Inspect bundle dependency graphs and peak residency with
[[game-performance-profiling]] and [[platform-memory-budgets]]; asynchronous loading is useful only if
the resulting lifetime and memory behavior are explicit.
