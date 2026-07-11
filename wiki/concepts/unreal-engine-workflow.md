---
title: Unreal engine workflow
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[unreal-blueprint-cpp]]"
  - "[[unreal-animation-blueprints]]"
  - "[[unreal-collision-overview]]"
tags: [unreal, game-engine, cplusplus, blueprints]
---

# Unreal engine workflow

Unreal combines C++ systems with Blueprint visual scripting. C++ defines engine-facing gameplay
classes, performance-sensitive systems, and integrations; Blueprints extend those classes with
designer- and content-friendly behavior.

## Why it works

The split lets programmers expose stable parameters and events while artists and designers iterate
inside the editor. Keep high-frequency, data-heavy, or complex algorithms in C++; use Blueprints
for event-driven content and rapid behavior changes. This is an architectural boundary, not a
religious choice: profile first, then move only the proven hot or unmaintainable portion.

[[character-animation-graphs]] are a good example of the split: authoritative game state can
come from C++, while an Animation Blueprint turns that state into a skeletal pose. Apply the same
intentionality to [[game-collision-design]] channels rather than leaving interaction rules buried
in individual assets.

## The catch

A Blueprint-only prototype can become difficult to diff, merge, test, and scale when graphs grow
large. A C++-only project can slow content iteration. Design the C++ API deliberately for
Blueprint exposure, and keep the source of truth for core systems in readable C++.

## In practice here

Unreal is a future-engine option, not an installed or verified project on this machine. It offers
an official [[unreal-mcp-integration]] path, but that feature is experimental and should not
choose the engine by itself.
