---
title: Unity serialization rules
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[unity-lifecycle-serialization-architecture]]"
tags: [game-development, unity, architecture]
---

# Unity serialization rules

Unity serialization is the editor and asset persistence system for supported fields and object
references, not a universal runtime serializer.

## Why it works

Serialized fields expose stable authoring data to scenes, prefabs, and inspectors while references let
assets share definitions without copying them into every instance.

## The catch

Properties, dictionaries, polymorphic graphs, constructors, and runtime-only state do not behave like
a general-purpose object serializer. Renames and reference changes can silently alter saved data.

## In practice

Separate authoring data from runtime state, version migrations, and test prefab/scene round trips in
source control.

