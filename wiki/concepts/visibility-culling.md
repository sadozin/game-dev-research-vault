---
title: Visibility culling
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[unity-occlusion-culling]]"
tags: [game-development, rendering, optimization, culling]
---

# Visibility culling

Visibility culling removes render work for objects that cannot contribute to the current image. Frustum culling is the baseline: discard objects outside the camera volume. Occlusion culling adds a second test for objects fully hidden behind solid geometry.

## Why it works

Frustum culling is broadly applicable because it needs only the camera and each renderable's bounds. Occlusion culling pays off when a view contains many fully hidden renderers: enclosed rooms and corridors produce stronger, more predictable hiding relationships than open terrain. It can reduce both CPU submission work and GPU rendering work.

## The catch

Occlusion is not a free universal improvement. Unity's baked system stores visibility-cell data in memory and performs runtime CPU queries, so it can move a GPU-bound scene into a CPU-bound one. Its baked data also assumes stable scene geometry; Unity explicitly excludes runtime-generated geometry from this workflow. Choose it only after [[game-performance-profiling]] proves hidden rendering is a material cost.

## In practice here

[[minecwaft]] streams and generates voxel chunks at runtime, so a pre-baked, Unity-style occlusion data set is the wrong starting point. Retain frustum culling and validate chunk submission and GPU time during traversal; investigate a runtime, chunk-aware visibility method only if profiling shows hidden geometry rather than chunk construction is the limiting cost.
