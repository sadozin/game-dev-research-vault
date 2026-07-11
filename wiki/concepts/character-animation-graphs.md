---
title: Character animation graphs
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[unreal-animation-blueprints]]"
tags: [game-development, 3d, animation, characters, unreal]
---

# Character animation graphs

A character animation graph converts gameplay state into a final skeletal pose each frame. It keeps animation selection, blending, bone controls, and pose composition in a dedicated content-layer system instead of scattering those decisions through the mesh or gameplay code.

## Why it works

The graph consumes compact, intentional inputs such as movement mode, speed, facing, aim, and action state, then blends the appropriate authored poses. This gives animators a place to tune transitions and pose logic while gameplay code remains responsible for authoritative state. Unreal's Animation Blueprints are one implementation: an AnimGraph can blend animation, control skeleton bones, and define the final pose at runtime.

## The catch

An animation graph does nothing until the character uses it; in Unreal the skeletal mesh must be configured to use the Animation Blueprint and its animation class. The more important cross-engine failure mode is an unclear boundary: if gameplay and graph both attempt to own movement or action state, transitions become timing-dependent and hard to debug.

## In practice here

[[minecwaft]]'s documented player movement is first-person and block-based; no skeletal-character pipeline is yet verified. If animated entities are added, define the game-state inputs and their network authority first, then let the client graph turn replicated state into presentation. Do not make pose selection the authority for gameplay events.
