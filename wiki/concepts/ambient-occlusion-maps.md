---
title: Ambient occlusion maps
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[rendering-effects-and-animation]]"
tags: [game-development, rendering, materials]
---

# Ambient occlusion maps

Ambient occlusion maps encode an approximation of how much ambient light a surface receives from nearby
geometry.

## Why it works

Baked occlusion adds stable contact and crevice shading without tracing all small-scale visibility at
runtime, helping low-frequency shape read under simple lighting.

## The catch

AO is not directional shadowing and can double-darken a scene when multiplied aggressively with dynamic
lighting. Baked maps also become wrong when geometry or material layout changes.

## In practice

Use AO as a restrained material or lighting input, validate its bake space and UVs, and compare against
actual lighting rather than using it to hide poor forms.

