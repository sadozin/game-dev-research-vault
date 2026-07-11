---
title: "Source: Godot — introduction to shaders"
type: source
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "raw/godot-shaders-introduction.md"
tags: [source, godot, game-development, rendering]
---

# Source: Godot — introduction to shaders

- **Author:** Godot Engine documentation contributors
- **Published:** Godot 4.x stable documentation
- **URL:** https://docs.godotengine.org/en/stable/tutorials/shaders/introduction_to_shaders.html
- **Retrieved:** 2026-07-11
- **Raw:** `raw/godot-shaders-introduction.md` (provenance only)

## Summary

Shaders are GPU programs; code runs per vertex/pixel in parallel with no frame-to-frame local
memory. Godot uses a GLSL-like language. First line sets `shader_type` (`spatial`,
`canvas_item`, `particles`, `sky`, `fog`, …). Main entry points: `vertex()`, `fragment()`,
`light()`. Render modes change pipeline behavior (`unshaded`, cull modes). Unused material
outputs are optimized out.

## Compiled into

- [[godot-shaders-basics]]
