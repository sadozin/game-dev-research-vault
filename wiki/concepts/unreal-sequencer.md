---
title: Unreal Sequencer
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[unreal-build-profiling-and-platforms]]"
tags: [game-development, unreal, cinematics]
---

# Unreal Sequencer

Sequencer is Unreal’s time-based cinematic and animation authoring system for tracks, shots, cameras,
actors, and events.

## Why it works

Complex presentation can be edited as a deterministic timeline while gameplay systems provide bindings
and respond to controlled events.

## The catch

Bindings, playback state, animation overrides, and event side effects can leak across replay, skip, or
network contexts. A cinematic should not silently become the authority for persistent game state.

## In practice

Define entry/exit ownership, test skip and interruption, and make event effects idempotent and reversible.

