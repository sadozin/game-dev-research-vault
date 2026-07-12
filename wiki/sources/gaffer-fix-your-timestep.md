---
title: "Source: Glenn Fiedler — Fix Your Timestep!"
type: source
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "https://www.gafferongames.com/post/fix_your_timestep/"
tags: [source, game-development, physics, simulation, frame-pacing]
---

# Source: Glenn Fiedler — Fix Your Timestep!

- **Author:** Glenn Fiedler
- **Published:** 2004-06-10
- **URL:** https://www.gafferongames.com/post/fix_your_timestep/
- **Retrieved:** 2026-07-11

## Summary

Fiedler argues that integrating physics with whatever delta time the last frame happened to take
makes the simulation a function of frame rate: the same scene run at a different frame rate settles
differently, and a bad frame can produce instability, tunnelling, or an outright explosion. His fix
is to stop letting the renderer dictate the simulation step. The frame loop measures elapsed real
time and adds it to an accumulator; the simulation then consumes that accumulator in fixed `dt`
increments, so every integration step is identical regardless of how long the frame took. The
renderer produces time and the simulation consumes it in discrete steps.

Two consequences follow. First, if the simulation cannot step faster than real time, each frame
falls further behind and demands still more steps next frame — the "spiral of death" — so the
frame time fed into the accumulator must be clamped to a maximum before it is accumulated.
Second, the accumulator almost never empties exactly, leaving a remainder of unsimulated time; if
the renderer draws the last simulated state directly, that varying remainder shows up as stutter.
Fiedler resolves this by keeping the previous and current physics states and rendering a blend of
them with `alpha = accumulator / dt`, which decouples a smooth, variable-rate display from a fixed,
repeatable simulation.

## Compiled into

- [[fixed-timestep-and-determinism]] — the accumulator loop, the frame-time clamp, and state
  interpolation for rendering
