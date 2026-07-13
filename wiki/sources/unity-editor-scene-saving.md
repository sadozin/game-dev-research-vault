---
title: "Source: Unity — EditorSceneManager.SaveScene"
type: source
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "https://docs.unity3d.com/ScriptReference/SceneManagement.EditorSceneManager.SaveScene.html"
tags: [source, game-development, unity, editor, scenes]
---

# Source: Unity — EditorSceneManager.SaveScene

- **Author:** Unity Technologies
- **Published:** Undated (Unity 6.0 Scripting API)
- **URL:** https://docs.unity3d.com/ScriptReference/SceneManagement.EditorSceneManager.SaveScene.html
- **Retrieved:** 2026-07-11

## Summary

Unity's `EditorSceneManager.SaveScene` saves a specified scene and can save a copy without changing
the current scene or clearing its modified marker. Paths are project-relative and the method reports
whether saving succeeded. This makes destination, copy semantics, and return-value checks important
parts of an editor automation tool's contract.

## Compiled into

- [[unity-mcp-scene-authoring]] — explicit save boundaries and checkpoint behavior
