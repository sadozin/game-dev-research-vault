---
title: Texture baking for games
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[blender-gltf-export]]"
tags: [blender, game-development, textures, baking]
---

# Texture baking for games

Texture baking transfers surface detail that would be expensive to model or shade at runtime into
images used by a simpler mesh. It is the main bridge between a detailed Blender source asset and
a predictable real-time asset in a [[blender-game-asset-pipeline]].

## Why it works

Bake detail from a high-detail source onto the UVs of the shipping mesh, then use a standard PBR
material: base color, metallic, roughness, tangent-space normal, emissive when needed, and baked
ambient occlusion. Use tangent-space normals with the expected orientation of the target format;
for glTF, the normal map is tangent-space `+Y` and must be treated as non-color data. A packed ORM
texture stores ambient occlusion in red, roughness in green, and metallic in blue, reducing the
number of texture fetches and files.

Inspect the bake on the low-poly mesh under moving light, not only in the bake view. Seams, bad
cage projection, inconsistent smoothing, and mismatched tangents are integration defects, not
minor art cleanup, because they appear as persistent lighting errors in the shipped game.

## The catch

Baking does not make texture memory free. Set a texture-resolution budget per asset class and
validate it in the build; a small object that fills few pixels rarely needs the same map size as
a hero asset. Avoid baking lighting that must remain dynamic unless the game deliberately uses
static lightmaps.

## In practice here

Use this workflow whenever [[blender-mcp]] is used to prepare runtime assets. The current
[[minecwaft]] page does not establish a Blender import path, so do not generate a large asset
library until that import contract and its texture formats are verified.
