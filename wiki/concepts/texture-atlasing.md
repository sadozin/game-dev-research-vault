---
title: Texture atlasing
type: concept
status: active
created: 2026-07-12
updated: 2026-07-12
verified: 2026-07-12
sources:
  - "[[unity-texture-atlasing]]"
  - "[[halladay-texture-atlas-mips]]"
tags: [game-development, optimization, rendering, textures]
---

# Texture atlasing

A texture atlas packs several smaller images into one larger texture so many meshes or sprites can
share a single material. Atlasing is the texture-side of the material-sharing rule that makes
[[draw-call-batching]] work: objects only batch when they share render state, and different albedo
maps usually force different materials unless those maps live in one atlas with remapped UVs.

## Why it works

Each unique material tends to force at least one more batch or render-state change. If two assets
differ only by which texture they sample, combining those textures into one sheet lets them use one
material asset and one GPU texture bind. Engines formalise the 2D case as sprite atlases—Unity
documents packing sprites into a single atlas texture so many sprites can share a draw—and the same
idea applies to 3D props, UI, and avatar outfit pieces that would otherwise each own a material slot.

Packing is a build-time layout problem: a bin-packer places sub-rects; a blit copies pixels; UVs
are rewritten into the packed rectangles. Platform max texture size caps how many charts fit one
sheet, so large sets may need several atlases rather than one giant texture. When [[level-of-detail]]
and atlasing both apply, keep mip-safe padding in the layout so distant samples stay correct.

## The catch

Naive atlases fight mipmaps. Each mip level averages neighbouring texels of the *whole* sheet, so
adjacent sub-textures bleed into each other at distance—bright edges pick up dark neighbours and
look wrong long before the full-res view does. Padding between charts helps only the higher mips;
edge bleeding (extend chart border colours into the padding) and filling empty atlas space with
nearest-chart colours push the failure further down. The lowest mips can still mix charts no matter
how much padding you afford, so some pipelines bias away from the worst levels or generate custom
mips. Atlasing also trades artist flexibility for batching: unique wrap modes, independent
compression settings, and late per-object recolour via material clones all fight a shared sheet.
Confirm the frame is actually CPU-bound on submissions during [[game-performance-profiling]] before
merging everything—SRP Batcher-style paths can reduce the pressure to atlas purely for batch count,
but material-slot and texture-memory budgets (for example in [[vrchat-avatar-optimization]]) still
reward fewer unique maps.

## In practice here

When [[draw-call-batching]] or [[vrchat-avatar-optimization]] says "atlas textures," treat that as
this workflow: merge compatible maps, remesh UVs into the packed rects, leave mip-aware padding, and
measure material-slot count and texture memory after the change—not only the source file size.
Separate sheets by usage (opaque vs transparent, UI vs world) so one chart’s filter or wrap needs do
not poison the rest.
