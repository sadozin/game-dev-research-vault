---
title: Godot scene architecture
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[godot-key-concepts]]"
  - "[[godot-design-philosophy]]"
tags: [game-development, godot, scenes]
---

# Godot scene architecture

Good Godot projects are **graphs of independent scenes**, not one mega-scene. Architecture
decisions determine whether an AI (or human) can add features without breaking everything.

Official best-practice core: design scenes with **no hard environment dependencies**; inject
what they need from parents.

## Main / World / GUI shell

A robust default entry tree:

```
Main (Node) — main.gd owns flow
├── World (Node2D or Node3D) — gameplay levels swap here
└── GUI (Control) — menus, HUD, overlays (full-rect)
```

**Why:** changing levels replaces `World` children without deleting the HUD Autoload-style
lifetime issues. GUI can stay mounted across level loads.

```gdscript
# main.gd sketch
func load_level(path: String) -> void:
    for c in $World.get_children():
        c.queue_free()
    var level := load(path).instantiate()
    $World.add_child(level)
```

For simple games, `SceneTree.change_scene_to_file()` is fine. For control of transitions,
manual Main/World is better ([[godot-autoloads]] scene switcher pattern).

## Dependency injection patterns (child must not dig upward)

When a child needs the outside world, parent supplies it:

| Pattern | Direction | Use |
|---|---|---|
| **Signal** | Child → listeners | "Coin collected", "Door opened" |
| **Method call** | Parent → child | "Open", "Play intro" |
| **Callable export** | Parent assigns function | Flexible callbacks |
| **Node export** | Parent assigns target | `attack_target = player` |
| **NodePath export** | Parent assigns path | Resolved in child `_ready` |

```gdscript
# Child — no hardwired /root paths
signal activated
@export var target: Node2D

func interact() -> void:
    activated.emit()
    if target:
        target.call("on_interacted")
```

Siblings should **not** grab each other. Parent mediates: `$Left.target = $Right/Receiver`.

## Composition rules

1. **Nested scenes** for reusable prefabs (lantern inside city).
2. **Inheritance** of scenes when variants share structure (Enemy → FlyingEnemy) — use carefully.
3. Prefer **composition** (components as child scenes) over deep inheritance trees.
4. Root of a scene owns the public API (`class_name Player` methods).

## Where the player lives

Two strategies:

| Strategy | Pros | Cons |
|---|---|---|
| Player inside level scene | Simple | Must reparent on level change |
| Player under Main/World persistent | Consistent transitions | Camera/level bounds need care |

For multi-level games, **persistent player under World** reduces "special case" documentation.

## Transform independence

- Insert bare `Node` between parent and child to stop transform inheritance.
- Or set `top_level = true` on CanvasItem/Node3D when a child must ignore parent motion.

## Configuration warnings (self-documenting scenes)

```gdscript
@tool
extends Node2D

@export var required_marker: Marker2D

func _get_configuration_warnings() -> PackedStringArray:
    if required_marker == null:
        return ["Assign required_marker — spawn will fail."]
    return []
```

AI builders should add warnings for missing collision, missing AnimationPlayer, empty exports.

## Groups as soft architecture

```gdscript
func _ready() -> void:
    add_to_group("damageable")
```

Parents or systems call `get_tree().get_nodes_in_group("damageable")` without hard paths.

## Networking hint

Keep **local-only** controllers (input) separate from **replicated world** state so later
multiplayer does not require rewriting the entire tree.

## Anti-patterns

- Child scripts that `get_parent().get_parent().get_node("Player")`.
- Level scenes that assume they are always the main scene.
- Putting Autoload responsibilities into random nodes in the first level only.

## Related

- [[godot-nodes-and-scenes]] · [[godot-autoloads]] · [[godot-signals]] · [[godot-ai-build-playbook]]
