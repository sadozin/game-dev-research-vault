---
title: "Source: Glenn Fiedler — State Synchronization"
type: source
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "https://gafferongames.com/post/state_synchronization/"
tags: [source, game-development, multiplayer, networking, netcode]
---

# Source: Glenn Fiedler — State Synchronization

- **Author:** Glenn Fiedler
- **Published:** 2015-01-05
- **URL:** https://gafferongames.com/post/state_synchronization/
- **Retrieved:** 2026-07-11

## Summary

State synchronization sends both simulation state and enough motion data for each receiver to
continue an approximate local simulation. It can update only a priority-selected subset of objects
per packet, saving bandwidth, but it is intentionally lossy: extrapolation can diverge and later
corrections can pop. A jitter buffer reorders clumped packets before application. Fiedler also
describes delta compression as a further bandwidth win, with added complexity, and recommends
separating simulation correction from visual smoothing so smoothing does not turn an invalid state
into the next simulation baseline.

## Compiled into

- [[state-synchronization-strategies]] — choose between snapshots, deltas, and approximate state updates
