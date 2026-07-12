---
title: Unreal Blueprint communication
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[unreal-communication-animation]]"
tags: [game-development, unreal, architecture]
---

# Unreal Blueprint communication

Blueprint communication connects Actors through direct references, casts, interfaces, delegates, or
event dispatchers.

## Why it works

The mechanisms cover one-to-one calls, common contracts, and one-to-many notifications without forcing
every Actor into the same class hierarchy.

## The catch

Direct references and casts create coupling and can fail when objects are spawned, unloaded, or changed.
Event dispatchers also need lifetime and unbinding rules.

## In practice

Use interfaces for stable capabilities, delegates for notifications, and direct references only when
ownership is explicit and testable.

