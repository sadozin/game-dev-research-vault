---
title: State synchronization strategies
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[valve-source-multiplayer-networking]]"
  - "[[gaffer-state-synchronization]]"
tags: [game-development, multiplayer, networking, netcode, snapshots]
---

# State synchronization strategies

State synchronization is the choice of what the server sends, how the client applies it, and which
messages may be lost without blocking progress. The useful families are not mutually exclusive:
authoritative snapshots, delta snapshots, input or event replication, and approximate state updates
for independently moving objects each solve a different consistency problem.

## Why it works

Authoritative snapshots give the client a canonical state to render or reconcile. Delta snapshots
send only fields changed since a baseline acknowledged by the receiver, reducing bandwidth while
requiring baseline tracking and a full-snapshot recovery path after loss. Input replication lets a
deterministic client predict local movement, while the server remains authoritative as described in
[[client-prediction-and-reconciliation]]. Approximate state synchronization can send a priority
subset of objects and let the receiver extrapolate between updates; a jitter buffer prevents packet
arrival clumps from becoming simulation jitter.

## The catch

There is no universally best packet type. Snapshots cost bandwidth but converge cleanly; deltas save
bandwidth but fail if their baseline is missing; input/event streams are compact but depend on
ordering, replayability, and compatible simulation rules; approximate state updates tolerate
non-deterministic simulation but visibly pop when extrapolation diverges. Mixing these channels
without separate sequence, acknowledgement, and reliability semantics makes packet loss bugs look
like gameplay bugs. Keep simulation correction separate from visual smoothing, and measure bandwidth,
loss recovery, correction size, jitter, and CPU cost with [[game-performance-profiling]].

## In practice

For a persistent multiplayer world, use a hybrid protocol: reliable ordered commands for durable
actions such as inventory, block edits, and rewards; sequenced snapshots or deltas for ephemeral
movement and entity presentation; and a full-state fallback when a delta baseline is unavailable.
Prioritize nearby or gameplay-relevant entities rather than broadcasting every object equally. Put
sequence numbers and server tick/time in every channel, buffer remote snapshots for interpolation,
and test under loss, duplication, reordering, jitter, and reconnects before tuning packet rates.
This design keeps [[client-prediction-and-reconciliation]] responsive without allowing a client to
declare durable world truth.
