---
title: "Source: Godot — Editor Plugins and SceneTree"
type: source
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "https://docs.godotengine.org/en/stable/tutorials/plugins/editor/making_plugins.html"
  - "https://docs.godotengine.org/en/stable/tutorials/scripting/scene_tree.html"
tags: [source, game-development, godot, mcp, editor]
---

# Source: Godot — Editor Plugins and SceneTree

- **Author:** Godot Engine contributors
- **Published:** Undated (Godot stable documentation)
- **URL:** https://docs.godotengine.org/en/stable/tutorials/plugins/editor/making_plugins.html
- **Retrieved:** 2026-07-11

## Summary

Godot editor plugins add editor functionality through scripts, while `@tool` scripts can run in the
editor and access the currently edited scene. The SceneTree controls node activation and ordered
processing, so editor automation must distinguish a saved resource from a live tree with behavior.

## Compiled into

- [[godot-mcp-integration]] — editor extension, live-scene context, and validation boundaries
