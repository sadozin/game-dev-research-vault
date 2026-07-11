---
title: "Source: Godot — UI controls, anchors, containers"
type: source
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "raw/godot-ui-index.md"
tags: [source, godot, game-development, ui]
---

# Source: Godot — UI controls, anchors, containers

- **Author:** Godot Engine documentation contributors
- **Published:** Godot 4.x stable documentation
- **URLs:**
  - https://docs.godotengine.org/en/stable/tutorials/ui/index.html
  - https://docs.godotengine.org/en/stable/tutorials/ui/size_and_anchors.html
  - https://docs.godotengine.org/en/stable/tutorials/ui/gui_containers.html
- **Retrieved:** 2026-07-11
- **Raw:** `raw/godot-ui-index.md` (provenance only)

## Summary

All UI is **Control** nodes. Split content (Button, Label, LineEdit) from layout
(BoxContainer, MarginContainer, ScrollContainer, TabContainer, etc.). Simple multi-resolution
layout uses **anchors** (0–1 relative to parent edges) plus **offsets** in pixels. Complex UI
uses nested **Containers**, which own child positions — manual placement is overridden.
Container child flags: Fill, Expand, Shrink Begin/Center/End, Stretch Ratio. Themes skin
controls globally. Godot's own editor UI is built from these containers.

## Compiled into

- [[godot-ui-controls]]
