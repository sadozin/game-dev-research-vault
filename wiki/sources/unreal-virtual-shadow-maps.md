---
title: "Source: Epic — Virtual Shadow Maps"
type: source
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "https://dev.epicgames.com/documentation/unreal-engine/virtual-shadow-maps-in-unreal-engine"
tags: [source, game-development, optimization, rendering, lighting, unreal]
---

# Source: Epic — Virtual Shadow Maps

- **Author:** Epic Games
- **Published:** Undated (Unreal Engine 5.8 documentation)
- **URL:** https://dev.epicgames.com/documentation/unreal-engine/virtual-shadow-maps-in-unreal-engine
- **Retrieved:** 2026-07-11

## Summary

Epic's Virtual Shadow Maps use high-resolution shadow maps divided into 128-by-128 pages. Pages are
allocated and rendered for on-screen pixels, then cached between frames until moving lights, casters,
camera disocclusion, or material deformation invalidate them. The method fits Nanite and large dynamic
worlds, but fast movement, camera cuts, and per-frame deformation can make page invalidation dominate
the expected savings.

## Compiled into

- [[shadow-map-budgeting]] — tiled shadow residency and cache-invalidation costs
