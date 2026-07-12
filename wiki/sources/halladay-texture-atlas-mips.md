---
title: "Source: Halladay — Minimizing mip-map artifacts in atlased textures"
type: source
status: active
created: 2026-07-12
updated: 2026-07-12
verified: 2026-07-12
sources:
  - "https://kylehalladay.com/blog/tutorial/2016/11/04/Texture-Atlassing-With-Mips.html"
tags: [source, optimization, textures, rendering]
---

# Source: Halladay — Minimizing mip-map artifacts in atlased textures

- **Author:** Kyle Halladay
- **Published:** 2016-11-04
- **URL:** https://kylehalladay.com/blog/tutorial/2016/11/04/Texture-Atlassing-With-Mips.html
- **Retrieved:** 2026-07-12

## Summary

Texture atlasing is common for fewer binds and better batching on constrained hardware, but 3D
atlases that generate mips by halving the whole sheet average neighbouring charts together. Distant
objects then show colour bleed from adjacent sub-textures—an artifact invisible at full resolution.
A practical atlasser is a packer plus a blitter: the packer places sub-rects (for example MaxRects);
the blitter must not stop at a plain copy if mips will be used.

Mitigations the article develops: leave padding between charts; treat padding as *inner* margin so
artist size budgets stay legible; extend each chart’s edge colours into that padding (edge bleed);
fill empty atlas texels from the nearest chart so low mips do not sample clear/black; clamp wrap
mode on the atlas; and optionally bias mips away from the worst levels. Even then the lowest mips
can still mix charts, so padding alone is not a complete fix. The post also warns against feeding
already-compressed engine imports into a second compression pass when building the atlas offline.

## Compiled into

- [[texture-atlasing]] — mip bleeding, padding, edge bleed, and packing limits
