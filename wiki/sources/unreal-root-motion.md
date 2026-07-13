---
title: "Source: Epic — Root Motion"
type: source
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "https://dev.epicgames.com/documentation/en-us/unreal-engine/root-motion-in-unreal-engine"
tags: [source, unreal, game-development, animation]
---

# Source: Epic — Root Motion

- **Author:** Epic Games
- **Published:** Unreal Engine 5 documentation
- **URL:** https://dev.epicgames.com/documentation/en-us/unreal-engine/root-motion-in-unreal-engine
- **Retrieved:** 2026-07-11

## Summary

Root motion in Unreal is opt-in twice over. Each animation sequence or montage must have **Enable Root
Motion** ticked in its own asset details, and the Animation Blueprint must then select a **Root Motion
Mode** in its class defaults — the significant options being "Root Motion from Montages Only" and
"Root Motion from everything".

Epic frames it as an alternative to the normal arrangement, where the Movement Component drives the
character and animation is layered on top. Driving movement from root motion instead lets animations
loop recursively, each cycle starting from where the previous one ended. The two systems still
interleave rather than replace one another: the character's physics state decides how much root
motion is honoured — while walking or falling, gravity owns the Z axis and root motion supplies X and
Y, whereas in a flying state the full root motion applies with no gravity.

The documented cost is a threading one, and it is easy to miss: enabling root motion — whether "from
everything" or "from montages" — moves the Animation Graph update onto the **game thread** instead of
a worker thread. More work on the game thread can cause performance problems, which makes root motion
a decision with a frame-time price, not only an animation-quality one.

## Compiled into

- [[root-motion-vs-inplace]] — Unreal's opt-in modes, the movement-component interaction, and the
  game-thread cost
