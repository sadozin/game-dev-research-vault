---
title: "Source: Unity movement, content, animation, and audio documentation"
type: source
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "https://docs.unity3d.com/Manual/class-CharacterController.html"
  - "https://docs.unity3d.com/Manual/Tilemap.html"
  - "https://docs.unity3d.com/Manual/com.unity.animation.rigging.html"
  - "https://docs.unity3d.com/Manual/AudioMixer.html"
tags: [source, game-development, unity]
---

# Source: Unity movement, content, animation, and audio documentation

- **Author:** Unity Technologies
- **Published:** continuously maintained documentation
- **URL:** https://docs.unity3d.com/Manual/class-CharacterController.html
- **Retrieved:** 2026-07-11

## Summary

Unity separates collision-constrained CharacterController movement from Rigidbody simulation, represents
2D tile content through Tilemaps, applies runtime rig constraints through Animation Rigging, and routes
audio through mixer groups and snapshots. Each subsystem is useful because it owns a clear problem;
mixing their authority or update timing creates sliding, physics conflicts, or audible state bugs.

## Compiled into

- [[unity-controller-vs-rigidbody]]
- [[unity-2d-tilemap-and-sprites]]
- [[unity-animation-rigging]]
- [[unity-audio-mixer]]

