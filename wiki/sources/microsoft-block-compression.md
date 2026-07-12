---
title: "Source: Microsoft — Block compression"
type: source
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "https://learn.microsoft.com/en-us/windows/win32/direct2d/block-compression"
tags: [source, game-development, optimization, rendering, textures, graphics-api]
---

# Source: Microsoft — Block compression

- **Author:** Microsoft
- **Published:** 2021-01-28 (last updated)
- **URL:** https://learn.microsoft.com/en-us/windows/win32/direct2d/block-compression
- **Retrieved:** 2026-07-11

## Summary

Microsoft explains BC compression as independent 4x4 texel blocks encoded into 64 or 128 bits,
which yields roughly 4–8 bits per pixel and lets modern GPUs sample the data without a separate decode
step. BC6H and BC7 use different algorithms for HDR and higher-quality color. The savings reduce GPU
memory and load time, but the algorithms are lossy: sharp, high-contrast computer-generated imagery
can show artifacts, and block-compressed files may be larger on disk than JPEG even though they are
better suited to runtime use.

## Compiled into

- [[texture-compression-formats]] — block structure, GPU-native memory savings, and artifact tradeoffs
