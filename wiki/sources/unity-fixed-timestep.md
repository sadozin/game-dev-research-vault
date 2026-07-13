---
title: "Source: Unity Manual — Fixed timestep and handling variation in time"
type: source
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "https://docs.unity3d.com/6000.0/Documentation/Manual/physics-optimization-cpu-frequency.html"
  - "https://docs.unity3d.com/6000.0/Documentation/Manual/time-handling-variations.html"
tags: [source, unity, game-development, physics, simulation]
---

# Source: Unity Manual — Fixed timestep and handling variation in time

- **Author:** Unity Technologies (Unity 6 manual)
- **Published:** undated manual pages, Unity 6000.0 documentation set
- **URL:** https://docs.unity3d.com/6000.0/Documentation/Manual/physics-optimization-cpu-frequency.html
  and https://docs.unity3d.com/6000.0/Documentation/Manual/time-handling-variations.html
- **Retrieved:** 2026-07-11

## Summary

Unity ships the accumulator pattern as an engine default. The Fixed Timestep setting defaults to
0.02 seconds — 50 physics steps per second — and it, not the frame rate, governs when the physics
simulation advances and when `FixedUpdate` runs. Lowering the value makes the simulation more
accurate and more stable at the cost of more CPU per second of game time; raising it saves CPU but
invites tunnelling and jitter, which is Unity's own framing of the accuracy-versus-cost trade.
Because frames and fixed steps run at different rates, a slow frame can span several fixed steps,
and Unity executes the resulting backlog on the following frame to catch up.

The catch-up is bounded. `Time.maximumDeltaTime` — Maximum Allowed Timestep in the Time Manager —
defaults to one third of a second, and it caps both the value reported by `Time.deltaTime` and the
amount added to `Time.time`. The number of `FixedUpdate` calls Unity will run in one frame is
therefore bounded to `maximumDeltaTime / fixedDeltaTime`. Unity documents the consequence plainly:
when a frame exceeds the maximum, the physics engine does not attempt to simulate the extra time, so
game time falls behind real time and physics objects move slightly slowly rather than instantly
snapping forward. `Time.unscaledTime` keeps tracking real elapsed time, so the two clocks diverge by
exactly the amount that was discarded.

## Compiled into

- [[fixed-timestep-and-determinism]] — engine defaults, the bounded catch-up, and why the clamp
  trades real-time fidelity for stability
