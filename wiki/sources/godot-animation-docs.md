---
title: "Source: Godot — animation introduction"
type: source
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "raw/godot-animation-introduction.md"
tags: [source, godot, game-development, animation]
---

# Source: Godot — animation introduction

- **Author:** Godot Engine documentation contributors
- **Published:** Godot 4.x stable documentation
- **URL:** https://docs.godotengine.org/en/stable/tutorials/animation/introduction.html
- **Retrieved:** 2026-07-11
- **Raw:** `raw/godot-animation-introduction.md` (provenance only)

## Summary

**AnimationPlayer** stores named animations as tracks of keyframes on any Inspector property
(and can call methods). Interpolates between keys. Libraries group reusable animations.
Do not parent transform nodes under AnimationPlayer (breaks transform inheritance). RESET
animation restores default pose on save. Markers let you play sections of a long clip.

## Compiled into

- [[godot-animation-player]]
