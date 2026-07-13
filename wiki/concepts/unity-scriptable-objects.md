---
title: Unity ScriptableObjects
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[unity-scriptableobject-manual]]"
  - "[[unity-scriptableobject-api]]"
tags: [game-development, unity, architecture, data]
---

# Unity ScriptableObjects

A ScriptableObject is a Unity asset-backed data container that lives independently of a GameObject.
Multiple prefabs or systems can reference one asset, making it useful for shared definitions such as
items, abilities, tuning tables, and spawn configurations. It is a data-as-asset pattern, not a runtime
save-file system.

## Why it works

Values stored directly on each prefab instance are duplicated; a shared ScriptableObject keeps one
serialized copy and lets consumers reference it. `CreateAssetMenu` makes authored definitions easy to
create and inspect, while custom editors can present domain-specific data. Separating immutable or
authored data from behavior also makes systems easier to test and balance.

## The catch

References are shared, so mutating an asset at runtime can leak state between every consumer and, in
the editor, dirty or persist unexpected changes. ScriptableObjects in a player build provide authored
data but are not a general persistent save mechanism. Serialization, asset references, domain reload,
and large YAML arrays add their own constraints; a missing script or moved asset can make data
unloadable.

## In practice here

Keep ScriptableObjects immutable during play and copy only the small mutable runtime state into a
separate instance. Use them for definitions and configuration, give assets stable identifiers, validate
references in editor checks, and choose binary serialization for very large data where Unity recommends
it. Pair the pattern with [[save-data-versioning-and-migration]] rather than writing player progress
back into design assets.
