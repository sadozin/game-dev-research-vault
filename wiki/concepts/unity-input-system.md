---
title: Unity Input System
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[unity-input-system-manual]]"
  - "[[unity-input-actions-and-bindings]]"
tags: [game-development, unity, input, accessibility]
---

# Unity Input System

Unity's Input System package represents player intent as named actions such as `Jump` or `Fire`, then
maps those actions to device controls through bindings, interactions, processors, and control schemes.
It is a more extensible replacement for the legacy `UnityEngine.Input` path, especially when a game
needs keyboard, gamepad, touch, rebinding, or multiple device layouts.

## Why it works

An action map separates gameplay, UI, and vehicle contexts; several bindings can feed one action; and
control schemes select which devices are relevant. The game code consumes performed, started, or
canceled action callbacks rather than hardcoding a key. Binding overrides can be saved for a player's
layout while the authored defaults remain intact, making localization and accessibility features part
of the input data model.

## The catch

The abstraction adds asset lifecycle, binding-resolution, device-discovery, and update-mode decisions.
Actions do nothing until enabled, and changing bindings while enabled can trigger resolution work.
Mixing legacy polling and package actions can create duplicate input or different timing semantics;
blindly porting `GetAxis` code also loses the distinction between value, button, and event behavior.
Device-specific prompts and rebinding UI still need testing across layouts and hot-plug cases.

## In practice here

Define actions around intent, keep maps scoped to the active mode, and enable a whole map when possible.
Use control schemes and binding groups for device-specific behavior, save overrides by stable binding
ID, and test keyboard, gamepad, touch, rebinding, focus loss, and reconnect. Migrate one subsystem at a
time behind a clear ownership boundary; measure input latency and avoid resolving or allocating on the
per-frame path.
