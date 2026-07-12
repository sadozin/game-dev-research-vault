---
title: "Source: Unity Manual — Root Motion, body transform and root transform"
type: source
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "https://docs.unity3d.com/6000.0/Documentation/Manual/RootMotion.html"
tags: [source, unity, game-development, animation]
---

# Source: Unity Manual — Root Motion, body transform and root transform

- **Author:** Unity Technologies (Unity 6 manual)
- **Published:** undated manual page, Unity 6000.0 documentation set
- **URL:** https://docs.unity3d.com/6000.0/Documentation/Manual/RootMotion.html
- **Retrieved:** 2026-07-11

## Summary

Unity separates two transforms. The **body transform** is the character's centre of mass, used for
retargeting and giving a stable displacement. The **root transform** is a projection of the body
transform onto the Y plane, computed at runtime: each frame Unity computes the *change* in the root
transform and applies that delta to the GameObject, which is what makes the character move.

The Animation Clip inspector then decides, per axis, whether that motion drives the GameObject or
stays inside the pose. "Applied as Root Motion" sends the clip's motion to the GameObject. "Bake Into
Pose" keeps it on the body transform instead, leaving the root unchanged — a clip whose root
orientation is baked into the pose will not rotate the GameObject at all. Baking is the standard fix
for looping clips that would otherwise accumulate error: for horizontal position, baking forces the
delta position to zero, which stops small per-evaluation deltas from drifting the character over many
loops of an idle.

The manual also documents the root transform's vertical reference point. Choosing **Feet** makes root
transform position Y match the lowest foot Y on every frame, so the blend point stays around the
feet — which is what prevents characters floating when blending or transitioning between clips
authored at different heights.

## Compiled into

- [[root-motion-vs-inplace]] — how the root delta is derived, and what Bake Into Pose is for
