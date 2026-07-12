---
title: Unreal Nanite
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[unreal-nanite-virtualized-geometry]]"
  - "[[unreal-nanite-technical-details]]"
tags: [game-development, unreal, rendering, optimization, geometry]
---

# Unreal Nanite

Nanite is Unreal's virtualized-geometry renderer. It imports meshes into a hierarchical cluster format,
selects screen-appropriate detail, culls clusters, and streams geometry on demand instead of relying
on manually authored LOD meshes and traditional draw-call submission. It is especially suited to dense
static scenes, high instance counts, and film-quality source geometry.

## Why it works

Nanite's cluster hierarchy lets visibility and screen size select only the triangles that can affect
the frame. Compressed data streams from storage and a fallback representation covers unsupported paths.
Automatic LOD and fine-grained streaming make geometric detail scale more with visible pixels than with
the raw source triangle count, while integrating with virtual shadow maps and Lumen.

## The catch

Nanite is not a universal replacement for all geometry. Material blend modes, VR/stereo, ray tracing,
some deformation, and platform feature levels have limitations; masked and opaque materials are the
safe baseline. Streaming pools can thrash when the view needs more data than resident memory, and
cluster or instance limits can produce missing geometry. Material complexity, overdraw, output
resolution, IO, and GPU bandwidth remain bottlenecks even when mesh polycount stops being one.

## In practice here

Enable Nanite for dense, screen-visible geometry and profile the actual target platform. Keep a valid
fallback path, test masked foliage, deformation, shadows, camera cuts, and storage speed, and size the
Nanite streaming pool with [[platform-memory-budgets]]. Use Nanite visualization and captures to find
cluster, material, or streaming costs rather than assuming every imported high-poly asset is faster.
