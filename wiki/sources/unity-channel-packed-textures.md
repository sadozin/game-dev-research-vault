---
title: "Source: Unity — Assign a channel-packed texture to a URP material"
type: source
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "https://docs.unity3d.com/kr/current/Manual/urp/shaders-in-universalrp-channel-packed-texture.html"
tags: [source, game-development, optimization, rendering, textures, unity]
---

# Source: Unity — Assign a channel-packed texture to a URP material

- **Author:** Unity Technologies
- **Published:** Undated (current Unity Manual)
- **URL:** https://docs.unity3d.com/kr/current/Manual/urp/shaders-in-universalrp-channel-packed-texture.html
- **Retrieved:** 2026-07-11

## Summary

Unity's URP Lit and Complex Lit shaders accept one RGBA texture for metallic, occlusion, and
smoothness. The documented convention is red metallic, green occlusion, blue unused, and alpha
smoothness. Unity also requires the packed texture to be imported with sRGB disabled because these are
linear scalar properties; Shader Graph can be used when a project needs a different channel layout.

## Compiled into

- [[texture-channel-packing]] — shared fetches, channel conventions, and linear import
