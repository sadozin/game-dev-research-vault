---
title: Unity MCP Scene Authoring
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[mcp-tools-scene-authoring-safety]]"
  - "[[unity-editor-scene-saving]]"
tags: [game-development, unity, mcp, editor, tooling]
---

# Unity MCP Scene Authoring

Unity scene authoring through MCP should expose structured operations over GameObjects, components,
assets, and scene state rather than arbitrary editor code. The useful abstraction is an inspectable
scene edit with explicit targets, predictable serialization, and a recoverable save boundary.

## Why it works

An MCP server can query hierarchy and component state, propose a change, then apply a bounded operation
such as creating a GameObject, assigning a prefab, or setting a serialized property. Unity's editor
scene APIs provide explicit save operations, while MCP's tool schema gives the host a place to show
the requested mutation and obtain approval.

## The catch

Scene edits have broad side effects: prefab instances, cross-scene references, unsaved changes, and
asset GUIDs can be damaged by a seemingly local operation. A stale hierarchy path is not a safe target,
and saving blindly can overwrite a user's work. “Create this scene” tools also become dangerous when
they accept arbitrary scripts or unbounded object counts.

## In practice here

Use stable object identifiers plus expected scene revision, separate preview from apply, cap scope, and
report every changed object. Save to a deliberate path or checkpoint, detect modified scenes before
writing, and provide an undo or restore route. Test against a disposable scene before allowing a server
to edit production scenes or prefab assets.
