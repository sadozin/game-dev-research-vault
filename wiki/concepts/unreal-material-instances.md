---
title: Unreal material instances
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[unreal-material-instances]]"
tags: [game-development, unreal, rendering]
---

# Unreal material instances

Material instances inherit a parent material and override exposed parameters without duplicating the
parent graph.

## Why it works

One compiled shader structure can serve many colors, textures, and scalar variants. Artists get
non-destructive variation while runtime systems can change dynamic parameters.

## The catch

Every variation is not free: static switches can create shader permutations, dynamic parameters can
increase runtime work, and a complex parent becomes a shared bottleneck.

## In practice

Expose only meaningful parameters, keep static permutations bounded, and profile shader compilation,
switching, and material memory on the target platform.

