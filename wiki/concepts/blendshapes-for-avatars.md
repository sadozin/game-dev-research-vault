---
title: Blendshapes for Avatars
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[blender-shape-keys]]"
  - "[[vrchat-avatar-visemes-and-blendshapes]]"
tags: [game-development, blender, vrchat, animation, avatars]
---

# Blendshapes for Avatars

Blendshapes, called shape keys in Blender, store alternate vertex positions that can be mixed at
runtime for facial expressions, phonemes, corrective poses, and stylized deformation. They are a
direct way to author facial motion when bones alone cannot preserve the desired form.

## Why it works

Relative shape keys add weighted offsets to a Basis shape, so several expressions can combine. A
facial rig can drive those weights from animator parameters or viseme selection, while corrective
keys repair intersections or muscle shapes caused by a bone pose. Keeping the mesh topology stable
makes the same vertex correspondence available to every key.

## The catch

Each blendshape adds vertex data and can increase memory, upload, and evaluation cost. Conflicting
keys can double features or produce broken mouths, and a renamed or missing key can silently break a
platform's default mapping. Shape keys do not replace good topology, eye/jaw rigging, or a tested
parameter budget; they are especially costly when duplicated across many meshes.

## In practice here

Keep a clean Basis, define a small canonical set for expressions and visemes, and add corrective keys
only where bone deformation fails. Test mixed weights, extreme values, normals, and phoneme coverage
on the target avatar. Keep facial keys on a dedicated head mesh where possible, and validate the exact
names and platform mapping before upload.
