---
title: "Source: Epic — Nanite Virtualized Geometry"
type: source
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "https://dev.epicgames.com/documentation/en-US/unreal-engine/nanite-virtualized-geometry-in-unreal-engine"
tags: [source, game-development, unreal, rendering, geometry]
---

# Source: Epic — Nanite Virtualized Geometry

- **Author:** Epic Games
- **Published:** Undated (Unreal Engine 5.8 documentation)
- **URL:** https://dev.epicgames.com/documentation/en-US/unreal-engine/nanite-virtualized-geometry-in-unreal-engine
- **Retrieved:** 2026-07-11

## Summary

Epic describes Nanite as an internal mesh format and renderer that analyzes meshes into hierarchical
triangle clusters, streams visible detail on demand, and handles LOD automatically. It recommends SSD
storage for runtime streaming and identifies practical limits around instances, triangles, materials,
output resolution, and hardware. Supported geometry and material paths are more restricted than the
headline promise of virtualized geometry suggests.

## Compiled into

- [[unreal-nanite]] — cluster streaming, automatic LOD, suitable workloads, and limits
