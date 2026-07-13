---
title: Blender to Engine Scale and Axis
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[unreal-blender-fbx-import-scale]]"
  - "[[blender-scene-units-and-transforms]]"
tags: [game-development, blender, unreal, assets, pipeline]
---

# Blender to Engine Scale and Axis

Scale and axis conventions are part of an asset contract, not a cosmetic export setting. A mesh can
look correct in Blender yet arrive too large, rotated, mirrored, or with transformed normals in an
engine if units, object transforms, forward axis, and up axis are not agreed before export.

## Why it works

The DCC establishes object-space geometry and a scene convention; the exporter writes that convention;
the engine importer converts it into engine units and coordinate space. Unreal uses centimeters as
its Unreal Unit and its FBX pipeline applies a defined version and import configuration. Consistent
transforms let collision, skeletons, animation, lightmaps, and physics share the same scale.

## The catch

Applying a scale twice creates tiny or huge assets, while leaving unapplied transforms can change
normals, bone lengths, or modifier results. Axis conversion can also invert handedness or rotate
animation roots. Importer auto-detection hides these errors until physics, sockets, camera framing,
or reimport differs from the original.

## In practice here

Set a documented scene unit and forward/up convention, apply transforms on export-ready objects, and
export a measured test cube plus a skeletal sample. Verify dimensions, orientation, normals, sockets,
collision, and animation in the target engine. Lock the exporter/importer version and settings so
reimports are reproducible rather than correcting scale per asset.
