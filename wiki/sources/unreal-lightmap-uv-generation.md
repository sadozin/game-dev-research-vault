---
title: "Source: Epic — Generating Lightmap UVs"
type: source
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "https://dev.epicgames.com/documentation/en-us/unreal-engine/generating-lightmap-uvs-in-unreal-engine"
tags: [source, game-development, rendering, lighting, assets, unreal]
---

# Source: Epic — Generating Lightmap UVs

- **Author:** Epic Games
- **Published:** Undated (Unreal Engine 5.8 documentation)
- **URL:** https://dev.epicgames.com/documentation/en-us/unreal-engine/generating-lightmap-uvs-in-unreal-engine
- **Retrieved:** 2026-07-11

## Summary

Unreal can repack a source UV into a destination lightmap channel, but the generator does not split
chart edges; the quality of the result is constrained by the source layout. Its minimum lightmap
resolution setting determines padding needed for texel-accurate packing, while the destination channel
is selected as the mesh's lightmap coordinate index. The workflow is convenient, but custom UVs remain
necessary when source seams or coverage are unsuitable.

## Compiled into

- [[lightmap-baking-and-uv2]] — UV2 generation, padding, and channel assignment
