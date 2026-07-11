---
title: Godot AI build playbook
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[godot-key-concepts]]"
  - "[[godot-design-philosophy]]"
  - "[[godot-physics-docs]]"
  - "[[godot-animation-docs]]"
tags: [game-development, godot]
---

# Godot AI build playbook

This page is a **working contract for any model building a Godot game**. Follow it to
avoid the common failure modes: giant unusable scenes, hard-coded node paths, wrong physics
bodies, broken exports, and "works in editor only" bugs.

Cross-links point at deeper topic pages. Read those when a section names a system you do not
know yet.

## Zero-to-playable vertical slice (order matters)

Build the **smallest fun loop** before polish. Typical order:

1. **Project + folders** — see recommended layout below.
2. **Main scene shell** — `Main` → `World` + `GUI` ([[godot-scene-architecture]]).
3. **Player scene** — CharacterBody + collision + sprite/mesh + camera ([[godot-physics-bodies]]).
4. **Input Map actions** — never hardcode only `KEY_W` ([[godot-input-handling]]).
5. **One level or arena** — static collision + spawn points ([[godot-asset-placement]] / [[godot-tilemaps]]).
6. **One interactable** — coin/door with Area + signal ([[godot-signals]]).
7. **One UI readout** — score/health via signal to HUD ([[godot-ui-controls]]).
8. **One polish pass** — sound or AnimationPlayer clip.
9. **Export debug** to target OS once ([[godot-export-and-release]]).

Do **not** start with shaders, multiplayer, or a full inventory system.

## Recommended project layout

```
res://
  project.godot
  main.tscn                 # entry / Main root
  autoload/                 # global.gd, audio_bus.gd, …
  scenes/
    player/player.tscn
    enemies/slime.tscn
    levels/level_01.tscn
    ui/hud.tscn
    ui/main_menu.tscn
  assets/
    art/ sprites/ models/ textures/
    audio/ sfx/ music/
  resources/                # .tres stats, themes, item defs
  scripts/                  # shared libs (optional if scripts live next to scenes)
```

**Rules**

- One **gameplay idea** → one scene file (`player.tscn`, not 40 loose nodes in the level).
- Keep **art** under `assets/`; keep **data** under `resources/` as custom Resources
  ([[godot-resources-and-data]]).
- Prefer **relative** structure so scenes run with F6 during isolation tests.

## Decision trees (pick the right tool fast)

### "Something should move"

| Goal | Use |
|---|---|
| Player / authored AI feel | `CharacterBody2D/3D` + `move_and_slide` |
| Tumbles with forces | `RigidBody2D/3D` |
| Never moves (wall) | `StaticBody2D/3D` |
| Overlap only (trigger) | `Area2D/3D` + signals |
| UI element | `Control` tree, not physics body |

### "Something should talk to something else"

| Relationship | Prefer |
|---|---|
| Child → parent "I finished" | `signal` emit |
| Parent starts child behavior | public method / exported Callable |
| Many listeners, global event | Autoload event bus (sparingly) |
| Shared stats/config | Resource `.tres` on export var |
| Find all enemies | `groups` (`add_to_group("enemies")`) |

Avoid: long absolute paths like `/root/Main/World/Level/Player/…` from deep children.

### "Something should change over time"

| Need | Tool |
|---|---|
| One-shot polish, UI fade | `Tween` / `create_tween()` |
| Authored timeline multi-track | `AnimationPlayer` |
| Locomotion blend / state graph | `AnimationTree` |
| Frame-by-frame code | `_process` / `_physics_process` |

### "Something should find a path"

| World type | Tool |
|---|---|
| Grid / tiles only | `AStarGrid2D` |
| Free 2D/3D walk mesh | NavigationRegion + NavigationAgent |
| Simple "go to point, no obstacles" | steer with `direction_to` only |

## Scene independence checklist (must pass)

Before instancing a scene in multiple places, verify:

- [ ] No required parent type (works under any root that provides deps).
- [ ] No `$"../../Something"` assumptions.
- [ ] Signals document outputs; exported vars document inputs.
- [ ] Runs with F6 alone **or** fails loudly with `_get_configuration_warnings()`.
- [ ] Collision shapes present and unscaled.
- [ ] Physics layers set deliberately (not "everything on layer 1 forever").

## Code recipes AI should reuse

### Typed player stub (2D)

