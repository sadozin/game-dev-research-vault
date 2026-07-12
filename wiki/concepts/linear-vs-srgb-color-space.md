---
title: Linear versus sRGB color space
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[khronos-gltf-pbr]]"
tags: [game-development, rendering, color]
---

# Linear versus sRGB color space

Linear values represent proportional light; sRGB values are encoded for display and storage.

## Why it works

Decode color textures before lighting and encode the final result for display. Arithmetic such as
blending, filtering, and adding light is meaningful in linear space.

## The catch

Treating sRGB data as linear makes lighting and gradients wrong; treating data maps such as normals
as color can corrupt directions. UI and post-processing may cross the boundary in different places.

## In practice

Mark albedo and emissive textures as color data, keep normals and masks linear, and test a known
gray ramp through the complete pipeline.

