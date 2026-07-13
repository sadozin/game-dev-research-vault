---
title: "Source: Glenn Fiedler networked physics articles"
type: source
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "https://gafferongames.com/post/snapshot_interpolation/"
  - "https://gafferongames.com/post/networked_physics_2004/"
tags: [source, game-development, networking]
---

# Source: Glenn Fiedler networked physics articles

- **Author:** Glenn Fiedler
- **Published:** 2004-2014
- **URL:** https://gafferongames.com/post/snapshot_interpolation/
- **Retrieved:** 2026-07-11

## Summary

The articles separate authoritative simulation from presentation. A client can buffer snapshots and
interpolate between them to hide jitter; extrapolation predicts beyond known state but becomes
fragile around collisions, corrections, and nonlinear motion. The useful design is bounded visual
error with an explicit correction policy, not a promise that every packet arrives on time.

## Compiled into

- [[entity-interpolation-extrapolation]]

