---
title: VRChat clothing workflow
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[blender-vertex-weights]]"
  - "[[vrchat-rig-requirements]]"
  - "[[vrchat-avatar-optimization-tips]]"
tags: [vrchat, avatars, clothing, blender]
---

# VRChat clothing workflow

VRChat-ready clothing is a low-overhead mesh that follows the avatar's existing armature, clears
the body in posed motion, uses the avatar's material budget, and exports with the same humanoid
rig as the body.

## Why it works

Model the garment around the body in Blender, keep its topology simple, and use body-derived
weights for skin-tight garments. Hide or remove covered body geometry only after deciding which
outfits can coexist; otherwise the body remains under the cloth and clips at runtime. Test neutral,
arms-up, arms-forward, crouch, seated, and leg-spread poses before Unity export. Use dedicated
bones only where the garment needs independent motion, then constrain that secondary motion with
[[vrchat-avatar-physics]].

Plan clothes with the final avatar as one rendering budget. Merge static or compatible skinned
garments where it does not break toggles, atlas compatible textures, and avoid creating one mesh
or material per accessory. A clothing toggle is a feature decision that may justify separation;
it is not a reason to ignore render cost.

## The catch

Solidify thickness, overlapping body surfaces, and alpha fabric can increase clipping, triangle,
and draw-call cost. Do not try to repair a high-detail render garment only at the end with
decimation: retopologize or simplify it while preserving silhouette, then bake detail into maps.

## In practice here

The established [[arii-blend-avatar]] recipe—duplicate `Body Base`, trim, offset along normals,
then use Solidify and Armature—matches this workflow. Its inherited weights are useful, but the
new mesh still needs pose validation, material budgeting, and a Unity/VRChat upload check.
