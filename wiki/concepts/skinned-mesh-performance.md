---
title: Skinned mesh performance
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[rendering-effects-and-animation]]"
tags: [game-development, rendering, animation, optimization]
---

# Skinned mesh performance

Skinned mesh performance is the cost of transforming vertices by bone weights and evaluating the
animation, material, and rendering state for each character.

## Why it works

GPU skinning and instancing move repeated deformation work into parallel hardware, while LODs and bone
reduction scale character crowds by reducing detail where it is not visible.

## The catch

Bone count, influence count, blend shapes, shadows, materials, and animation evaluation interact. A
cheap mesh can still be expensive when every character has unique state and multiple passes.

## In practice

Profile animation and render stages separately, reduce bones and passes by LOD, and test worst-case
crowds rather than one hero character.

