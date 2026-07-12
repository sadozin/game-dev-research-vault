---
title: PBR material workflow
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[khronos-gltf-pbr]]"
tags: [game-development, rendering, materials]
---

# PBR material workflow

Physically based rendering uses material parameters with a lighting model designed to respond
consistently across view and light changes.

## Why it works

Metallic-roughness separates conductive response from surface microstructure, giving artists a
compact contract that can be previewed and reused across scenes. Calibrated values and reference
lighting make assets easier to compare.

## The catch

PBR textures do not make lighting physical. Wrong color space, uncalibrated exposure, or extreme
values can still produce plausible-looking but inconsistent assets.

## In practice

Validate materials under a neutral reference scene, then profile shader variants and texture formats
on the target platform.

