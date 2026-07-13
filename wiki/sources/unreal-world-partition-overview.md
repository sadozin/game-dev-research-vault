---
title: "Source: Epic — World Partition"
type: source
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "https://dev.epicgames.com/documentation/en-us/unreal-engine/world-partition-in-unreal-engine"
tags: [source, game-development, unreal, streaming]
---

# Source: Epic — World Partition

- **Author:** Epic Games
- **Published:** Undated (Unreal Engine 5.8 documentation)
- **URL:** https://dev.epicgames.com/documentation/en-us/unreal-engine/world-partition-in-unreal-engine
- **Retrieved:** 2026-07-11

## Summary

Epic describes World Partition as a single persistent level divided into configurable runtime grid
cells. Streaming sources load and unload cells by distance; Player Controllers are sources by default,
and additional sources can support locations such as teleports. Actors can be spatially loaded or
always loaded, and One File Per Actor stores actors independently for source-control collaboration.

## Compiled into

- [[unreal-world-partition]] — grid streaming, sources, actor residency, and collaboration boundaries
