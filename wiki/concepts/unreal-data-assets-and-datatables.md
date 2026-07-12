---
title: Unreal Data Assets and DataTables
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[unreal-world-ui-data-online]]"
tags: [game-development, unreal, data-driven-design]
---

# Unreal Data Assets and DataTables

Data Assets and DataTables hold reusable structured design data outside gameplay classes.

## Why it works

Items, abilities, tuning values, and content catalogs can be authored and referenced without duplicating
logic across Blueprints or C++ classes.

## The catch

Schema changes, row names, soft references, and runtime mutation need ownership and migration rules.
Treating editor data as a save-game database creates accidental shared state.

## In practice

Keep definitions immutable at runtime, validate references on load, version schemas, and distinguish
authoring assets from player-owned state.

