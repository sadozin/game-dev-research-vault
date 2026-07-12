---
title: "Source: Unity — 2D texture arrays"
type: source
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "https://docs.unity3d.com/6000.1/Documentation/Manual/texture-arrays-introduction.html"
tags: [source, unity, rendering, textures]
---

# Source: Unity — 2D texture arrays

- **Author:** Unity Technologies
- **Published:** Unity Manual (Unity 6 docs)
- **URL:** https://docs.unity3d.com/6000.1/Documentation/Manual/texture-arrays-introduction.html
- **Also:** https://docs.unity3d.com/Manual/class-Texture2DArray.html
- **Retrieved:** 2026-07-11

## Summary

Unity defines a 2D texture array as a collection of 2D textures that share the same size, format,
and flags, presented to the GPU as a single object. The individual textures are called slices or
layers and are addressed in a shader by index, which is the whole point: many textures reachable
through one binding, without the coordinate surgery an atlas requires. The manual names custom
terrain rendering as the motivating case—an efficient way to reach many same-size, same-format
textures—along with other effects that need to switch texture per draw or per fragment.

The same-size-and-format rule is the price. Unlike an atlas, which will happily absorb a 512 next to
a 2048, an array is a rigid grid: every layer is identical in dimensions and format, so mismatched
source art must be resized (wasting memory on upscaled small textures) before it can join.

Support is a hardware and API question rather than a universal given. Unity lists DirectX 11/12,
Metal, OpenGL Core, OpenGL ES 3.0 (Android, WebGL 2.0), and Vulkan, and exposes
`SystemInfo.supports2DArrayTextures` for a runtime check. Shaders opt in with `#pragma require
2darray` (or shader model 3.5 and above) and sample with `UNITY_SAMPLE_TEX2DARRAY`, passing a
`float3` whose third component is the slice index; a `_LOD` variant samples an explicit mip level.
The practical consequence is that texture arrays are a modern-target technique—anything shipping to
GLES 2-class hardware or WebGL 1 needs an atlas fallback.

## Compiled into

- [[texture-arrays-vs-atlases]] — the same-size/format constraint, API support, and slice-index
  sampling
