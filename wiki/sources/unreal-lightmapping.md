---
title: "Source: Epic — Understanding Lightmapping in Unreal Engine"
type: source
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "https://dev.epicgames.com/documentation/en-us/unreal-engine/understanding-lightmapping-in-unreal-engine"
tags: [source, game-development, rendering, lighting, assets, unreal]
---

# Source: Epic — Understanding Lightmapping in Unreal Engine

- **Author:** Epic Games
- **Published:** Undated (Unreal Engine 5.8 documentation)
- **URL:** https://dev.epicgames.com/documentation/en-us/unreal-engine/understanding-lightmapping-in-unreal-engine
- **Retrieved:** 2026-07-11

## Summary

Epic describes a lightmap UV as a dedicated layout for baked lighting and shadows. Each face needs
unique space, charts must not overlap, and padding limits bleed at the target resolution. The lightmap
resolution controls the baked texture size for a static mesh; higher resolution can hide artifacts but
raises memory cost, while thoughtful chart continuity and coverage often produce better results at a
lower resolution.

## Compiled into

- [[lightmap-baking-and-uv2]] — the purpose, layout rules, and resolution tradeoff
