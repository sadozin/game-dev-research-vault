---
title: Blender MCP Bake and UV
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[blender-cycles-baking]]"
  - "[[mcp-tools-bake-safety]]"
tags: [game-development, blender, mcp, baking, uv, assets]
---

# Blender MCP Bake and UV

Baking through Blender MCP should be a parameterized asset operation that names the source mesh,
target mesh, UV map, bake pass, image target, cage, and output path. It should validate prerequisites
before starting a potentially slow render operation and return the generated artifact for review.

## Why it works

Blender baking transfers material, normal, AO, lighting, or procedural information into image textures
that a game engine can consume. Cycles requires a UV map and an image texture or color attribute as the
target, giving an MCP tool explicit preconditions it can inspect before invoking Bake.

## The catch

Bakes are sensitive to UV overlap, cage distance, smoothing, color management, samples, render engine,
and source/target selection. A completed bake can still contain projection seams, skewed normals, or
the wrong color space. It is also an expensive and stateful operation that may overwrite an image or
leave partial output when interrupted.

## In practice here

Inspect UVs and target image first, validate source/target correspondence and output path, run a small
preview bake, then commit only the accepted image and settings. Preserve the source `.blend`, use a
unique output or explicit overwrite confirmation, and compare the baked result in the target engine.
