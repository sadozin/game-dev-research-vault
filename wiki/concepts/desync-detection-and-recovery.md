---
title: Desync detection and recovery
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[netcode-desync-and-relevancy]]"
tags: [game-development, networking, multiplayer]
---

# Desync detection and recovery

Desync handling detects when replicas no longer agree and restores a valid shared state or session.

## Why it works

Deterministic state hashes, sequence numbers, and divergence logs make an invisible simulation failure
observable. Recovery can request an authoritative snapshot, rewind to a checkpoint, or remove a bad
client from a lockstep session.

## The catch

Hash equality proves only that the chosen projection matches; it does not explain why. Full-state
resync is bandwidth-heavy, while continuing after a mismatch can turn one bad decision into many.

## In practice

Hash stable gameplay state at checkpoints, log the first divergent tick, and make recovery bounded
and explicit rather than silently correcting everything.

