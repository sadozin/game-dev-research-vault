---
title: Godot autoloads and globals
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[godot-key-concepts]]"
tags: [game-development, godot]
---

# Godot autoloads and globals

An **Autoload** (Project Settings → Globals → Autoload) is a scene or script Godot loads
**before** the main scene and keeps for the whole game run. In GDScript it is reachable by the
name you assign (e.g. `Game`, `Audio`, `Events`).

Autoloads solve "I need score/inventory/scene-switcher across scenes." They are easy to abuse.

## When Autoload is correct

Use Autoload if the system is **all three**:

1. Needs to exist regardless of which scene is current  
2. Holds process-wide state or services  
3. Is naturally singular (one audio router, one save manager)

Examples: `Game` (flow), `Save`, `Audio`, `Steam` wrapper, `Analytics`, thin `Events` bus.

## When Autoload is wrong

| Need | Prefer |
|---|---|
| Level-only logic | Level scene script |
| Player stats for one run | Player node or run Resource on Main |
| Enemy AI | On enemy scene |
| UI widget state | On that UI scene |

Too many Autoloads create hidden global mutable state — hard for AI agents to reason about.

## How registration works

1. Script extends `Node` (or a scene with a root Node).
2. Project → Project Settings → Globals → Autoload → Add → name it `Game`.
3. Access: `Game.score += 1` (GDScript, Enable checked).

Autoload nodes appear under `/root` **before** the current scene. Never `queue_free()` them.

## Scene switcher pattern (safe free)

Do not free the current scene inside a button callback still running on that scene. Defer:

```gdscript
# res://autoload/game.gd
extends Node

var current_scene: Node

func _ready() -> void:
    current_scene = get_tree().root.get_child(-1)

func goto_scene(path: String) -> void:
    _deferred_goto_scene.call_deferred(path)

func _deferred_goto_scene(path: String) -> void:
    current_scene.free()
    var packed := ResourceLoader.load(path) as PackedScene
    current_scene = packed.instantiate()
    get_tree().root.add_child(current_scene)
    get_tree().current_scene = current_scene
```

Simpler alternative when enough: `get_tree().change_scene_to_file(path)`.

## Event bus pattern (optional)

```gdscript
# events.gd Autoload
extends Node
signal player_died
signal score_changed(value: int)
```

```gdscript
Events.score_changed.emit(10)
Events.player_died.connect(_on_player_died)
```

**Keep buses thin.** Prefer local signals for parent-child. Global bus only for distant systems
(achievements, music stingers, analytics).

## Order and dependencies

Autoload list order is tree order. If `A` needs `B` in `_ready`, put `B` above `A` in the
Autoload list, or defer work with `call_deferred`.

## Testing tip

Scenes that **require** Autoloads cannot F6 cleanly unless Autoloads always exist (they do when
running from the project). Still avoid Autoload for pure unit-testable math — keep pure functions
in RefCounted helper classes.

## Why it works

Autoloads give a stable service locator for cross-cutting concerns without fake "manager nodes"
dumped into every level.

## The catch

- Global mutable state races and order bugs.
- Overuse recreates the "Service Locator hell" problem.
- C# needs an explicit `Instance` pattern; GDScript name access is automatic when Enable is on.

## Related

- [[godot-scene-architecture]] · [[godot-resources-and-data]] · [[godot-ai-build-playbook]]
