---
title: 'Source: Fix Your Timestep!'
type: source
status: active
created: 2026-07-14
updated: 2026-07-14
verified: 2026-07-14
sources:
  - raw/fix-your-timestep.md
tags: [source, game, engineering, simulation, determinism]
---

# Source: Fix Your Timestep!

- **Author:** Glenn Fiedler
- **Published:** 2004-06-10
- **URL:** https://gafferongames.com/post/fix_your_timestep/
- **Retrieved:** 2026-07-14
- **Raw:** raw/fix-your-timestep.md (provenance only)

## Summary

Fiedler shows why feeding arbitrary frame time directly into simulation makes behavior depend on
render performance and can destabilize numerical integration. A fixed or bounded simulation step,
with rendering interpolated separately, creates a firmer contract. The simulation must also retain
headroom: if each step costs longer than the time it represents, catch-up creates a spiral of death.

A fixed step improves repeatability but is not sufficient for bit-identical cross-machine results;
random streams, iteration order, floating-point behavior, and callbacks remain sources of divergence.

## Compiled into

- [[tower-defense-simulation-architecture]]
- [[tower-defense-targeting-and-balance]]
- [[tower-defense-common-pitfalls]]
