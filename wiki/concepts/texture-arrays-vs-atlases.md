---
title: Texture arrays vs atlases
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[unity-texture-arrays]]"
  - "[[d3d11-resource-limits]]"
tags: [game-development, optimization, rendering, textures]
---

# Texture arrays vs atlases

A texture array holds many same-sized textures as indexed layers of one GPU object, sampled with a
third coordinate—the slice index—instead of a remapped UV. It buys the same thing [[texture-atlasing]]
buys, one binding for many textures and therefore fewer batches, but it buys it without the two
compromises that make atlases leak: each layer keeps its own `[0,1]` UV space, so wrap and mirror
work normally, and filtering never reaches across a layer boundary, because layers are separate
images rather than neighbourhoods of one image. The choice between them is not "old versus new" but
a trade of *uniformity* against *flexibility*.

## Why it works

An atlas defeats the sampler's addressing rules by construction: a packed texture lives in a
sub-rectangle of `[0,1]`, so a UV of 1.5 lands on the neighbour instead of tiling, and a bilinear or
anisotropic tap near an edge can pull in texels that belong to a different asset. A layer of an array
has no neighbours. Its coordinates still run the full `[0,1]`, its address mode still means what it
says, and its mip chain is its own—so the tiling textures and the mip-bleed artifacts that an atlas
must either forbid, pad around, or emulate in shader code simply do not arise. Meanwhile the batching
benefit survives intact, because the array is one resource and one bind no matter how many layers it
holds; the shader picks a layer per fragment or per instance with an index, which is exactly the
per-object variation that instancing wants.

The ceilings differ in kind, and this is often what decides it. An atlas is bounded by the maximum
texture dimension: Direct3D 11 guarantees 16384 texels per axis, so a single maximal page holds 256
textures of 1024×1024 and not one more, and it also risks the per-resource size cap. An array is
bounded by slice count instead—2048 slices at feature level 11—each a full-size texture. An array
therefore scales to far more distinct textures than any one atlas page, which is why terrain systems
that blend among dozens of ground materials reach for arrays rather than an ever-larger sheet.

## The catch

Arrays are rigid where atlases are accommodating. Every layer must share the same dimensions, format,
and flags, so an array cannot absorb a 2048 hero texture next to a 256 prop icon: the small art must
be upscaled to the array's size, paying full memory for detail it does not have. An atlas packs
mixed sizes tightly and wastes only its gutters. Whenever the source art is genuinely heterogeneous—UI
sprites, decals, a grab-bag of props—the atlas is still the memory-efficient answer, and the array's
uniform grid is the more wasteful one.

Support is also a floor rather than a given. Texture arrays need DirectX 11/12, Metal, OpenGL Core,
OpenGL ES 3.0, WebGL 2, or Vulkan; anything targeting GLES 2-class hardware or WebGL 1 has no array
path and needs the atlas anyway. Shaders must opt in explicitly (in Unity, `#pragma require 2darray`
and `UNITY_SAMPLE_TEX2DARRAY` with a `float3` coordinate), so adopting arrays is a shader change, not
a content-pipeline switch—and a project can check `SystemInfo.supports2DArrayTextures` at runtime
rather than assume. Finally, an array is one binding but not one *texture* in the authoring sense:
tools, importers, and material inspectors handle plain 2D textures far more gracefully, and building
array assets is usually a bespoke build step.

## In practice here

Reach for an array when the textures are already uniform and interchangeable—terrain layers, tile
sets, sprite frames of one size, per-instance skins for the same mesh—and especially when any of them
must tile, since that is the case an atlas cannot serve without shader emulation. Reach for an atlas
when the art is mixed in size and never tiles: UI, icons, decals, and the small props of a scene,
where tight packing of unequal rectangles is the entire benefit. The two are not exclusive; a project
commonly atlases its UI and arrays its terrain.

Either way the payoff is measured the same place—both are routes to [[draw-call-batching]], so the
justification comes from [[game-performance-profiling]] showing a submission-bound frame, and the
verification is that the batch count fell. Arrays pair naturally with per-instance rendering, where
the instance supplies the slice index and one call draws many differently-textured copies. If a
prospective array's layers would be padded up from wildly different source resolutions, that memory
regression can push a build past the platform's texture budget, and the atlas—gutters, wrap limits,
and all—remains the right call.
