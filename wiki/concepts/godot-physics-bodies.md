---
title: Godot physics bodies
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[godot-physics-docs]]"
tags: [game-development, godot, physics]
---

# Godot physics bodies

Godot physics answers two questions: **did things touch?** (detection) and **what happens
next?** (response). You pick a body type that matches how much the engine should control
movement versus how much your code controls it.

2D and 3D use parallel types (`Area2D` / `Area3D`, and so on). Concepts below apply to both.

## The four collision object types

| Type | Engine moves it? | Your job | Typical use |
|---|---|---|---|
| **Area** | No | React to enter/exit signals; optional gravity override | Triggers, coins, hurtboxes, water |
| **StaticBody** | No | Place it; optional constant velocity for conveyors | Walls, floors, terrain |
| **RigidBody** | Yes (forces/impulses) | Apply forces; rarely set position directly | Crates, ragdolls, Angry-Birds blocks |
| **CharacterBody** | No | Code movement every physics tick | Players, enemies with authored control |

**Rule of thumb:** player/AI you want *game-feel control* → CharacterBody. Props that should
tumble realistically → RigidBody. Level geometry → StaticBody. Overlap events without solid
blocking → Area.

## Collision shapes

- Add `CollisionShape2D`/`3D` (or polygon) as a **child** of the body.
- A body with no shape does not collide.
- **Never scale the shape node** with Node scale tools. Resize the *shape resource* handles.
  Scale `(1,1)` / `(1,1,1)` stays default.

## Physics tick vs frame

Physics steps at a fixed rate (often 60 Hz). Put movement and collision code in
`_physics_process(delta)`, not `_process`, so behavior stays stable when FPS changes.

Always use `delta` for accelerations (gravity). CharacterBody slide movement has its own rules
below.

## Layers and masks

Each body has:

- **collision_layer** — which layers this body **exists on**
- **collision_mask** — which layers this body **looks for**

A collision happens only if A is on a layer that B masks **and** B is on a layer that A masks
(both sides must agree). Name layers in **Project Settings → Layer Names → 2D/3D Physics**
(walls, player, enemy, pickup, …).

## CharacterBody movement (pro core skill)

Do **not** assign `position` to move. Use:

### `move_and_slide()`

Best for platformers and top-down sliding along walls.

```gdscript
extends CharacterBody2D

@export var speed := 300.0
@export var jump_speed := -400.0

func _physics_process(delta: float) -> void:
    velocity += get_gravity() * delta
    if Input.is_action_just_pressed("jump") and is_on_floor():
        velocity.y = jump_speed
    var dir := Input.get_axis("ui_left", "ui_right")
    velocity.x = dir * speed
    move_and_slide()  # uses velocity property; do NOT multiply velocity by delta here
```

Helpers: `is_on_floor()`, `is_on_wall()`, `is_on_ceiling()` (grounded motion mode).

### `move_and_collide(motion)`

Moves by a **motion vector** (usually `velocity * delta`). Stops at first hit and returns a
collision object — or `null`. You write the response (bounce, damage, stop).

```gdscript
var collision := move_and_collide(velocity * delta)
if collision:
    velocity = velocity.bounce(collision.get_normal())
```

Use this for bullets, custom knockback, or when slide feels wrong.

## RigidBody notes

- Apply forces in `_integrate_forces(state)` when you need safe, synced control.
- Sleeping bodies stop simulating until disturbed — good for performance.
- Forcing `position` or `linear_velocity` every frame fights the solver; prefer forces.

## Why it works

Separating Area / Static / Rigid / Character matches real game needs: triggers, world,
simulation, and authored movement. Layers prevent "everything hits everything" chaos. Fixed
physics ticks keep gameplay stable.

## The catch

- Physics is **not deterministic** across machines/runs — do not rely on perfect replay from the
  physics engine alone.
- Wrong body type is the #1 beginner trap (RigidBody player that feels floaty; Area used as a
  solid wall).
- Forgetting shapes or masks looks like "collision is broken."

## Related

- [[godot-nodes-and-scenes]] · [[godot-gdscript-scripting]] · [[godot-navigation]] ·
  [[game-collision-design]]
