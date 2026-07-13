---
title: "Source: Epic — Lumen Technical Details"
type: source
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "https://dev.epicgames.com/documentation/en-us/unreal-engine/lumen-performance-guide-for-unreal-engine"
  - "https://dev.epicgames.com/documentation/en-us/unreal-engine/lumen-global-illumination-and-reflections-in-unreal-engine"
tags: [source, game-development, unreal, rendering, optimization]
---

# Source: Epic — Lumen Technical Details

- **Author:** Epic Games
- **Published:** Undated (Unreal Engine 5.8 documentation)
- **URL:** https://dev.epicgames.com/documentation/en-us/unreal-engine/lumen-performance-guide-for-unreal-engine
- **Retrieved:** 2026-07-11

## Summary

Epic's performance guidance frames Lumen as a fixed part of the frame budget rather than an
unbounded quality switch: its console scalability levels target approximately 30 or 60 fps at a
1080p internal workload, with temporal upsampling used for higher output resolutions. The settings
raise quality and reduce noise at increased GPU cost. The related settings documentation distinguishes
software tracing through mesh distance fields from hardware tracing, and calls out scene-update costs,
distance-field memory, reflection roughness thresholds, and high-quality translucency as practical
cost controls.

## Compiled into

- [[unreal-lumen]] — tracing modes, scalability, quality costs, and platform planning
