---
title: Volumetric fog and lighting
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[rendering-effects-and-animation]]"
tags: [game-development, rendering, atmosphere]
---

# Volumetric fog and lighting

Volumetric rendering models participating light through a volume of fog, haze, smoke, or dust.

## Why it works

Scattering makes light shafts, depth separation, and atmospheric perspective respond to lights and
camera movement instead of being a flat color overlay.

## The catch

Volumes require sampling, temporal accumulation, shadows, and often large buffers. Noise, ghosting,
light leaks, and platform cost rise quickly with resolution and density.

## In practice

Use froxel or lower-resolution budgets, temporal fallbacks, bounded volumes, and quality tiers; keep
gameplay readability above atmospheric density.

