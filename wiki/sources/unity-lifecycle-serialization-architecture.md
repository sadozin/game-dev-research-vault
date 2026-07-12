---
title: "Source: Unity lifecycle, serialization, and assembly documentation"
type: source
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "https://docs.unity3d.com/Manual/ExecutionOrder.html"
  - "https://docs.unity3d.com/Manual/script-Serialization.html"
  - "https://docs.unity3d.com/Manual/ScriptCompilationAssemblyDefinitionFiles.html"
tags: [source, game-development, unity]
---

# Source: Unity lifecycle, serialization, and assembly documentation

- **Author:** Unity Technologies
- **Published:** continuously maintained documentation
- **URL:** https://docs.unity3d.com/Manual/ExecutionOrder.html
- **Retrieved:** 2026-07-11

## Summary

Unity documents event-function order, serializer constraints, and assembly-definition boundaries as
separate parts of the project model. Lifecycle callbacks are ordered but can be affected by object
activation and scene loading; serialization is field- and type-specific rather than a general object
graph database; assembly definitions shorten recompilation but make references explicit.

## Compiled into

- [[unity-execution-order]]
- [[unity-coroutines-and-async]]
- [[unity-serialization-rules]]
- [[unity-assembly-definitions]]

