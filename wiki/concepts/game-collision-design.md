---
title: Game collision design
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[unreal-collision-overview]]"
tags: [game-development, 3d, collision, physics]
---

# Game collision design

Collision is an interaction policy, not merely a mesh property. Separate physical blocking, trigger overlap, and gameplay queries into explicit layers or channels, each with defined responses to other layers.

## Why it works

Blocking prevents movement or resolves physics. Overlap detects an entering or leaving relationship without creating a physical barrier. Traces answer targeted gameplay questions such as line of sight, hitscan selection, or ground detection. Unreal expresses this with object and trace response types whose pairwise results are block, overlap, or ignore; the same separation is useful in any 3D engine.

## The catch

Events are additional work and configuration, not an automatic consequence of touching geometry. Hit and overlap notifications require their relevant event settings, and continuous contact can generate noisy hit reports. An object that needs both physics collision and overlap events demands deliberate filtering. Use simple proxy geometry for broad-phase and movement whenever detailed render geometry is not required for the gameplay decision.

## In practice here

[[minecwaft]] already documents gravity and block collision. Preserve that world-solid behavior as a distinct layer from future item pickups, interactable volumes, entity attacks, and camera or weapon traces. Make server authority explicit for gameplay-affecting hits; visual client-side traces can predict feedback but must not decide the durable result.
