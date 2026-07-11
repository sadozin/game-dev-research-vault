---
title: Avatar weight painting
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[blender-vertex-weights]]"
tags: [blender, avatars, rigging, weights]
---

# Avatar weight painting

Weight painting assigns each mesh vertex to deform-bone vertex groups with values from zero to one.
It defines the continuous transition across joints; automatic weights produce a baseline, but
clean skinning comes from inspecting and correcting the deformations in pose.

## Why it works

For every joint, test the full expected rotation range in Pose Mode. Smooth the influence across
the joint so nearby vertices share weight between the two relevant bones, then normalize so a
vertex is not accidentally over- or under-driven. Use mirrored weights only on genuinely
symmetric geometry, and inspect the vertex groups at shoulders, hips, elbows, knees, wrists, and
clothing edges before export.

When an item is created by duplicating a fitted part of the body mesh, it inherits the exact
vertex-group weights. That is preferable to automatic weights because the garment follows the
same local deformation as the body. Transfer weights only after the garment's topology is close to
the source body and verify the result in extreme poses.

## The catch

Smooth weights cannot fix bad topology. A joint needs enough edge loops to bend, and clothing
needs intentional clearance or it will clip even when its weights match the body perfectly. Do not
paint a skirt, coat tail, or hair mass as if it were skin; give it a deliberate bone chain and,
when appropriate, bounded [[vrchat-avatar-physics|PhysBones]].

## In practice here

The [[arii-blend-avatar]] clothing recipe starts with `Body Base`, so inherited weights are a
strong baseline. Pose-test every new garment before applying modifiers or export; the current
avatar has a large existing armature and should not be re-rigged merely to add fitted clothing.
