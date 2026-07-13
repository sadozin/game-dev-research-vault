---
title: Texture channel packing
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[unity-channel-packed-textures]]"
  - "[[unreal-texture-masks]]"
tags: [game-development, optimization, rendering, textures]
---

# Texture channel packing

Texture channel packing stores several single-channel material maps in the RGBA channels of one
texture. A common ORM or mask map places metallic, occlusion, roughness or smoothness, and a detail
mask together so a shader can fetch them as one resource. It reduces texture bindings, sampler work,
and often memory overhead when the maps share UVs, complementing [[texture-compression-formats]] and
[[texture-baking-for-games]].

## Why it works

Each material property is scalar, so it does not need a full RGB texture. The shader reads one channel
from a packed sample and routes it to the corresponding input. Unity's URP convention uses red for
metallic, green for occlusion, blue unused, and alpha for smoothness; Unreal likewise packs roughness,
metallic, and ambient occlusion masks into one image. The same fetch can therefore replace several
independent grayscale texture reads.

## The catch

Packing is a contract, not a universal file format. Channel order, linear-versus-sRGB import, alpha
handling, remapping, and roughness-versus-smoothness polarity must match the consuming shader. Maps
with unrelated UV scales cannot share one packed texture without losing their intended tiling, and
packing forces all channels to share resolution, compression, and residency. A bad export can produce
plausible-looking but systematically wrong materials, making the bug harder to spot than a missing
texture.

## In practice here

Define the channel convention beside the asset and validate it with a debug material that displays one
channel at a time. Import scalar data in a linear color space, disable color transforms where the
engine requires it, and keep normal or high-precision data out of a lossy pack unless the artifacts are
acceptable. Pack maps that share UVs and resolution; leave unrelated or frequently streamed maps
separate. Confirm sampler count and GPU time with [[game-performance-profiling]].
