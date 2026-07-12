---
title: Continuous collision detection
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[unity-continuous-collision-detection]]"
tags: [game-development, physics, simulation, optimization]
---

# Continuous collision detection

Discrete collision detection only asks "is anything overlapping?" at the end of each physics step, so
a body that moves further than its own thickness in one step can be on one side of a wall at tick *n*
and the far side at tick *n+1* without ever having overlapped it. That is tunnelling, and it is the
standing cost of a coarse timestep named in both [[fixed-timestep-and-determinism]] and
[[game-collision-design]]. Continuous collision detection closes the gap by reasoning about the path
a body travelled *between* steps rather than only its endpoint.

## Why it works

There are two families, and they fail in opposite ways. **Sweep-based** CCD runs a time-of-impact
solve along the body's trajectory: it finds the first moment the swept shape touches something, moves
the body there, recomputes velocity, and sweeps again with whatever time is left. This is the
accurate answer, and Unity exposes it as two modes that differ only in what they sweep *against* —
Continuous tests only static geometry (colliders with no Rigidbody), while Continuous Dynamic also
tests other bodies that are themselves in a continuous dynamic mode. A fast bullet against a static
wall needs only the former; two fast bodies hitting each other need the latter, and paying for it on
both.

**Speculative** CCD takes a cheaper route: inflate the body's bounding box to cover its linear *and*
angular motion for the coming step, collect every contact that could possibly occur inside that
volume, and let the solver sort them out. Because the work happens only during collision detection —
not during solving and integration — it is generally cheaper than sweeping, and because it accounts
for rotation it catches cases sweeping cannot see at all.

## The catch

Neither mode is a correctness guarantee, and Unity says so directly: CCD is a safety net for
collisions that would otherwise be missed, not a promise that the resulting contact is physically
accurate. Each family has a specific hole. Sweeping is **linear only** — it cannot detect a collision
produced purely by rotation, so a spinning pinball flipper sweeps nothing and passes through the
ball. Speculative CCD derives its contact normal from a closest-point algorithm, so the normal is
less accurate and fast bodies visibly slide and jump off "ghost" contacts that were never really
there; and if the solver injects enough energy to push the body outside the inflated AABB during
integration, the collision is missed regardless. CCD also only applies to box, sphere, and capsule
colliders, so the mesh collider you were most worried about may not be covered.

The cost is real: sweep-based modes are the most computationally demanding option and degrade sharply
when many fast bodies are in play, because each impact forces another sweep and another sub-step.
Turning CCD on globally is therefore a common and expensive mistake — it converts a modelling problem
into a permanent per-frame tax, and it can hide the fact that the timestep is simply too coarse for
the speeds involved.

## In practice

Treat CCD as a targeted exception, not a default. Enable it on the handful of bodies that are
genuinely fast relative to their size — projectiles, thrown objects, a ball — and leave everything
else discrete. Choose the mode by the failure you actually have: sweeping (Continuous) for a fast
body against static level geometry, Continuous Dynamic only when two fast bodies must collide with
each other, and speculative when the missed collision comes from rotation, which sweeping structurally
cannot catch.

Before reaching for CCD at all, check the cheaper fixes: a thicker collider, a shorter fixed timestep
(the same accuracy-versus-CPU trade [[fixed-timestep-and-determinism]] describes, and often the
better buy when *many* bodies are fast), or a raycast-based projectile that never becomes a rigid
body in the first place — the standard answer for bullets, and the one that costs nothing per frame.
When you do enable it, profile it: a scene that was comfortably inside budget with discrete detection
can fall out of it once a dozen bodies start sweeping, and that shows up in
[[game-performance-profiling]] as physics-step time, not as a rendering cost.
