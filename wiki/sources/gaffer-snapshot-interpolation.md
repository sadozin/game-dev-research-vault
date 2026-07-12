---
title: "Source: Glenn Fiedler — Snapshot Interpolation"
type: source
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "https://gafferongames.com/post/snapshot_interpolation/"
tags: [source, game-development, multiplayer, networking, netcode, interpolation]
---

# Source: Glenn Fiedler — Snapshot Interpolation

- **Author:** Glenn Fiedler
- **Published:** 2014-11-30
- **URL:** https://gafferongames.com/post/snapshot_interpolation/
- **Retrieved:** 2026-07-11

## Summary

Rather than render each received snapshot immediately, the client holds snapshots in an interpolation
buffer and renders slightly behind the newest arrival. It can then interpolate between two known
states, masking packet clumps and isolated loss. The buffer adds latency, but too little delay causes
hitches; too much wastes responsiveness. Fiedler treats snapshots as time-sensitive and disposable:
lost packets are skipped, while extrapolation is limited because collisions and nonlinear motion make
long predictions diverge. Higher send rates can reduce the required buffer, but increase bandwidth.

## Compiled into

- [[snapshot-interpolation]] — buffered rendering for remote state under jitter and loss
