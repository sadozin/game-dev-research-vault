---
title: "Source: Epic — Shadowing in Unreal Engine"
type: source
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "https://dev.epicgames.com/documentation/unreal-engine/shadowing-in-unreal-engine?lang=en-US"
tags: [source, game-development, optimization, rendering, lighting, unreal]
---

# Source: Epic — Shadowing in Unreal Engine

- **Author:** Epic Games
- **Published:** Undated (Unreal Engine 5.8 documentation)
- **URL:** https://dev.epicgames.com/documentation/unreal-engine/shadowing-in-unreal-engine?lang=en-US
- **Retrieved:** 2026-07-11

## Summary

Epic describes cascaded shadow maps as distance-based splits of the camera frustum: near cascades
receive higher quality while far cascades cover a wider area at lower detail. The directional-light
settings expose cascade count, maximum distance, distribution, and transition. Epic also emphasizes
that shadow-map resolution, light radius, cast-shadow selection, and draw distance are direct quality
and performance controls.

## Compiled into

- [[shadow-map-budgeting]] — cascade, distance, caster, and resolution choices
