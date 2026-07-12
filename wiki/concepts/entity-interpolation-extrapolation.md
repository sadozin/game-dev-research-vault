---
title: Entity interpolation and extrapolation
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[gaffer-networked-physics]]"
tags: [game-development, networking, multiplayer]
---

# Entity interpolation and extrapolation

Interpolation renders a remote entity between known states; extrapolation predicts beyond the newest
state.

## Why it works

Rendering slightly behind the server gives two samples and smooths packet jitter without changing
authoritative state. Prediction reduces perceived latency when waiting for the next update would be
more visible than a later correction.

## The catch

Interpolation adds latency and extrapolation becomes wrong at collisions, stops, and direction
changes. Corrections need bounded error and visually coherent snapping or blending.

## In practice

Buffer snapshots for ordinary motion and use short, clamped prediction only where the gameplay can
tolerate correction.

