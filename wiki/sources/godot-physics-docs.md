---
title: "Source: Godot — physics introduction and CharacterBody"
type: source
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "raw/godot-physics-introduction.md"
tags: [source, godot, game-development, physics]
---

# Source: Godot — physics introduction and CharacterBody

- **Author:** Godot Engine documentation contributors
- **Published:** Godot 4.x stable documentation
- **URLs:**
  - https://docs.godotengine.org/en/stable/tutorials/physics/physics_introduction.html
  - https://docs.godotengine.org/en/stable/tutorials/physics/using_character_body_2d.html
- **Retrieved:** 2026-07-11
- **Raw:** `raw/godot-physics-introduction.md` (provenance only)

## Summary

Godot collision objects: **Area** (detect/influence), **StaticBody** (world), **RigidBody**
(simulated forces), **CharacterBody** (code-driven movement). Shapes live on
CollisionShape children; never scale shapes with Node scale. Physics runs on fixed ticks —
use `_physics_process`. Layers vs masks select who collides with whom. CharacterBody must not
set `position` directly: use `move_and_collide` (manual response) or `move_and_slide`
(platformer/top-down sliding; do not multiply velocity by delta for slide).

## Compiled into

- [[godot-physics-bodies]]
