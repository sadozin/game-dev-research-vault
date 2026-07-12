---
title: "Source: NVIDIA — Improve Batching Using Texture Atlases"
type: source
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "https://download.nvidia.com/developer/NVTextureSuite/Atlas_Tools/Texture_Atlas_Whitepaper.pdf"
tags: [source, optimization, rendering, textures]
---

# Source: NVIDIA — Improve Batching Using Texture Atlases

- **Author:** NVIDIA Corporation (SDK White Paper WP-01387-001-v01)
- **Published:** July 2004
- **URL:** https://download.nvidia.com/developer/NVTextureSuite/Atlas_Tools/Texture_Atlas_Whitepaper.pdf
- **Retrieved:** 2026-07-11

## Summary

An internal NVIDIA survey of four DirectX 9 titles found `SetTexture()` to be among the most
frequent render-state changes, making texture binding one of the most common batch-breakers. The
paper's remedy is to copy several textures into one larger texture—an atlas—so that consecutive
draws no longer need a texture bind between them and can merge into a single draw call. The cost is
that every model using a packed texture must have its UV coordinates remapped to address the
sub-rectangle it now occupies. The paper frames the work as four steps: pick the textures that are
breaking batches, pack them into atlases, remap the UVs of every model that used them, and then
ensure the resulting draw calls are actually issued without an intervening state change. It cites
Wloka's batching analysis (see [[nvidia-batch-batch-batch]]) for why the batch count matters at all.

Mip-maps do not combine the way one might fear. The tool chain generates each texture's mip-chain
*before* packing, then copies each level into the corresponding level of the atlas, so neighbouring
sub-textures never blend into one another during generation—provided the atlas is power-of-two and
the sub-textures are aligned. The remaining mip problem is the bottom of the chain: the largest
packed texture dictates the chain's length, so a 1K atlas of 256×256 textures has 2×2 and 1×1 levels
holding no meaningful data. The paper argues that corruption from those levels does not occur in
practice, because a triangle would have to be smaller than half a pixel to sample them, but it
recommends simply not storing them.

The genuine limitations are addressing and filtering. Because a packed texture occupies a strict
subset of `[0,1]`, the GPU's clamp, wrap, and mirror address modes no longer apply to it: UVs that
stray outside the original `[0,1]` range map to atlas coordinates that sample a *neighbouring*
texture. Tiling a packed texture therefore does not work. The workarounds are to replicate the
texture in the atlas once per repeat (wasteful, and it forces the packer to know each texture's UV
range), or to emulate the address mode in a pixel shader—the paper's Atlas Comparison Viewer does
the latter, needing `ps.2.a` and its `ddx`/`ddy` instructions. Filtering leaks in the same
direction: sampling texel centres keeps bilinear filtering safe at the top mip level, but
anisotropic filtering there, and *any* filtering at lower mip levels, can reach across a
sub-texture's border into an unrelated one. These artifacts are called noticeable though small, and
are not easily overcome; two fixes—a mip-aware clamping shader, and padding each mip level with
border texels—are offered only as untested theory, both costly. Volume textures sidestep the
addressing problem, since each slice holds one texture and u/v address modes still work, but their
mip-chains shrink in all three dimensions and cannot store per-slice mip data; they suit only
textures that never minify, such as screen-aligned UI.

## Compiled into

- [[texture-atlasing]] — the batching motive, the UV remap, and the wrap/filter limits
