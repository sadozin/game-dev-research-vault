---
title: "Source: Unity — engine architecture"
type: source
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "raw/unity-engine-architecture.md"
tags: [source, unity, engine]
---

# Source: Unity — engine architecture

- **Author:** Unity Technologies
- **Published:** Unity 2021.1 Manual
- **URL:** https://docs.unity3d.com/2021.1/Documentation/Manual/unity-architecture.html
- **Retrieved:** 2026-07-11
- **Raw:** `raw/unity-engine-architecture.md` (provenance only)

## Summary

Unity's engine core is native C/C++, while game and editor scripting use a C# wrapper. The
workflow therefore centers on managed scripts, serialization, editor-time compilation, and a
choice between Mono and IL2CPP scripting backends. Domain reload and compilation behavior are
part of development architecture, not incidental editor details.

## Compiled into

- [[unity-engine-workflow]] — C#-centred engine workflow
- [[game-engine-selection]] — compare architecture and team workflow
