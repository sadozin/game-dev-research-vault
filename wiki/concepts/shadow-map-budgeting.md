---
title: Shadow-map budgeting
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[unreal-shadowing]]"
  - "[[unreal-virtual-shadow-maps]]"
tags: [game-development, optimization, rendering, lighting]
---

# Shadow-map budgeting

Shadow-map budgeting is deciding which lights cast dynamic shadows, how far those shadows extend,
and how much depth-map resolution and update work each receives. A directional light's cascades spend
more resolution near the camera and less at distance; local lights spend work according to radius,
casters, and update frequency. The budget is both GPU memory and the cost of rendering shadow casters
into the maps.

## Why it works

Traditional shadow mapping renders scene depth from each light, then samples that depth during the
lighting pass. Cascaded shadow maps split the camera frustum into distance ranges so a fixed map
resolution is concentrated where pixels are larger on screen. Virtual Shadow Maps take a tiled version
of the same idea: pages are rendered and cached only where visible, reducing wasted work in sparse
views. Baked lightmaps, distance fields, and contact shadows can cover cheaper portions of the range.

## The catch

More cascades and higher resolution improve detail but multiply caster rendering, memory, filtering,
and cache invalidation. Large shadow distances waste quality on off-screen or tiny objects, while
small distances create obvious transitions. Moving lights, animated casters, world-position offsets,
and camera cuts invalidate cached pages and can turn a steady budget into a spike. Bias and filtering
hide acne and peter-panning at different costs; no setting removes the underlying precision tradeoff.

## In practice here

Start with a near-camera dynamic distance and one or two cascades, then add range only when a visible
gameplay or readability requirement justifies it. Cull small and distant casters, disable shadows from
lights that contribute little, and use proxy or baked shadows for stable distant geometry. Compare
traditional cascades, virtual pages, distance fields, and baked lighting using GPU captures and
[[game-performance-profiling]]; tune on the target resolution rather than by editor appearance alone.
