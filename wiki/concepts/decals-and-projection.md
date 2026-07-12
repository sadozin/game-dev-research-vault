---
title: Decals and projection
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[rendering-effects-and-animation]]"
tags: [game-development, rendering, materials]
---

# Decals and projection

Decals project material detail such as bullet marks, dirt, signs, or blood onto existing geometry.

## Why it works

Localized detail can be added without modifying source meshes or duplicating texture layouts, making
dynamic world response cheap to author.

## The catch

Projected surfaces can overlap, leak through thin geometry, sort badly with transparency, or multiply
draw calls and overdraw. Persistent decals can also become an unbounded allocation problem.

## In practice

Cull and pool decals, constrain projection volumes, limit layers and lifetime, and profile overdraw in
the densest combat or environment scenes.

