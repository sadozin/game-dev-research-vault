---
title: "Source: VRChat — avatar optimization tips"
type: source
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "raw/vrchat-avatar-optimization-tips.md"
tags: [source, vrchat, optimization]
---

# Source: VRChat — avatar optimization tips

- **Author:** VRChat
- **Published:** Creator documentation
- **URL:** https://creators.vrchat.com/avatars/avatar-optimizing-tips/
- **Retrieved:** 2026-07-11
- **Raw:** `raw/vrchat-avatar-optimization-tips.md` (provenance only)

## Summary

VRChat recommends minimizing skinned meshes and material slots because both create rendering
cost, using texture atlases to remove submeshes, and controlling texture memory rather than only
download size. The guide recommends avoiding tessellation and unnecessary transparency, keeping
avatar lights off, and preferring PhysBones over deprecated Dynamic Bones. It also advises keeping
Unity Cloth use very limited.

Quest/mobile budget must be designed into the source avatar rather than achieved by destructive
late decimation. The guide advises one skinned renderer and, where practical, merging accessories
into the source mesh in Blender.

## Compiled into

- [[vrchat-avatar-optimization]] — render, texture, and shader cost
- [[vrchat-clothing-workflow]] — clothes as a planned part of the source avatar
