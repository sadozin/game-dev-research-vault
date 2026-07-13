---
title: Snapshot interpolation
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[gaffer-snapshot-interpolation]]"
  - "[[valve-source-multiplayer-networking]]"
tags: [game-development, multiplayer, networking, netcode, interpolation]
---

# Snapshot interpolation

Snapshot interpolation renders remote entities from a short buffer of authoritative states instead
of displaying each packet as it arrives. The client deliberately renders in the recent past so two
known snapshots usually bracket the render time, producing smooth motion despite packet jitter and
occasional loss.

## Why it works

The receiver orders snapshots by server tick or timestamp, waits for a configured interpolation
delay, and blends position, orientation, and other visual fields between adjacent samples. A missing
snapshot can be skipped if the buffer still contains a later sample. The delay should be chosen from
send rate, measured jitter, and acceptable loss tolerance; higher update rates can reduce the same
loss-protection delay at higher bandwidth cost. This is for remote presentation, while local input
uses [[client-prediction-and-reconciliation]].

## The catch

Interpolation trades responsiveness for continuity. A buffer that is too short hitches whenever
packets arrive late; one that is too long makes remote entities visibly behind. Extrapolation can
cover a buffer underrun, but fast turns, collisions, and nonlinear motion quickly make it wrong. Do
not smooth authoritative simulation state itself into an invented baseline; keep visual correction
separate from [[state-synchronization-strategies]] and measure packet loss, jitter, buffer underruns,
and visual error.

## In practice

Use interpolation for other players, mobs, and moving world objects whose state arrives in snapshots.
Keep local movement responsive through prediction and reconcile against the server. Start with a
small bounded buffer, expose server tick and render delay in diagnostics, and test on loss/jitter
profiles rather than a clean localhost connection. Durable actions remain command-confirmed; an
interpolation buffer must never decide inventory, rewards, block edits, or combat outcomes.
