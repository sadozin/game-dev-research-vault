---
title: "Source: Glenn Fiedler — Deterministic Lockstep"
type: source
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "https://gafferongames.com/post/deterministic_lockstep/"
tags: [source, game-development, multiplayer, networking, netcode]
---

# Source: Glenn Fiedler — Deterministic Lockstep

- **Author:** Glenn Fiedler
- **Published:** 2014-11-29
- **URL:** https://gafferongames.com/post/deterministic_lockstep/
- **Retrieved:** 2026-07-11

## Summary

Fiedler describes networking a simulation by sending the *inputs* that drive it rather than the state
it produces. Each peer runs the same simulation over the same input stream and arrives at the same
world. The payoff is that bandwidth scales with the size of an input struct, not with the number of
objects: he points out that a million-object simulation costs the same to network as a single object,
because the objects are never transmitted at all.

The price is exactness. Every machine must produce bit-identical results, which puts floating-point
behaviour, compiler and platform differences, and any use of randomness directly on the critical
path. A divergence does not stay small — once two peers disagree, they keep simulating from different
states and drift apart permanently, so lockstep needs desync detection rather than tolerance. The
protocol is also structurally blocking: a peer cannot advance frame *n* without input *n*, so a
missing packet stalls the simulation until it arrives. Fiedler buffers incoming inputs in a playout
delay buffer to smooth jitter, which trades latency for steadiness, and demonstrates that running
lockstep over TCP under packet loss produces frequent hitches — which is why the model suits
cooperative and RTS-style games far better than twitch action over the public internet.

## Compiled into

- [[deterministic-lockstep]] — inputs over state, the bit-exactness requirement, desync, and the
  blocking playout buffer
