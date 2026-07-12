---
title: Specular versus metallic workflow
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[khronos-gltf-pbr]]"
tags: [game-development, rendering, materials]
---

# Specular versus metallic workflow

Specular and metallic workflows encode related PBR material properties with different artist-facing
inputs and assumptions.

## Why it works

Metallic workflows classify a surface as conductor or dielectric and derive reflectance behavior;
specular workflows expose reflectance more directly. Both can represent a physically plausible
material when their conventions are calibrated.

## The catch

Mixing maps from one convention into another without conversion produces wrong base color or reflectance.
Engine defaults, packed channels, and authoring tools may silently apply different assumptions.

## In practice

Choose the target engine’s convention early, convert assets through a documented transform, and test
metals and dielectrics under neutral lighting.

