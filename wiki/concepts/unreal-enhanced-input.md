---
title: Unreal Enhanced Input
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[unreal-actors-input-and-save]]"
tags: [game-development, unreal, input]
---

# Unreal Enhanced Input

Enhanced Input maps physical controls to named actions through mapping contexts, modifiers, triggers,
and priorities.

## Why it works

Input intent becomes data: the same action can receive keyboard, gamepad, or accessibility bindings,
while contexts can change for gameplay, menus, vehicles, or rebinding.

## The catch

Context priority and trigger state are part of behavior. Accidentally retaining a context or consuming
an input can create controls that work only in one mode.

## In practice

Add and remove contexts at explicit ownership boundaries, test simultaneous contexts, and keep gameplay
code dependent on actions rather than device keys.

