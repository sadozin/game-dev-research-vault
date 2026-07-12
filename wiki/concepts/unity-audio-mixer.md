---
title: Unity Audio Mixer
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[unity-movement-content-and-audio]]"
tags: [game-development, unity, audio]
---

# Unity Audio Mixer

Unity Audio Mixer routes audio through groups, effects, snapshots, and exposed parameters.

## Why it works

Mixing is centralized: gameplay can duck music for dialogue, switch snapshots for pause or combat, and
control buses without editing every AudioSource.

## The catch

Snapshot transitions and group routing are stateful. Multiple systems fighting the same parameter or
using a global volume as a local effect produces abrupt, hard-to-debug audio changes.

## In practice

Assign ownership for exposed parameters, use scoped snapshots, and test device output, pause, focus
loss, and streaming behavior.

