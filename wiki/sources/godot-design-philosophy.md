---
title: "Source: Godot — design philosophy"
type: source
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "raw/godot-design-philosophy.md"
tags: [source, godot, game-development]
---

# Source: Godot — design philosophy

- **Author:** Godot Engine documentation contributors
- **Published:** Godot 4.x stable documentation
- **URL:** https://docs.godotengine.org/en/stable/getting_started/introduction/godot_design_philosophy.html
- **Retrieved:** 2026-07-11
- **Raw:** `raw/godot-design-philosophy.md` (provenance only)

## Summary

Godot is composition-first: nest and inherit scenes rather than forcing one rigid pattern.
Nodes are typed hierarchies (not a pure ECS "component bag"). The editor is itself a Godot
application, so the UI system is battle-tested and `@tool` scripts can run in-editor.
2D and 3D are separate engines; 2D's base unit is the pixel. GDScript is first-class and
tightly integrated; C# and GDExtension cover other languages. The engine is MIT open source
and community-driven. Prefer trying the workflow over feature checklists when choosing engines.

## Compiled into

- [[godot-engine-workflow]]
- [[game-engine-selection]]
