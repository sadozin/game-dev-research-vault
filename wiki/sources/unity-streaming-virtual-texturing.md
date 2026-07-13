---
title: "Source: Unity — How Streaming Virtual Texturing works"
type: source
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "https://docs.unity3d.com/es/2021.1/Manual/svt-how-it-works.html"
tags: [source, game-development, optimization, rendering, textures, unity]
---

# Source: Unity — How Streaming Virtual Texturing works

- **Author:** Unity Technologies
- **Published:** 2021.1 manual
- **URL:** https://docs.unity3d.com/es/2021.1/Manual/svt-how-it-works.html
- **Retrieved:** 2026-07-11

## Summary

Unity's Streaming Virtual Texturing divides textures into tiles. A sample first consults an
indirection texture, then a cache; the sampled tile IDs are copied back asynchronously so a worker can
request missing tiles from disk. Unity notes that this feedback and indirection overhead makes it more
efficient to group textures sampled together with the same UVs into a texture stack. The mechanism
therefore saves residency at the cost of extra sampling and streaming machinery.

## Compiled into

- [[virtual-texturing]] — page lookup, feedback, tile requests, and texture-stack tradeoffs
