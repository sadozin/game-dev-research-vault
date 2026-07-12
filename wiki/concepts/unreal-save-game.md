---
title: Unreal SaveGame
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[unreal-actors-input-and-save]]"
tags: [game-development, unreal, persistence]
---

# Unreal SaveGame

Unreal SaveGame objects define data intended to persist across sessions and can be serialized through
the engine’s save/load APIs.

## Why it works

An explicit save model separates persistent player progress from transient world objects and gives the
game a place to version profile data, settings, and checkpoint state.

## The catch

Serialization does not decide when saving is safe, how schemas migrate, or how cloud conflicts resolve.
Saving mutable object references as if they were stable IDs creates invalid restores.

## In practice

Store stable identifiers and versioned data, write atomically, test interrupted saves, and migrate old
profiles before changing gameplay fields.

