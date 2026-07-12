---
title: Texture atlasing
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[nvidia-texture-atlas-whitepaper]]"
  - "[[unity-sprite-atlas]]"
tags: [game-development, optimization, rendering, textures]
---

# Texture atlasing

A texture atlas is one large texture holding many smaller ones side by side, with every model that
used a packed texture remapped so its UVs address the sub-rectangle the texture now occupies.
Binding a texture is a render-state change, and a render-state change ends a batch; objects that
share an atlas no longer need one between them, so they can share a material and collapse into a
single draw call. Atlasing is the texture-side precondition for [[draw-call-batching]]—the step
that makes objects batchable in the first place, rather than a batching technique itself.

## Why it works

The problem is not that texture binds are slow but that they are frequent. An NVIDIA survey of
shipping DirectX 9 titles found `SetTexture()` to be among the most common state changes in a frame,
which makes texture binding one of the leading batch-breakers: two quads with two textures are two
batches purely because a bind sits between them. Pack both textures into one atlas and the bind
disappears, the two draws merge, and the CPU submission cost is paid once. Because a batch-bound
frame is limited by how many calls the CPU can issue rather than by triangles, geometry pulled into
an existing call is close to free—so the win scales with how many distinct textures the atlas
eliminates, not with how many pixels it contains.

The consequence worth internalising is that atlasing is really *material unification* wearing a
texture's clothes. Objects batch only when they share render state, and the usual thing keeping two
otherwise identical objects on separate materials is that they sample different textures. Removing
that difference is what lets one material—and therefore one batch—cover both. This is why the same
move shows up under different names across the stack: a Unity Sprite Atlas exists so that many
sprites resolve to a single draw call, a tileset is an atlas of tiles, and merging an avatar's
material slots means atlasing the textures those slots referenced.

## The catch

Atlasing quietly gives up the GPU's texture address modes. A packed texture occupies a strict subset
of `[0,1]`, so clamp, wrap, and mirror no longer apply to it: a UV outside the original `[0,1]`
range maps to atlas coordinates that sample *a neighbouring texture*. A tiling texture therefore
cannot simply be atlased—it must be replicated once per repeat (wasting memory and forcing the
packer to know each texture's UV range) or have its address mode emulated in the shader. Anything
that tiles—terrain, trim, repeating architectural detail—is a poor atlas candidate for this reason
alone.

Filtering leaks across the same borders. Sampling texel centres keeps bilinear filtering safe at the
top mip level, but anisotropic filtering there, and *any* filtering at lower mip levels, can reach
past a sub-texture's edge into an unrelated neighbour; NVIDIA calls the resulting artifacts small
but noticeable and offers no cheap fix. This is what the padding gutter buys—Unity's Sprite Atlas
defaults to 4 pixels between sprites—and why mip-chains are generated per texture *before* packing
rather than for the atlas as a whole. Beyond that: atlas pages are capped by the platform's maximum
texture size, so a big atlas can force lower per-asset resolution than separate textures would have
allowed; loading one atlas pulls in every texture on it whether the scene needs them or not; and
because UVs are baked against a specific packing, repacking the atlas invalidates the models that
reference it. As with all batching work, none of it helps a frame that is GPU-bound rather than
submission-bound.

## In practice here

Reach for atlasing when [[game-performance-profiling]] shows a CPU-bound frame made of many small,
differently-textured submissions—it is the fix that makes [[draw-call-batching]] possible, so the
two are usually done as one job. Prefer it for content that never tiles and is authored together:
UI, sprites, tilesets, and the small props that share a scene. Keep tiling materials out of it.

On avatars it is the same lever the performance ranks already push toward: the material-slot count
that [[vrchat-avatar-optimization]] reports falls only if the textures behind those slots are
atlased, which is why merging meshes and atlasing textures improve rank and draw calls for one
underlying reason. Atlasing also composes with [[texture-baking-for-games]]—baking small surface
detail into a texture and then packing that texture into an atlas are consecutive steps of the same
pipeline, the first removing geometry and the second removing binds.
