---
title: Fixed timestep and determinism
type: concept
status: active
created: 2026-07-14
updated: 2026-07-14
verified: 2026-07-14
sources:
  - [[fix-your-timestep]]
tags: [game, engineering, simulation, determinism, testing]
---

# Fixed timestep and determinism

A fixed logical timestep advances simulation by the same duration per step while presentation may
render at another rate and interpolate between states. This prevents arbitrary render-frame duration
from directly changing movement, cooldown, and integration behavior. The simulation needs execution
headroom; otherwise catch-up steps cost more time than they represent and create a spiral of death
([[fix-your-timestep]]).

Fixed stepping is one ingredient of reproducibility, not proof of determinism. Stable iteration and
tie-breaking, seeded random streams, explicit event order, controlled floating-point behavior,
complete command/state capture, and deterministic callbacks also matter. Periodic state hashes reveal
the first divergence; golden scenarios isolate ambiguous simultaneous events.

Use strict cross-platform determinism only when replay, lockstep networking, competitive verification,
or exact headless comparison justifies its cost. Same-build repeatability is still valuable for
single-player balance and bug reports even when bit-identical cross-machine results are unnecessary.

## Related

- [[tower-defense-simulation-architecture]]
- [[tower-defense-targeting-and-balance]]
- [[game-performance-profiling]]
