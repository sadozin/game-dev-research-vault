---
title: "Source: Unity — ScriptableObject"
type: source
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "https://docs.unity3d.com/6000.1/Documentation/Manual/class-ScriptableObject.html"
tags: [source, game-development, unity, architecture, data]
---

# Source: Unity — ScriptableObject

- **Author:** Unity Technologies
- **Published:** Unity 6.1 manual
- **URL:** https://docs.unity3d.com/6000.1/Documentation/Manual/class-ScriptableObject.html
- **Retrieved:** 2026-07-11

## Summary

Unity presents ScriptableObjects as data containers independent of class instances and highlights
shared references as a way to avoid copying unchanging data across prefab instances. They are saved as
project assets, can be created with `CreateAssetMenu`, and can be consumed at runtime. Unity explicitly
distinguishes authored asset data from saving player data in a deployed build.

## Compiled into

- [[unity-scriptable-objects]] — shared asset data, authoring, and save-state boundary
