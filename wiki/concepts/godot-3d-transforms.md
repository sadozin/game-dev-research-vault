---
title: Godot 3D transforms
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[godot-systems-batch-3-docs]]"
tags: [game-development, godot, 3d]
---

# Godot 3D transforms

For 3D gameplay, **do not drive motion with Euler `rotation` every frame**. Use
`Transform3D` / `Basis` vectors. Eulers have order dependence, gimbal lock, and bad
interpolation paths.

## Transform anatomy

```
transform.basis.x  # right
transform.basis.y  # up
transform.basis.z  # back  (so -Z is forward in Godot)
transform.origin   # position (same as position property)
```

- Local: `transform` relative to parent  
- World: `global_transform`  

Default basis ≈ identity: X right, Y up, Z back.

## Practical recipes

### Shoot forward

```gdscript
bullet.global_transform = global_transform
# CharacterBody/RigidBody facing -Z
bullet.linear_velocity = -global_transform.basis.z * speed
```

### Strafe / move in facing plane

```gdscript
var input := Input.get_vector("left", "right", "forward", "back")
var direction := (transform.basis * Vector3(input.x, 0, input.y)).normalized()
velocity.x = direction.x * speed
velocity.z = direction.z * speed
move_and_slide()
```

### Look detection (dot product)

```gdscript
var to_player := (player.global_position - enemy.global_position).normalized()
if to_player.dot(-enemy.global_transform.basis.z) > 0.5:
    enemy.see_player()
```

## FPS look (angles outside the transform)

Keep accumulators, rebuild basis each frame:

```gdscript
var yaw := 0.0
var pitch := 0.0

func _unhandled_input(event: InputEvent) -> void:
    if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
        yaw -= event.relative.x * sens
        pitch = clampf(pitch - event.relative.y * sens, deg_to_rad(-90), deg_to_rad(90))
        # body yaw
        transform.basis = Basis(Vector3.UP, yaw)
        # head pitch on child
        $Head.rotation.x = pitch
```

Order matters: yaw then pitch. Do not read Eulers back from the basis for accumulation.

## Continuous rotation precision

Spinning every frame deforms bases. Orthonormalize periodically:

```gdscript
transform = transform.orthonormalized()
# re-apply scale on children, not the spinning root
```

Scale mesh children, not the physics root you rotate every frame.

## Interpolation

Prefer **quaternion slerp** between orientations:

```gdscript
var a := Quaternion(global_transform.basis)
var b := Quaternion(target.global_transform.basis)
global_transform.basis = Basis(a.slerp(b, t))
```

## Editor vs code

`rotation` / `rotation_degrees` in the Inspector is fine for static placement. Runtime gameplay
code should think in **vectors and bases**.

## Related

- [[godot-3d-rendering-basics]] · [[godot-physics-bodies]] · [[godot-animation-tree]] ·
  [[godot-genre-build-checklists]]
