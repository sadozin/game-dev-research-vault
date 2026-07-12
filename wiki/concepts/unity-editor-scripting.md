---
title: Unity editor scripting
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[unity-editor-and-rendering-systems]]"
tags: [game-development, unity, tools]
---

# Unity editor scripting

Unity editor scripting creates custom inspectors, windows, menus, and asset processors for authoring
and validation workflows.

## Why it works

Tools encode repeated project knowledge next to the assets they operate on, reducing manual setup and
making errors visible before runtime.

## The catch

Editor code runs in a different lifecycle and assembly context from player code. Asset import hooks
and serialized mutations can cause slow imports, dirty scenes, or non-reproducible changes.

## In practice

Keep editor assemblies separate, make operations idempotent, show a preview or diff, and never assume
an editor-only reference exists in a player build.

