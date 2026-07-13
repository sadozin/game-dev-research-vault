---
title: Godot MCP Integration
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[godot-editor-plugins-and-scenes]]"
  - "[[mcp-tools-authoring-safety]]"
tags: [game-development, godot, mcp, editor, tooling]
---

# Godot MCP Integration

Godot MCP integration should expose scene, node, resource, and editor operations through narrow tools
that respect Godot's SceneTree and resource ownership. The server should be able to inspect before it
mutates and should save only after a preview or explicit confirmation.

## Why it works

Godot editor plugins can extend the editor, and `@tool` scripts can inspect or modify the currently
edited scene. MCP can sit above those capabilities as a structured broker: query a scene tree, perform
a named change, run a validation step, and return the changed resource paths and diagnostics.

## The catch

Editor code runs in a live project context, where scene nodes become active on tree entry and scripts
may execute outside gameplay. A tool can accidentally alter the open scene, trigger side effects, or
save resources that were only meant as previews. Arbitrary GDScript execution defeats the safety value
of a domain-level integration.

## In practice here

Separate read, preview, and apply tools; identify scene/resource paths and expected revisions; sandbox
or allowlist scripts; and keep checkpoints before mutations. Validate node ownership, resource links,
and scene serialization after each edit, with explicit confirmation for deletes, reparenting, and saves.
