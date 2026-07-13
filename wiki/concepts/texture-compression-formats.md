---
title: Texture compression formats
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[unity-texture-compression-platforms]]"
  - "[[microsoft-block-compression]]"
tags: [game-development, optimization, rendering, textures]
---

# Texture compression formats

Texture compression formats store GPU-readable texture data in fewer bits per pixel than an
uncompressed RGBA surface. The important choice is not simply "compressed or not": BCn is the usual
desktop family, ASTC trades block size against quality and memory on newer mobile hardware, and ETC2
is a broad OpenGL ES 3-era baseline. The format must match the texture's channels, HDR or LDR range,
alpha needs, and target GPU support.

## Why it works

These formats compress fixed-size texel blocks and leave the result in a representation the GPU can
sample directly. A 32-bit-per-pixel RGBA texture can therefore become a 4- or 8-bit-per-pixel block
format without a JPEG-like decode step at runtime. BC1 suits opaque or 1-bit-alpha color, BC3 adds
interpolated alpha, BC4 and BC5 fit one- and two-channel data such as masks and normal-map components,
BC6H targets HDR, and BC7 spends more bits on high-quality LDR color and alpha.

ASTC uses selectable block sizes: smaller blocks preserve more detail while larger blocks reduce
memory. ETC2 provides a useful cross-device mobile baseline for RGB and RGBA data, while older ETC1
has no direct alpha channel. This makes format selection part of the [[texture-baking-for-games]]
pipeline, not a final cosmetic toggle.

## The catch

Compression is lossy and block-local. Hard UI edges, text, masks, and normal maps can show ringing,
color bleeding, or block boundaries even when a photograph looks fine. A format that is unavailable
on a target is worse than a visible artifact: the engine may decompress it to an uncompressed fallback
at load time, multiplying memory and sometimes load cost. Android hardware fragmentation can require
multiple texture variants, and ASTC quality settings change memory as well as appearance. Crunch or
similar disk-only packaging compression does not reduce the runtime GPU footprint when the underlying
format is unchanged.

## In practice here

Choose per platform and per texture role, then inspect the built player rather than the source PNG.
Use BC7 or BC6H on supported desktop targets when quality or HDR matters; use BC1/BC3/BC4/BC5 where
their channel model is sufficient. On mobile, prefer ASTC when the device floor supports it, and use
ETC2 or a deliberate fallback for broader coverage. Keep UI and data textures uncompressed or use a
tested precision-preserving format when artifacts are unacceptable. Verify the result with
[[game-performance-profiling]] and the memory checks in [[vrchat-avatar-optimization]]: lower file
size is not proof that runtime texture memory or sampling cost improved.