```gdscript
class_name Player
extends CharacterBody2D

@export var speed := 300.0
@export var jump_velocity := -400.0

signal died
signal health_changed(current: int, maximum: int)

var health := 3
var max_health := 3

func _physics_process(delta: float) -> void:
    if not is_on_floor():
        velocity += get_gravity() * delta
    if Input.is_action_just_pressed("jump") and is_on_floor():
        velocity.y = jump_velocity
    var dir := Input.get_axis("move_left", "move_right")
    velocity.x = dir * speed
    move_and_slide()

func take_damage(amount: int) -> void:
    health = max(health - amount, 0)
    health_changed.emit(health, max_health)
    if health == 0:
        died.emit()
        queue_free()
```

### Safe scene change (defer free)

```gdscript
# In Autoload Game
func change_scene(path: String) -> void:
    get_tree().change_scene_to_file(path)
# For custom flows, free current scene only via call_deferred — see [[godot-autoloads]]
```

### Spawn with ownership

```gdscript
func spawn(scene: PackedScene, parent: Node, global_pos: Vector2) -> Node:
    var n := scene.instantiate()
    parent.add_child(n)
    if n is Node2D:
        (n as Node2D).global_position = global_pos
    return n
```

### Connect signal safely

```gdscript
func _ready() -> void:
    if not died.is_connected(_on_died):
        died.connect(_on_died)
```

## Anti-patterns (do not generate these)

| Anti-pattern | Why it fails | Do instead |
|---|---|---|
| One 2000-node level scene | Uneditable, no reuse | Prop scenes + instances |
| `get_node("/root/...")` everywhere | Breaks on rename/restructure | Signals, exports, groups |
| Scale collision shapes | Wrong physics | Resize shape resource |
| RigidBody player without forces plan | Floaty / unstable | CharacterBody |
| `position +=` on CharacterBody | Ignores collision | `move_and_slide` |
| `velocity * delta` into `move_and_slide` | Double time scale | Set `velocity`, call slide |
| Busy `_process` for physics | Frame-rate dependent | `_physics_process` |
| Autoload for every system | Hidden globals, test hell | Scenes + Resources |
| Unique secrets in export_presets | Leaked keys | credentials file, not git |
| Building multiplayer first | Debug explosion | Single-player slice first |

## Groups, unique names, and finding nodes

```gdscript
add_to_group("enemies")
get_tree().call_group("enemies", "apply_slow", 0.5)

# Unique name in scene: %HurtBox (set in editor)
@onready var hurt_box := %HurtBox
```

Use groups for **sets**. Use `%UniqueName` for **one** important child inside a scene.
Use Autoload for **process-wide** services only ([[godot-autoloads]]).

## Debugging efficiency

1. **Remote scene tree** while game runs — see real hierarchy.
2. **Visible collision shapes** (Debug menu).
3. **Print on signals**, not every frame.
4. Breakpoints in script editor; `breakpoint` keyword in code.
5. If input "dies", check Control focus / `_unhandled_input` order ([[godot-input-handling]]).
6. If pathfinding empty, await physics frame after load ([[godot-navigation]]).

## Performance defaults for AI-built prototypes

- Draw calls: atlas sprites / share materials where easy.
- Prefer fewer lights with shadows ([[godot-3d-rendering-basics]]).
- Object pooling only after profiler shows spawn cost ([[game-performance-profiling]]).
- Do not micro-optimize before a playable loop exists.

## Definition of done (per feature)

A feature is done only when:

1. It works in isolation (F6) **and** in Main (F5).
2. No new hard absolute paths.
3. Layers/masks/groups documented in a one-line comment or project layer names.
4. Failure modes handled (null body, double connect, freed node).
5. If public research was updated, publish vault ([[game-dev-research-vault]] policy).

## Genre shortcuts

When the user names a genre, scaffold from [[godot-genre-build-checklists]] (platformer,
top-down, twin-stick, RPG, third/first person, puzzle) instead of inventing a new tree.

## Related deep pages

- Architecture: [[godot-scene-architecture]] · [[godot-autoloads]] · [[godot-resources-and-data]]
- Systems: [[godot-input-handling]] · [[godot-physics-bodies]] · [[godot-signals]] ·
  [[godot-save-and-load]] · [[godot-multiplayer]] · [[godot-audio]] · [[godot-particles]]
- Content: [[godot-tilemaps]] · [[godot-animation-tree]] · [[godot-ui-controls]] ·
  [[godot-navmesh-baking]] · [[godot-3d-transforms]]
- Ship/ops: [[godot-web-export]] · [[godot-dedicated-servers]] · [[godot-export-and-release]]
- Debug: [[godot-debug-and-profiler]]
- Genres: [[godot-genre-build-checklists]]
- Hub: [[godot-engine-workflow]]
