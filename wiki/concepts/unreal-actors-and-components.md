---
title: Unreal actors and components
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[unreal-actors-input-and-save]]"
tags: [game-development, unreal, architecture]
---

# Unreal actors and components

An Unreal Actor is a world object; Components package behavior, transforms, rendering, collision, or
other capabilities attached to an Actor.

## Why it works

Composition lets a vehicle, character, or interactive prop share capabilities without inheriting one
large class. Scene components provide transform hierarchy while actor components can remain abstract.

## The catch

Component ownership and registration determine lifecycle, ticking, replication, and physics state.
Composition can become a hidden dependency graph if every component reaches into every other component.

## In practice

Define ownership and initialization order, keep interfaces narrow, and disable ticking or physics for
components that do not need it.

