---
title: Normal mapping
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[khronos-gltf-pbr]]"
tags: [game-development, rendering, materials]
---

# Normal mapping

Normal mapping changes the surface normal used for lighting without adding geometric detail.

## Why it works

Each texel stores a direction in tangent space; the shader transforms that direction through the
surface basis before evaluating lights. This gives high-frequency shading at texture cost.

## The catch

Mirrored UVs, mismatched tangent generation, channel conventions, and incorrect sRGB settings create
seams or inverted lighting. A normal map cannot change silhouettes or occlusion.

## In practice

Bake and render with the same tangent basis, inspect green-channel conventions, and reserve geometry
for silhouette-critical detail.

