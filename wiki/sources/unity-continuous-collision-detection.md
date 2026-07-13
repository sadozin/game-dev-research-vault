---
title: "Source: Unity Manual — Continuous collision detection (speculative and sweep-based)"
type: source
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "https://docs.unity3d.com/6000.0/Documentation/Manual/ContinuousCollisionDetection.html"
  - "https://docs.unity3d.com/6000.0/Documentation/Manual/speculative-ccd.html"
  - "https://docs.unity3d.com/6000.0/Documentation/Manual/sweep-based-ccd.html"
tags: [source, unity, game-development, physics, simulation]
---

# Source: Unity Manual — Continuous collision detection (speculative and sweep-based)

- **Author:** Unity Technologies (Unity 6 manual)
- **Published:** undated manual pages, Unity 6000.0 documentation set
- **URL:** https://docs.unity3d.com/6000.0/Documentation/Manual/ContinuousCollisionDetection.html,
  https://docs.unity3d.com/6000.0/Documentation/Manual/speculative-ccd.html, and
  https://docs.unity3d.com/6000.0/Documentation/Manual/sweep-based-ccd.html
- **Retrieved:** 2026-07-11

## Summary

Unity frames continuous collision detection as a safety net rather than a physics upgrade: CCD modes
use predictive algorithms to catch collisions that happen *between* physics timesteps, are more
accurate than discrete detection, and cost more CPU — and Unity is explicit that catching the
collision does not mean the resulting contact is physically accurate. CCD is supported for box,
sphere, and capsule colliders. The manual offers four modes: Discrete, Continuous, Continuous
Dynamic, and Continuous Speculative.

The two families work differently and fail differently. **Sweep-based** CCD (Continuous and
Continuous Dynamic) runs a time-of-impact algorithm along the body's trajectory, moves the body to
the impact point, recomputes velocity, and sweeps again. Continuous sweeps only against static
colliders — GameObjects with no Rigidbody — while Continuous Dynamic also sweeps against other bodies
set to a continuous dynamic mode. These are the most accurate modes and the most computationally
demanding, and they degrade badly when many fast bodies interact at once. Their structural
limitation is that the sweep is linear only: it cannot detect a collision caused purely by rotation,
so a spinning pinball flipper will not sweep into the ball.

**Speculative** CCD instead inflates the body's AABB according to its linear *and* angular motion,
gathers every potential contact inside that inflated volume, and hands them to the solver. It is
generally cheaper than sweeping because it only does work during the collision-detection phase, not
during solving and integration, and because it accounts for angular motion it catches the rotational
cases sweeping misses. It has two documented failure modes: the contact normal comes from a
closest-point algorithm and is therefore less accurate, which makes fast bodies slide and jump on
phantom "ghost" contacts; and if the solver adds enough energy that the body ends up outside the
inflated AABB after integration, the collision is missed anyway.

## Compiled into

- [[continuous-collision-detection]] — tunnelling, the sweep-versus-speculative trade, and why CCD is
  a safety net rather than a substitute for a sane timestep
