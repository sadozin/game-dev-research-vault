---
title: "Source: VRChat — PhysBones"
type: source
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "raw/vrchat-physbones.md"
tags: [source, vrchat, physics]
---

# Source: VRChat — PhysBones

- **Author:** VRChat
- **Published:** Creator documentation, last updated 2026-06-17
- **URL:** https://creators.vrchat.com/common-components/physbones/
- **Retrieved:** 2026-07-11
- **Raw:** `raw/vrchat-physbones.md` (provenance only)

## Summary

PhysBones provide secondary motion for hair, tails, ears, and clothing, and can replace cloth-like
motion on avatars. They are not a free substitute for a clean rig: each component affects a bone
chain and has mobile limits. One component cannot affect more than 256 transforms, and the guide
recommends merging unnecessary bones into parents rather than building enormous chains.

Dynamic Bones is removed for avatars and automatically converted at load time, but the conversion
cannot perfectly reproduce every old setup. Author PhysBones directly and do not combine a
Constraint and PhysBone on the same GameObject.

## Compiled into

- [[vrchat-avatar-physics]] — author direct, bounded secondary motion
- [[vrchat-avatar-optimization]] — components and transforms are performance budget items
