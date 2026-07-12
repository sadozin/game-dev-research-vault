---
title: Client prediction and reconciliation
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[valve-source-multiplayer-networking]]"
  - "[[gaffer-client-prediction]]"
tags: [game-development, multiplayer, networking, netcode, server-authority]
---

# Client prediction and reconciliation

Client prediction hides round-trip latency for the local player's input; server reconciliation
keeps that responsive client view subordinate to authoritative state. The client predicts only what
it can derive from its own input and known world state. The server validates and simulates the real
result.

## Why it works

The client assigns a monotonically increasing sequence number to each input, stores recent inputs
and predicted states in a ring buffer, and simulates the local character immediately. The server
acknowledges the newest input it has processed alongside an authoritative state. On receipt, the
client discards acknowledged history, resets to the server state, and replays still-unacknowledged
inputs. Matching movement rules keep corrections rare; a correction is expected when an external
collision, rejected action, or missing world information invalidates the prediction.

Other players should normally be rendered from buffered snapshots with [[frame-pacing]]-friendly
interpolation, not predicted from unknowable future input. [[godot-multiplayer]] documents the same
authority distinction in an engine-specific context, but the pattern is engine-agnostic.

## The catch

Prediction creates a second execution path for movement and collision, so the client and server
must share stable rules, tick assumptions, and input semantics. Floating-point drift, different
collision data, packet loss, or unacknowledged external events produce corrections. Snapping every
error is visible; smoothing every error hides real divergence and can leave the player temporarily
behind. Instrument correction count, error magnitude, replay length, packet loss, and input-to-pose
latency instead of judging the system by feel alone. Higher tick or snapshot rates also spend CPU
and bandwidth; [[game-performance-profiling]] should establish the budget.

## In practice

For a dedicated voxel server, begin with a sequence-numbered input stream and an authoritative
movement snapshot that reports the last processed input. Keep the shared movement/collision rules
in a testable core, add a bounded client history, and verify rewind/replay under artificial latency,
jitter, loss, and reordered packets. Keep inventory, crafting, RPG rewards, block edits, and other
durable state server-confirmed even if the client predicts the immediate animation or movement
feedback. This pairs with [[game-collision-design]] and leaves lag-compensated combat as a separate
design decision rather than quietly trusting client hit claims.
