---
title: "Source: Godot — using signals"
type: source
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "raw/godot-signals.md"
tags: [source, godot, game-development]
---

# Source: Godot — using signals

- **Author:** Godot Engine documentation contributors
- **Published:** Godot 4.x stable documentation
- **URL:** https://docs.godotengine.org/en/stable/getting_started/step_by_step/signals.html
- **Retrieved:** 2026-07-11
- **Raw:** `raw/godot-signals.md` (provenance only)

## Summary

Signals decouple emitters from listeners. Connect in the editor (Signals dock) or in code
(`signal.connect(callable)` in Godot 4). Custom signals use the `signal` keyword and
`emit()`. Name callbacks like `_on_button_pressed`. Signals are first-class types since
Godot 4. Prefer past-tense event names (`health_depleted`). Common built-ins: `Button.pressed`,
`Timer.timeout`, area body enter signals.

## Compiled into

- [[godot-signals]]
- [[godot-gdscript-scripting]]
