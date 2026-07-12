---
title: "Source: gameplay motion, collision, and architecture references"
type: source
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "https://gamma.cs.unc.edu/RVO/"
  - "https://gameprogrammingpatterns.com/event-queue.html"
  - "https://gafferongames.com/post/fix_your_timestep/"
tags: [source, game-development, gameplay, ai]
---

# Source: gameplay motion, collision, and architecture references

- **Author:** University of North Carolina RVO researchers; Robert Nystrom; Glenn Fiedler
- **Published:** 2008 / 2014 / 2004
- **URL:** https://gamma.cs.unc.edu/RVO/
- **Retrieved:** 2026-07-11

## Summary

Crowd avoidance, hit detection, ragdolls, procedural motion, tweening, event queues, and update loops
all separate a desired result from the mechanism that produces it. The reusable pattern is valuable,
but temporal order, collision authority, numerical stability, and debugging visibility determine whether
the abstraction remains trustworthy under load.

## Compiled into

- [[crowd-avoidance-rvo]]
- [[damage-and-hitbox-systems]]
- [[ragdoll-and-physics-animation]]
- [[procedural-animation]]
- [[tweening-and-easing]]
- [[event-bus-messaging]]
- [[game-loop-and-update-order]]

