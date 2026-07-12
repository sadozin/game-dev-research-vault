---
title: Cellular automata caves
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[procedural-biomes-caves-meshes]]"
tags: [game-development, procedural-generation, caves]
---

# Cellular automata caves

Cellular automata cave generation repeatedly updates cells from the state of their neighbors to turn
random solid/open seeds into connected cavern-like regions.

## Why it works

Local smoothing rules remove isolated noise and create organic boundaries with little authored data.

## The catch

Rules can create disconnected rooms, sealed pockets, thin walls, or too much empty space. Smoothing
does not guarantee a playable route or a mesh with safe topology.

## In practice

Run connectivity and clearance checks after generation, connect or reject disconnected regions, and
keep a seed plus rule set for reproducible debugging.

