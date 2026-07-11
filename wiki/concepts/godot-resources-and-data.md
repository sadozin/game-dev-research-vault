---
title: Godot resources and data
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[godot-gdscript-basics]]"
tags: [game-development, godot]
---

# Godot resources and data

**Nodes** do behavior (draw, simulate, layout). **Resources** hold **data**. Textures, meshes,
animations, audio streams, fonts, scripts, packed scenes, and your custom `.tres` files are all
resources.

This split is how you keep content data-driven and share memory safely.

## Core facts

1. Loading a resource path returns the **same shared instance** if already in memory.
2. Resources are reference-counted; they free when nothing references them.
3. Scenes on disk are `PackedScene` resources; call `instantiate()` to build node trees.
4. Resources can be **external** files or **built-in** inside a `.tscn`.

## load vs preload

| | `preload("res://x")` | `load("res://x")` |
|---|---|---|
| When | Parse/compile time | Runtime |
| Path | Must be constant string | Can be variable |
| Use | Hot paths, bullets, UI icons | Dynamic paths, mods |

```gdscript
const BulletScene := preload("res://scenes/bullet.tscn")
var path := "res://levels/%s.tscn" % level_id
var packed: PackedScene = load(path)
```

## Custom Resource classes (data-driven design)

Use custom Resources like Unity ScriptableObjects for stats, items, dialog lines, waves.

```gdscript
# bot_stats.gd
class_name BotStats
extends Resource

@export var max_health: int = 10
@export var move_speed: float = 120.0
@export var damage: int = 1

func _init(p_hp := 10, p_speed := 120.0, p_dmg := 1) -> void:
    max_health = p_hp
    move_speed = p_speed
    damage = p_dmg
```

```gdscript
# enemy.gd
extends CharacterBody2D
@export var stats: BotStats

func _ready() -> void:
    assert(stats != null, "Assign BotStats resource")
```

Create `bot_stats.tres` in the FileSystem dock, edit in Inspector, assign to enemies. Designers
tune numbers without code changes.

**Rules for Inspector-friendly resources**

- Provide defaults for all `_init` parameters.
- Use top-level `class_name` (not inner `class`) so serialization works.
- Export nested Resources for tables/curves.

## External vs built-in

| Built-in in scene | External `.tres` / art file |
|---|---|
| Fine for one-off | Reuse across scenes |
| Harder to share | Version-control friendly text `.tres` |
| | Clear ownership of art |

Prefer **external TileSets, Themes, Stats, Materials** once more than one scene needs them.

## Saving runtime data

- Use `user://` for save games (writable user data path), not `res://` (read-only in export).
- Prefer ResourceSaver/ResourceLoader or JSON for simple saves; match threat model (cheating).

```gdscript
var save_path := "user://save.json"
```

## Shared resource mutation trap

Because loads share instances, **mutating** a resource mutates all users:

```gdscript
# BAD if texture/material shared
material.albedo_color = Color.RED  # may affect every mesh using it

# GOOD
var mat := material.duplicate()
mat.albedo_color = Color.RED
material = mat
```

Duplicate when you need per-instance changes.

## Data architecture patterns

| Pattern | How |
|---|---|
| Item database | `Dictionary` Resource mapping id → ItemResource |
| Wave table | Resource with array of WaveResource |
| Loot table | Resource with weighted entries |
| Theme | Theme resource on root Control |
| Localization | Translation resources / CSV import |

## Why it works

Separating data from nodes lets AI generate content as assets, keeps memory shared, and makes
balancing possible without rewriting scripts.

## The catch

- Editing a shared resource "fixes" one enemy and breaks another unexpectedly.
- Inner classes as Resource scripts will not serialize cleanly — use `class_name` files.
- Huge `.tscn` with many built-ins becomes merge hell in git — externalize.

## Related

- [[godot-nodes-and-scenes]] · [[godot-gdscript-scripting]] · [[godot-ai-build-playbook]] ·
  [[godot-tilemaps]]
