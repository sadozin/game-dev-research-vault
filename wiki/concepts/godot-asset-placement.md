---
title: Godot asset placement
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[godot-importing-3d-scenes]]"
  - "[[godot-introduction-to-3d]]"
  - "[[godot-nodes-scene-instances]]"
tags: [game-development, godot, assets, blender]
---

# Godot asset placement

**Asset placement** means getting art into Godot and putting instances into playable scenes
with correct scale, collision, and reuse. Godot thinks in **imported scenes and resources**,
not "one mesh file floating forever."

## Pipeline overview

```
DCC tool (Blender, etc.)
    → export or save into project folder
    → Godot imports (creates .import + internal resources)
    → you instance into a level scene
    → add collision, scripts, signals, lighting
```

Work **inside the project directory** so paths stay `res://...`.

## 3D formats (pick deliberately)

| Format | Recommendation |
|---|---|
| **glTF 2.0** (`.glb` / `.gltf`) | **Default choice** — full scenes, materials, skins, animation |
| `.blend` | Convenient if whole team has Blender; Godot shells out to Blender → glTF |
| FBX | Supported (ufbx in modern Godot 4); use when pipeline requires it |
| OBJ | Simple static meshes only (no real PBR/skin/anim) |
| DAE | Legacy; prefer glTF |

**Pro default:** author in Blender → export **`.glb`** → commit glb + textures as needed →
instance in Godot.

## Import behaviors that matter

- Dropping a 3D file into the project imports a **scene**, not only a Mesh resource.
- You can open Advanced Import Settings to adjust materials, meshes, animation, and generate
  physics shapes depending on version/settings.
- Node name **suffixes** in the DCC can customize generated node types (see official import
  docs when you need colliders from export names).
- Reimport when the source file changes; do not hand-edit generated import products as source
  of truth.

## Placement workflow in the editor

1. Create or open a level scene (`Node3D` root).
2. Drag imported scene or mesh into the viewport / scene tree (instance).
3. Set transform with gizmos; keep **scale ≈ 1** on instances when possible (scale in DCC).
4. Add **collision** (`StaticBody3D` / `CollisionShape3D` or imported colliders).
5. For repeated props, save a **prop scene** (`crate.tscn`) that wraps mesh + collision +
   optional script; instance that everywhere.
6. Add environment: `DirectionalLight3D`, `WorldEnvironment`, `Camera3D` (or player camera).

### Grid and snap

Enable snap for modular kits (walls, floors). Godot's 3D grid defaults to **1 m**. Modular
assets should be authored to meter modules (1 m, 2 m, 4 m).

## 2D assets (short)

- Drop PNG/SVG/WebP into the project; assign to `Sprite2D`, `TextureRect`, tilemaps, etc.
- Use the Import dock for filter, mipmaps, compression per texture type (UI vs world art).

## Runtime placement (spawning)

```gdscript
const Crate := preload("res://props/crate.tscn")

func spawn_crate(at: Vector3) -> void:
    var node := Crate.instantiate()
    add_child(node)
    node.global_position = at
```

Preload shared scenes; instance many times. Do not `load` the same path every shot if you can
cache the `PackedScene`.

## Relation to Blender pipeline research

Godot's preferred exchange format (glTF) matches the general game-art advice in
[[blender-game-asset-pipeline]] and [[texture-baking-for-games]]: sensible scale, clean
transforms, baked maps where needed, predictable materials.

## Why it works

Importing whole scenes preserves hierarchy (Armature → meshes → attachments). Prop scenes with
collision turn art into gameplay objects. Instancing keeps memory and authoring sane.

## The catch

- Leaving Blender objects at random scales forces per-instance scale hacks in Godot.
- Committing only `.blend` can force every teammate to install Blender; glTF is more portable.
- Forgetting collision on pretty meshes makes "solid" art non-solid in play.
- Editing an imported instance deeply without making a local prop scene loses reuse.

## Related

- [[godot-3d-rendering-basics]] · [[godot-nodes-and-scenes]] · [[blender-game-asset-pipeline]] ·
  [[texture-baking-for-games]] · [[level-of-detail]]
