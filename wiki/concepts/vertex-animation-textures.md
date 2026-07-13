---
title: Vertex animation textures
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[rendering-effects-and-animation]]"
tags: [game-development, rendering, animation]
---

# Vertex animation textures

Vertex animation textures encode baked vertex positions or motion data in textures that a shader samples
to animate many instances.

## Why it works

The GPU can animate large crowds, effects, or foliage with little per-object skeletal state and without
evaluating a full CPU animation graph for each instance.

## The catch

Texture bandwidth, precision, memory, looping, collision, and interaction become the constraints. VAT
motion is usually visual and cannot directly provide authoritative bone or vertex state.

## In practice

Use VAT for visual masses and effects, keep gameplay collision separate, pack data carefully, and test
camera distance and compression artifacts.

