---
title: Godot GDScript scripting
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[godot-gdscript-basics]]"
  - "[[godot-nodes-scene-instances]]"
  - "[[godot-signals]]"
tags: [game-development, godot, scripting]
---

# Godot GDScript scripting

**GDScript** is Godot's built-in language. It looks a bit like Python (indentation, `func`),
but it is **not** Python. It is designed for game nodes: vectors, signals, scene access, and
editor exports are first-class.

You attach a `.gd` script to a node. The script **extends** that node type and becomes the
behavior of that instance.

## Minimal mental model

```gdscript
extends Node2D          # this script is a Node2D
class_name Player       # optional global name

@export var speed := 200.0
@onready var sprite := $Sprite2D

signal died

func _ready() -> void:
    # children exist; safe to touch the tree
    pass

func _process(delta: float) -> void:
    # every frame (idle)
    position.x += speed * delta

func _physics_process(delta: float) -> void:
    # fixed-rate physics step — movement/collision usually here
    pass
```

### Lifecycle you must know

| Callback | When |
|---|---|
| `_init()` | Object constructed (before tree entry for nodes) |
| `_ready()` | Node and children entered the tree; use for setup |
| `_process(delta)` | Every frame |
| `_physics_process(delta)` | Physics tick |
| `_exit_tree()` | Leaving the tree / cleanup |

`@onready var x = $Child` assigns just before `_ready()`. Do not use `@onready` and `@export`
on the same variable (export value gets overwritten).

## Syntax essentials (clear rules)

- **Types:** `var hp: int = 10` or `var hp := 10` (inferred).
- **Integer division:** `5 / 2 == 2`. Use `5 / 2.0` for float results.
- **Strings:** `"text"`, format with `%` or string methods as needed.
- **Arrays / dicts:** `[]`, `{}`; typed forms `Array[int]`, `Dictionary[String, int]` (Godot 4.x).
- **Vectors:** `Vector2`, `Vector3` are builtins — use them constantly.
- **Signals:** `signal hit(damage)`; emit with `hit.emit(3)`.
- **Await:** `await get_tree().create_timer(1.0).timeout` pauses a coroutine until a signal.
- **Preload vs load:** `preload` at parse time; `load` at runtime.

## Style (official conventions)

| Kind | Style |
|---|---|
| Node / class names | PascalCase (`Player`, `MainMenu`) |
| functions / variables | snake_case (`move_speed`) |
| constants | ALL_CAPS |
| private-ish members | often `_leading_underscore` |

## Talking to other nodes

```gdscript
# Nearby child
$AnimationPlayer.play("run")

# Connect signal in code (Godot 4 style)
$Timer.timeout.connect(_on_timer_timeout)

# Instance content
var bullet := preload("res://bullet.tscn").instantiate()
owner.add_child(bullet)  # or get_parent() / a dedicated spawn root
```

Prefer **signals** for "something happened" across scene boundaries. Prefer **methods on the
scene root** for intentional APIs (`player.take_damage(5)`).

## C# and GDExtension (when GDScript is not enough)

- **C#** is officially supported for teams that want .NET.
- **GDExtension** (C++, Rust, etc.) for native plugins and heavy systems without forking the
  engine.

Most gameplay still starts fastest in GDScript.

## Why it works

GDScript maps 1:1 onto nodes and the editor (exports, signals dock, docs comments). Gradual
typing gives speed of writing with optional safety. Built-in game types remove boilerplate.

## The catch

- Dynamic habits without types make large refactors painful — use types on public APIs early.
- Holding references to freed nodes crashes; after `queue_free`, treat the instance as dead.
- `$` paths break when names change — rename carefully or use unique names (`%Node`).

## Related

- [[godot-nodes-and-scenes]] · [[godot-signals]] · [[godot-ui-controls]] · [[godot-engine-workflow]]
