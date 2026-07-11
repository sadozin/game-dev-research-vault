---
title: Godot signals
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[godot-signals]]"
  - "[[godot-key-concepts]]"
tags: [game-development, godot, scripting]
---

# Godot signals

A **signal** is a named event a node can emit. Other nodes **connect** callables (functions)
to that signal. When the event happens, every connected function runs.

Signals implement the **observer pattern**: the emitter does not need to know who is listening.

## Why signals exist

Without signals, UI code and gameplay code often hard-reference each other:

- Bad: health bar script digs into `get_node("/root/Level/Player")` every frame
- Better: player emits `health_changed(new_value)`; HUD connects once in `_ready`

This keeps scenes reusable. A `Player` scene still works in a test room with no HUD.

## Built-in examples

| Node | Signal | Typical use |
|---|---|---|
| `Button` | `pressed` | Start game, confirm dialog |
| `Timer` | `timeout` | Cooldowns, spawn waves |
| `Area2D` / `Area3D` | `body_entered` | Coins, triggers, hurtboxes |
| `AnimationPlayer` | `animation_finished` | Chain actions |

## Connect in the editor

1. Select the emitting node.
2. Open the **Node → Signals** dock (next to Inspector).
3. Double-click the signal → choose the receiver node → create `_on_*` callback.

Good for fixed scene wiring (menu buttons).

## Connect in code (Godot 4)

```gdscript
func _ready() -> void:
    $Timer.timeout.connect(_on_timer_timeout)
    # or: $Button.pressed.connect(_on_button_pressed)

func _on_timer_timeout() -> void:
    visible = not visible
```

Connect from code when nodes are created at runtime or instanced dynamically.

## Custom signals

```gdscript
extends Node2D

signal health_changed(old_value: int, new_value: int)
signal health_depleted

var health := 10

func take_damage(amount: int) -> void:
    var old := health
    health -= amount
    health_changed.emit(old, health)
    if health <= 0:
        health_depleted.emit()
```

**Naming:** use past-tense / event language (`died`, `door_opened`), not commands (`kill`).

## Pro rules

1. Emit facts ("health is 3"), let listeners decide UI/FX/game over.
2. Do not depend on connection order for critical logic.
3. Disconnect when temporary listeners go away (or use `CONNECT_ONE_SHOT`).
4. Prefer signals over deep node paths across scene files.
5. For complex global events, consider an Autoload event bus — still signal-based, but
   introduce only when local signals get messy.

## Why it works

Loose coupling lets you swap HUDs, tutorials, or multiplayer listeners without rewriting the
player. Editor connections make simple UI trivial; code connections scale to spawning systems.

## The catch

- Overusing a global event bus becomes untraceable "mystery traffic." Start local.
- Forgetting to connect is a silent bug (nothing happens). Verify connections early.
- Circular signal chains (A triggers B triggers A) cause stacks — keep one direction of data.

## Related

- [[godot-gdscript-scripting]] · [[godot-nodes-and-scenes]] · [[godot-ui-controls]]
