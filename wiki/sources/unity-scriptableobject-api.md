---
title: "Source: Unity — ScriptableObject API"
type: source
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "https://docs.unity3d.com/kr/2022.3/ScriptReference/ScriptableObject.html"
tags: [source, game-development, unity, architecture, data]
---

# Source: Unity — ScriptableObject API

- **Author:** Unity Technologies
- **Published:** Unity 2022.3 API documentation
- **URL:** https://docs.unity3d.com/kr/2022.3/ScriptReference/ScriptableObject.html
- **Retrieved:** 2026-07-11

## Summary

The API reference explains that ScriptableObjects can be created and saved as assets, referenced from
scenes and other assets, and serialized using Unity's normal field rules. It warns that large arrays
may benefit from `PreferBinarySerialization` because YAML is inefficient, and that unsaved referenced
objects can be serialized into a scene. These details matter when deciding asset boundaries and source
control behavior.

## Compiled into

- [[unity-scriptable-objects]] — serialization, asset lifetime, and large-data caveats
