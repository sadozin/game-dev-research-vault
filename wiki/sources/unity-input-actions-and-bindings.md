---
title: "Source: Unity — Input Actions and Bindings"
type: source
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "https://docs.unity3d.com/ja/Packages/com.unity.inputsystem%401.4/manual/Actions.html"
  - "https://docs.unity3d.com/ja/Packages/com.unity.inputsystem%401.4/api/UnityEngine.InputSystem.InputAction.html"
tags: [source, game-development, unity, input, accessibility]
---

# Source: Unity — Input Actions and Bindings

- **Author:** Unity Technologies
- **Published:** Input System package 1.4 documentation
- **URL:** https://docs.unity3d.com/ja/Packages/com.unity.inputsystem%401.4/manual/Actions.html
- **Retrieved:** 2026-07-11

## Summary

Unity defines an Input Action as a named logical input, with bindings connecting it to one or more
control paths. Action Maps group actions, bindings can be filtered by masks and control schemes, and
actions must be enabled before they monitor matching controls and emit callbacks. The API separates
intent from physical devices, while requiring the developer to manage map lifetime and binding
resolution explicitly.

## Compiled into

- [[unity-input-system]] — action abstraction, binding resolution, maps, and lifecycle
