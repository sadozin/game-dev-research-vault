---
title: "Source: Unity — Sprite Atlas"
type: source
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "https://docs.unity3d.com/2022.3/Documentation/Manual/sprite-atlas.html"
tags: [source, unity, optimization, textures]
---

# Source: Unity — Sprite Atlas

- **Author:** Unity Technologies
- **Published:** Unity Manual, 2022.3 LTS
- **URL:** https://docs.unity3d.com/2022.3/Documentation/Manual/sprite-atlas.html
- **Also:** https://docs.unity3d.com/2022.3/Documentation/Manual/class-SpriteAtlas.html
- **Retrieved:** 2026-07-11

## Summary

Unity's Sprite Atlas is an asset that consolidates several textures into one combined texture. The
manual states the motive plainly: a project whose sprites each live in their own texture needs a
draw call per texture, which is resource-intensive and hurts performance, whereas an atlas lets
Unity issue a single draw call that reaches all the packed sprites at once. It is the engine-level
packaging of the same idea the batching documentation assumes when it says shared materials and
atlased textures preserve batches (see [[unity-draw-call-batching]]). The asset is created via
Assets > Create > 2D > Sprite Atlas and saved as a `.spriteatlas` file; Sprite Atlas V2 is the
default in the editor from Unity 2022.2 onward.

The packing settings encode the tradeoffs. **Padding** sets how many pixels separate packed sprites,
defaulting to 4—the gutter that stops a neighbouring sprite's texels bleeding in under filtering and
mip-mapping. **Allow Rotation** is on by default and lets the packer rotate sprites to raise texture
density, but the manual warns to disable it for Canvas UI elements, whose orientation the rotation
would otherwise disturb. **Tight Packing**, also on by default, packs by a sprite's outline rather
than its bounding rectangle, again to raise density. **Include in Build** controls whether the atlas
ships with the build, and a Variant atlas derives a scaled copy of a master atlas—the mechanism for
shipping a lower-resolution set to smaller devices. Atlases can also be requested at runtime through
the Sprite Atlas API rather than being loaded wholesale. Specific defaults and the V2 behaviour vary
by Unity version, so confirm them against the version in use.

## Compiled into

- [[texture-atlasing]] — atlasing as an engine feature: padding, rotation, tight packing, variants
