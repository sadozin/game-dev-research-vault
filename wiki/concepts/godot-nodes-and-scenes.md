---
title: Godot nodes and scenes
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[godot-key-concepts]]"
  - "[[godot-nodes-and-scenes]]"
  - "[[godot-nodes-scene-instances]]"
tags: [game-development, godot, scenes]
---

# Godot nodes and scenes

**Nodes** are the smallest pieces of a Godot game. **Scenes** are saved trees of nodes with
exactly one root. At runtime, scenes sit inside other scenes and form the **scene tree**.

If you only learn one structural rule: **build gameplay objects as scenes, not as loose nodes
dumped into one giant level.**

## What every node has

- A **name** (used by paths and `$Name` lookups — names matter)
- **Properties** editable in the Inspector
- Optional **script** that extends the node type
- Optional **children** (forms a tree)
- Engine callbacks such as `_ready()` and `_process(delta)`

Combine specialized nodes instead of inventing one mega-node. Example player:

```
Player (CharacterBody2D or CharacterBody3D)
├── Sprite2D or MeshInstance3D
├── CollisionShape2D or CollisionShape3D
└── Camera2D or Camera3D
```

## Scenes

| Rule | Detail |
|---|---|
| One root | Every scene has a single root node |
| Save as `.tscn` | Text file under `res://` |
| Instances | You can place many copies of one scene |
| Nested scenes | Instance a scene as a child of another |
| Main scene | Project setting: first scene when the game starts |

When a scene is instanced in another scene, the editor shows it as **one node** until you open
the packed scene. That is intentional encapsulation.

## Paths and `res://`

- `res://` means project root. Always work inside the project folder for assets and scenes.
- Node paths use `/` between names: `ShieldBar/AnimationPlayer`.
- Lookups use the **name**, not the class type. Renaming a node breaks `$OldName` until you update code.

## Creating and freeing nodes in code

```gdscript
# Create
var sprite := Sprite2D.new()
add_child(sprite)

# Get existing child
@onready var camera := $Camera2D
# same as: get_node("Camera2D")

# Instance a scene file
var packed := preload("res://enemies/slime.tscn")
var enemy := packed.instantiate()
add_child(enemy)

# Delete safely (end of frame)
enemy.queue_free()
```

Prefer `queue_free()` over `free()` so the current frame finishes cleanly. Freeing a parent
frees its children.

## Editor habits that scale

1. One gameplay idea → one scene file (`player.tscn`, `main_menu.tscn`, `coin.tscn`).
2. Keep roots typed correctly: UI under `Control`, 3D under `Node3D`, 2D under `Node2D`.
3. Name nodes clearly (`HealthBar`, not `Node2D2`).
4. Prefer instancing scenes for bullets/enemies over hand-placing hundreds of unique nodes.
5. Run **current scene** (F6) while building a piece; run **main scene** (F5) for full flow.

## Why it works

Trees give hierarchy (local transforms, ownership, batch free). Scenes give reuse and clear
boundaries. Together they replace both "prefab" and "level file" concepts from other engines
with one idea.

## The catch

- Deep `get_node("A/B/C/D")` paths are brittle. Prefer `@onready` on nearby nodes, signals, or
  exported `NodePath`s.
- Crossing scene boundaries with long absolute paths couples systems tightly. Prefer signals
  ([[godot-signals]]) or a small API on the scene root script.

## Related

- [[godot-engine-workflow]] · [[godot-gdscript-scripting]] · [[godot-signals]] · [[godot-asset-placement]]
