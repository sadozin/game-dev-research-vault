---
title: Virtual texturing
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[unreal-virtual-texturing]]"
  - "[[unity-streaming-virtual-texturing]]"
tags: [game-development, optimization, rendering, textures]
---

# Virtual texturing

Virtual texturing presents a very large logical texture while keeping only the tiles currently needed
in a smaller physical cache. A page table or indirection lookup maps virtual UVs to resident tiles;
feedback from sampling tells the streamer which pages to load. It extends
[[mipmapping-and-texture-streaming]] from whole-texture mip residency to spatially selective residency,
which is especially useful for large terrain, lightmaps, UDIMs, and layered materials.

## Why it works

The renderer samples an indirection structure first, then reads the mapped page from the physical
cache. Missing pages generate feedback, and an asynchronous loader uploads them from disk or produces
them on the GPU. Streaming virtual texturing uses cooked texels; runtime virtual texturing writes or
composites texels on demand. Both let virtual resolution grow without making every high-resolution
texel resident at once, so the physical cache can be budgeted by view and frame.

## The catch

Virtual texturing adds indirection, feedback passes, page-table memory, tile borders, cache management,
and at least one frame of residency latency. A camera cut or aggressive mip bias can request more
pages than the cache can hold, causing thrashing or visible low-resolution pages. Tile borders consume
extra memory for filtering, and materials sampled from unsupported shader stages or used in special
render paths may not generate useful feedback. It is not automatically cheaper for small textures or
scenes whose ordinary mip streamer already fits comfortably.

## In practice here

Use it for large, frequently visible surfaces where whole-mip streaming wastes memory. Choose tile and
border sizes with anisotropic filtering in mind, group textures sampled with the same UVs when the
engine supports stacks, and leave cache headroom for camera cuts and transient pages. Test fast pans,
teleports, grazing angles, and material changes while watching page faults and cache occupancy in
[[game-performance-profiling]]. Keep ordinary textures on conventional streaming when their residency
pattern is simple; virtualize the expensive outliers rather than making every asset pay the feedback
and indirection cost.
