---
title: Poisson disk sampling
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[bridson-poisson-disk]]"
tags: [game-development, procedural-generation]
---

# Poisson disk sampling

Poisson disk sampling places points with a minimum separation, producing an even distribution with
natural variation.

## Why it works

A spatial grid limits neighbour checks, while candidate generation around active samples fills the
domain without the clumping of independent random placement.

## The catch

One radius cannot express all semantics: points may be evenly spaced but still land in bad gameplay
locations. Boundaries and obstacles reduce achievable density.

## In practice

Use the sampler for seeds, then validate against navmesh, visibility, biome, and gameplay constraints;
vary radius by context rather than accepting geometric regularity as design.

