---
title: VRChat avatar optimization
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[vrchat-avatar-performance-ranks]]"
  - "[[vrchat-avatar-optimization-tips]]"
  - "[[vrchat-physbones]]"
tags: [vrchat, avatars, optimization]
---

# VRChat avatar optimization

VRChat evaluates avatar cost from triangles, texture memory, renderer and material-slot counts,
bones, animators, physics, contacts, and constraints. Optimization therefore means controlling
the metrics VRChat reports and the runtime work they represent, not merely shrinking the file.

## Why it works

Begin with the intended platform. For a mobile-compatible avatar, make the source model low-cost:
VRChat's current mobile rank table gives an Excellent target of 7,500 triangles, 10 MB texture
memory, one skinned mesh, one basic mesh, one material slot, and 75 bones. Re-check the live table
before upload because limits change. On every platform, reduce skinned renderers and material
slots, atlas compatible textures, bake small visual detail, and prefer opaque or cutout materials
over transparency where the look permits.

Use the SDK Build Control Panel and in-game avatar details to measure after each meaningful change.
Disabled GameObjects still count in performance rank, so an unused outfit or particle system is
not free. A user can hide avatars below their display threshold, and mobile can remove limited
components entirely.

## The catch

Good rank is not the same as good frame time. Excess shader passes, transparency, real-time
lights, and poorly chosen textures can still be expensive. Avoid tessellation on avatars; avoid
always-on lights; and profile a representative populated VRChat scene when the avatar is intended
for PC. See [[game-performance-profiling]].

## In practice here

Before editing [[arii-blend-avatar]], establish whether it needs PC-only quality, mobile support,
or two separate variants. That decision determines whether outfits are merged and atlased into a
single source avatar or retained as optional PC features.
