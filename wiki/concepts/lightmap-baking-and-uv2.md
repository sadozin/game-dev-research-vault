---
title: Lightmap baking and UV2
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[unreal-lightmapping]]"
  - "[[unreal-lightmap-uv-generation]]"
tags: [game-development, rendering, lighting, optimization, assets]
---

# Lightmap baking and UV2

Lightmap baking precomputes lighting and shadow information into textures that static geometry samples
at runtime. The lightmap UV set—often called UV2 in engine workflows—must give every triangle unique,
non-overlapping space inside 0–1, with padding between charts. It is a separate layout from the tiled
material UV because baked illumination cannot safely share the same texels between unrelated faces.

## Why it works

The baker evaluates static lighting once, packs the result into lightmap atlases, and turns runtime
lighting work into texture sampling. A well-packed secondary UV gives visible surfaces enough texel
density while keeping charts contiguous where smooth lighting should cross. Auto-generation can repack
an existing UV channel, then assign the result to the mesh's lightmap coordinate index.

## The catch

Padding and unique charts waste some atlas area, while too little padding causes light or shadow bleed
after filtering and mipmapping. Too little resolution produces blotchy or aliased lighting; too much
inflates build time, texture memory, and load size. Auto-generated UVs cannot invent sensible seams if
the source charts are badly split, and moving or dynamic objects cannot rely on a baked result in the
same way. Compression artifacts can also be more visible in small, high-contrast lightmaps.

## In practice here

Make the lightmap UV a deliberate asset deliverable: split charts at hard geometric changes, keep them
inside 0–1, and pad for the lowest resolution the mesh will use. Assign the correct lightmap channel,
build at target resolutions, and inspect seams under direct and indirect light. Raise resolution only
after improving chart coverage and padding; then account for the atlas cost in
[[platform-memory-budgets]] and compare against dynamic lighting with [[game-performance-profiling]].
