---
title: "Source: Godot — nodes and scene instances from code"
type: source
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "raw/godot-nodes-scene-instances.md"
tags: [source, godot, game-development]
---

# Source: Godot — nodes and scene instances from code

- **Author:** Godot Engine documentation contributors
- **Published:** Godot 4.x stable documentation
- **URL:** https://docs.godotengine.org/en/stable/tutorials/scripting/nodes_and_scene_instances.html
- **Retrieved:** 2026-07-11
- **Raw:** `raw/godot-nodes-scene-instances.md` (provenance only)

## Summary

Access children with `get_node("Name")` or `$Name` / `$Path/To/Node`. Paths use `/` and
look up by **node name**, not type. Create with `Type.new()` then `add_child`. Delete with
`queue_free()` (preferred) or `free()`. Instance scenes: `load`/`preload` a `PackedScene`,
then `instantiate()`, then `add_child`. Preload runs at parse time in GDScript.

## Compiled into

- [[godot-nodes-and-scenes]]
- [[godot-gdscript-scripting]]
- [[godot-asset-placement]]
