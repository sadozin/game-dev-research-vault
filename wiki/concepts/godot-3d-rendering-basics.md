---
title: Godot 3D rendering basics
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[godot-introduction-to-3d]]"
  - "[[godot-importing-3d-scenes]]"
tags: [game-development, godot, 3d, rendering]
---

# Godot 3D rendering basics

Godot 3D uses **Node3D** as the base for anything with a 3D transform. You place meshes,
lights, and cameras in metric space, then render through a **Camera3D**. Many gameplay patterns
mirror 2D (bodies, areas, animation), but math and lighting are stricter.

## Core rules (memorize these)

1. **1 unit = 1 meter.** Author art and levels in real scale. Random scales create physics and
   floating-point pain.
2. **Y is up.** Right-handed coordinates. For many objects, local **−Z / Z** is the facing
   axis used by cameras and lights (check the specific node docs when aiming).
3. **No Camera3D → black screen.** Always place an active camera.
4. **Meshes do not light themselves.** Add lights and/or a **WorldEnvironment** (ambient, sky,
   tonemap, post-FX).
5. Editor **preview sun/environment** is editor-only. Real shipped look needs real nodes.

## Essential 3D nodes

| Node | Job |
|---|---|
| `Node3D` | Empty transform pivot / organizer |
| `MeshInstance3D` | Draws a mesh resource |
| `Camera3D` | Viewpoint (perspective or orthogonal) |
| `DirectionalLight3D` | Sun/moon style light |
| `OmniLight3D` / `SpotLight3D` | Point / cone lights |
| `WorldEnvironment` | Background, ambient, glow, SSAO, etc. |
| `CSG*` nodes | Block-out geometry for prototypes |
| `StaticBody3D` + `CollisionShape3D` | Immovable collision |
| `CharacterBody3D` | Player-style movement body |
| `RigidBody3D` | Dynamic physics body |

## Transforms

A Node3D has:

- `position` (Vector3)
- `rotation` (Euler radians) or better basis/quaternion when interpolating
- `scale`

Children inherit parent transforms. Moving a parent moves the whole branch — use empty Node3D
pivots for doors, turrets, and attach points.

Editor tools: **W** move, **E** rotate, **R** scale, **F** frame selection, **Ctrl** snap.

## What the player actually sees

Rendering result depends on:

- Mesh + materials (albedo, roughness, metalness, emission, normal maps)
- Lights and shadows (budget them — shadows are expensive)
- Environment (sky, ambient, exposure)
- Camera (FOV, near/far clip)
- Optional GI / lightmaps / reflection probes for quality (project-dependent)

Start simple: one DirectionalLight3D + WorldEnvironment + Camera3D + a few MeshInstance3Ds.
Add complexity only when the scene reads well.

## Content sources

| Source | When |
|---|---|
| Imported glTF (recommended) | Real art from Blender/etc. |
| CSG | Greybox levels fast |
| Primitives / ArrayMesh | Code-driven or tools |
| Sprite3D | 2D billboards in 3D |

See [[godot-asset-placement]] for import and level assembly.

## Performance instincts (beginner-pro)

- Prefer fewer materials and atlased textures when possible.
- Shadow-casting lights are costly; limit them.
- Use LODs and occlusion when scenes grow ([[level-of-detail]], [[visibility-culling]]).
- Profile on target hardware ([[game-performance-profiling]]) — numbers beat guesses.

## Why it works

Parallel 2D/3D node APIs reduce relearning. Metric scale matches physics defaults. Separating
mesh, light, environment, and camera makes each problem testable.

## The catch

- Euler rotation order can surprise you; for complex animation use AnimationPlayer / Skeleton3D
  and quaternions where needed.
- Giant scales (buildings as 1000-unit cubes "for convenience") break physics and shadows.
- Importing without fixing materials/culling leads to shiny or double-sided performance traps.

## Related

- [[godot-asset-placement]] · [[godot-nodes-and-scenes]] · [[real-time-lighting-budget]] ·
  [[level-of-detail]] · [[blender-game-asset-pipeline]]
