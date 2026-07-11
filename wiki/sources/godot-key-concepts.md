---
title: "Source: Godot — key concepts overview"
type: source
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "raw/godot-key-concepts.md"
tags: [source, godot, game-development]
---

# Source: Godot — key concepts overview

- **Author:** Godot Engine documentation contributors
- **Published:** Godot 4.x stable documentation
- **URL:** https://docs.godotengine.org/en/stable/getting_started/introduction/key_concepts_overview.html
- **Retrieved:** 2026-07-11
- **Raw:** `raw/godot-key-concepts.md` (provenance only)

## Summary

A Godot game is a **tree of nodes** grouped into **scenes**. Scenes nest inside other scenes
and form the **scene tree** at runtime. Nodes talk without hard references by emitting
**signals** (observer pattern). Scenes act like both "levels" and "prefabs": a character, menu,
weapon, or house is usually its own scene. Saved scenes look like single nodes when instanced,
with internals hidden until you open the scene.

## Compiled into

- [[godot-engine-workflow]]
- [[godot-nodes-and-scenes]]
- [[godot-signals]]
