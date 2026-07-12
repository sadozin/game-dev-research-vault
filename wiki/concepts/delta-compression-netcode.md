---
title: Delta compression netcode
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[gaffer-snapshot-compression]]"
  - "[[valve-source-multiplayer-networking]]"
tags: [game-development, multiplayer, networking, netcode, compression]
---

# Delta compression netcode

Delta compression sends a state update relative to a receiver-known baseline instead of repeating
the entire state. It is a bandwidth strategy, not a consistency model: acknowledgements, sequence
numbers, full-state recovery, and field-specific precision determine whether the delta is usable.

## Why it works

The sender tracks the newest snapshot baseline acknowledged by each receiver and encodes only
changed fields or entities. Unchanged flags, changed-index lists, relative values, quantized ranges,
and omitted-at-rest values can reduce bandwidth substantially. The receiver applies the delta to
the matching baseline; after startup or prolonged loss, a full snapshot re-establishes a baseline.
[[reliable-udp-and-ordering]] supplies the packet acknowledgements and loss semantics that make this
possible, while [[state-synchronization-strategies]] determines which state should be sent at all.

## The catch

Every client may have a different acknowledged baseline, so the server cannot treat one global delta
as sufficient. A lost or mismatched baseline makes the payload undecodable; silently applying it can
corrupt the world view. Quantization saves bits at the cost of precision and can create visible or
simulation divergence. Compression also spends CPU and implementation complexity, and a clever
encoding tuned to one scene may lose on another. Measure bytes per client, encode/decode time,
full-snapshot frequency, loss recovery, and correction artifacts before adopting it.

## In practice

Use deltas first for high-volume, mostly stable state such as nearby entity transforms or chunk
metadata, with per-client baseline IDs and a bounded full-snapshot fallback. Keep durable commands
and server-confirmed outcomes on the reliable command channel rather than hiding them inside a
lossy delta stream. Establish field ranges and quantization error budgets from gameplay needs, then
test baseline loss, reconnect, version mismatch, and a sudden burst of changed entities under
[[game-performance-profiling]].
