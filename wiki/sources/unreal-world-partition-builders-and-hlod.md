---
title: "Source: Epic — World Partition Builders and HLODs"
type: source
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "https://dev.epicgames.com/documentation/en-us/unreal-engine/world-partition-builder-commandlet-reference"
  - "https://dev.epicgames.com/documentation/en-us/unreal-engine/world-partition---hierarchical-level-of-detail-in-unreal-engine"
tags: [source, game-development, unreal, streaming, optimization]
---

# Source: Epic — World Partition Builders and HLODs

- **Author:** Epic Games
- **Published:** Undated (Unreal Engine 5.8 documentation)
- **URL:** https://dev.epicgames.com/documentation/en-us/unreal-engine/world-partition-builder-commandlet-reference
- **Retrieved:** 2026-07-11

## Summary

Epic's builder commandlet framework processes World Partition data without loading an entire large
world at once. It supports tasks such as HLOD generation and navigation-data building, while HLOD
Layers control how distant cell content becomes proxy actors. This makes derived-data generation
repeatable and moves expensive work out of runtime, but leaves cell sizing and source configuration as
runtime responsibilities.

## Compiled into

- [[unreal-world-partition]] — HLOD preparation, batch processing, and the runtime/build-time boundary
