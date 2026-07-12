---
title: Unreal UMG UI
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[unreal-world-ui-data-online]]"
tags: [game-development, unreal, ui]
---

# Unreal UMG UI

UMG is Unreal’s widget authoring and runtime UI framework for menus, HUDs, and interactive screens.

## Why it works

Widget trees, bindings, animations, and input handling let designers build presentation while gameplay
systems expose data and commands.

## The catch

Per-frame bindings, large widget trees, invalid references, and hidden input focus can make UI costly or
unreliable. UI should not become the owner of authoritative game state.

## In practice

Push updates on meaningful state changes, manage widget lifetime explicitly, test focus/navigation,
and keep commands validated by the gameplay layer.

