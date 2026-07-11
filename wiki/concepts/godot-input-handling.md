---
title: Godot input handling
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[godot-ui-docs]]"
tags: [game-development, godot, ui]
---

# Godot input handling

Godot models input as **InputEvent** objects flowing through the viewport. For games, you almost
always want **Input Map actions**, not raw keycodes alone.

## Input Map first (non-negotiable for shippable games)

Project → Project Settings → **Input Map**:

```
move_left, move_right, move_up, move_down
jump, attack, interact, pause
```

Bind keyboard **and** gamepad to the same actions.

```gdscript
func _physics_process(delta: float) -> void:
    var axis := Input.get_axis("move_left", "move_right")
    var dir := Input.get_vector("move_left", "move_right", "move_up", "move_down")
    if Input.is_action_just_pressed("jump"):
        jump()
```

| API | Meaning |
|---|---|
| `is_action_pressed` | Held |
| `is_action_just_pressed` | Edge this frame |
| `is_action_just_released` | Release edge |
| `get_axis` / `get_vector` | Analog-friendly composites |
| `Input.get_action_strength` | 0..1 pressure |

## Event pipeline (why UI "eats" gameplay input)

Rough order for each event:

1. `_input` on nodes (can mark handled early)
2. **GUI** (`Control._gui_input`, focus, mouse filters)
3. `_shortcut_input`
4. `_unhandled_key_input`
5. **`_unhandled_input`** ← best for gameplay that should yield to menus
6. Physics object picking (if enabled)

**Rule:** gameplay listens on `_unhandled_input` or polls `Input` in `_physics_process`.  
Menus use Controls. When a LineEdit is focused, gameplay should not also move the player —
unhandled path makes that natural.

```gdscript
func _unhandled_input(event: InputEvent) -> void:
    if event.is_action_pressed("pause"):
        get_tree().paused = true
        get_viewport().set_input_as_handled()
```

## Polling vs events

| Style | Best for |
|---|---|
| Poll `Input.is_action_*` in process | Continuous movement |
| `_unhandled_input` / `_input` | One-shots, UI-aware actions |
| Signals from Buttons | Menu clicks |

## Mouse and picking

- UI: Controls with `mouse_filter` Stop/Pass/Ignore.
- World click: enable object picking or raycast from camera in code.
- 2D: `CollisionObject2D` input events; 3D: `CollisionObject3D`.

## Touch and joypad

- Mobile: `InputEventScreenTouch` / `ScreenDrag`.
- Joypad axes: map deadzones in Input Map; use `get_vector` for twin-stick.

## Programmatic actions

```gdscript
var ev := InputEventAction.new()
ev.action = "attack"
ev.pressed = true
Input.parse_input_event(ev)
```

Useful for tutorials, AI-controlled demos, gesture recognition.

## Remapping at runtime

`InputMap` can add/erase events in code. Persist user remaps to `user://` config; do not expect
InputMap edits to auto-save into `project.godot` at runtime.

## AI builder checklist

- [ ] All player controls are **named actions**
- [ ] Gameplay uses unhandled path or ignores when `get_tree().paused`
- [ ] Pause menu grabs focus; resume releases it
- [ ] No sole dependency on `ui_*` defaults for final game (customize)
- [ ] Test keyboard **and** gamepad once

## Related

- [[godot-ui-controls]] · [[godot-physics-bodies]] · [[godot-ai-build-playbook]]
