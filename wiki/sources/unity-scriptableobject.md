---
title: 'Source: Unity Manual — ScriptableObject'
type: source
status: active
created: 2026-07-14
updated: 2026-07-14
verified: 2026-07-14
sources:
  - raw/unity-scriptableobject.md
tags: [source, game, engine, unity, data-driven-design]
---

# Source: Unity Manual — ScriptableObject

- **Author:** Unity Technologies
- **Version:** Unity 6.1
- **URL:** https://docs.unity3d.com/6000.1/Documentation/Manual/class-ScriptableObject.html
- **Retrieved:** 2026-07-14
- **Raw:** raw/unity-scriptableobject.md (provenance only)

## What the source says

Unity defines ScriptableObject as an asset-backed data container independent of scene instances.
Shared definitions can be referenced rather than copied into every prefab, and editor-created assets
persist between sessions. A deployed build reads prepared assets but does not use ScriptableObjects
as a general save-game mechanism. ScriptableObjects are not immutable, and editor-time writes can
persist to the asset; read-only use is an application convention.

## Derived tower-defense implication

For tower defense, tower, enemy, attack, status, upgrade, wave, and difficulty definitions belong in
asset data treated as read-only while live health, cooldown, target, and progress belong in runtime
state. This separation makes bulk tuning, validation, testing, and content review feasible.

## Compiled into

- [[tower-defense-simulation-architecture]]
- [[tower-defense-content-production]]
