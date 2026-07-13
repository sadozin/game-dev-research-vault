---
title: Procedural animation
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[gameplay-motion-and-architecture]]"
tags: [game-development, animation]
---

# Procedural animation

Procedural animation derives motion at runtime from goals, springs, constraints, noise, or simulation
instead of selecting only authored clips.

## Why it works

Procedural layers adapt to terrain, aim, impacts, and variable timing while preserving authored motion
as a base.

## The catch

Unbounded feedback and frame-rate dependence create jitter, drift, or non-repeatable poses. A procedural
system can also fight the animation graph it modifies.

## In practice

Use stable time steps, filtered targets, bounded weights, and explicit layer ownership; log inputs when
debugging a pose that cannot be replayed.

