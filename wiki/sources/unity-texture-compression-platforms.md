---
title: "Source: Unity — Recommended texture compression formats by platform"
type: source
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "https://docs.unity3d.com/2020.2/Documentation/Manual/class-TextureImporterOverride.html"
tags: [source, game-development, optimization, rendering, textures, unity]
---

# Source: Unity — Recommended texture compression formats by platform

- **Author:** Unity Technologies
- **Published:** 2020.2 manual
- **URL:** https://docs.unity3d.com/2020.2/Documentation/Manual/class-TextureImporterOverride.html
- **Retrieved:** 2026-07-11

## Summary

Unity's platform matrix maps texture roles and target hardware to concrete formats. It recommends
DXT1/BC1 for desktop RGB, BC7 or DXT5/BC3 for desktop RGBA, and BC6H for HDR where the GPU supports
them. On mobile, ASTC offers selectable block sizes and quality, while ETC2 covers Vulkan, Metal, and
OpenGL ES 3-class devices more broadly; ETC1 has no direct alpha channel. The manual warns that
unsupported formats can be decompressed at runtime, and that Android and older Apple devices may
need platform-specific variants or fallbacks.

## Compiled into

- [[texture-compression-formats]] — platform selection, channel fit, and runtime fallback risks
