---
title: "Source: Microsoft — Resource Limits (Direct3D 11)"
type: source
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "https://learn.microsoft.com/en-us/windows/win32/direct3d11/overviews-direct3d-11-resources-limits"
tags: [source, rendering, textures]
---

# Source: Microsoft — Resource Limits (Direct3D 11)

- **Author:** Microsoft (Win32 / Direct3D 11 documentation)
- **Published:** Microsoft Learn; page last updated 2025-03-11
- **URL:** https://learn.microsoft.com/en-us/windows/win32/direct3d11/overviews-direct3d-11-resources-limits
- **Retrieved:** 2026-07-11

## Summary

The reference table of guaranteed Direct3D 11 resource limits, defined as constants in `D3d11.h`.
Two of them bound any decision between packing textures into one sheet and stacking them into an
array. A 2D texture's width or height may not exceed
`D3D11_REQ_TEXTURE2D_U_OR_V_DIMENSION`—**16384**—which is the hard ceiling on how much a single
atlas page can hold: at 1024×1024 per sub-texture, one maximal page fits 256 of them and no more.
A texture array is limited instead by `D3D11_REQ_TEXTURE2D_ARRAY_AXIS_DIMENSION`, which permits
**2048 array slices**, each of them a full-size texture in its own right.

These are feature-level guarantees, not universal truths: the page is explicit that the limits apply
to feature level 11 hardware, and it lists a separate, much tighter table for feature level 9.x,
where a 2D texture's dimension falls to 2048 (9\_1) or 4096 (9\_3). Hardware may exceed a guaranteed
limit, and the runtime will let an application try, but only allocations within the documented limit
are guaranteed to succeed everywhere at that feature level. The related cap on any single resource is
`min(max(128, 0.25 × dedicated VRAM), 2048)` MB—so one enormous atlas page can also run into a
per-resource size ceiling well before it runs out of texels.

## Compiled into

- [[texture-arrays-vs-atlases]] — the 16384-texel page ceiling versus the 2048-slice array ceiling
