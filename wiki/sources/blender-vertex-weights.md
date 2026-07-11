---
title: "Source: Blender Manual — vertex weights"
type: source
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "raw/blender-vertex-weights.md"
tags: [source, blender, rigging, weights]
---

# Source: Blender Manual — vertex weights

- **Author:** Blender Foundation contributors
- **Published:** Blender 5.0 Manual
- **URL:** https://docs.blender.org/manual/en/dev/modeling/meshes/properties/vertex_groups/vertex_weights.html
- **Retrieved:** 2026-07-11
- **Raw:** `raw/blender-vertex-weights.md` (provenance only)

## Summary

Vertex groups assign each vertex a weight from 0 to 1. For armature deformation, those weights
determine how strongly a bone moves the vertex; the weights affecting a vertex typically sum to
one. Blender provides inspection and editing in Edit and Weight Paint modes, which makes a
clothing mesh's inherited groups a starting point rather than proof of correct deformation.

## Compiled into

- [[avatar-weight-painting]] — diagnose and repair skinning weights
- [[vrchat-clothing-workflow]] — transfer weights only between matching fitted meshes
