---
title: "Source: multiplayer synchronization and relevancy references"
type: source
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "https://gafferongames.com/post/state_synchronization/"
  - "https://dev.epicgames.com/documentation/en-us/unreal-engine/replication-graph-in-unreal-engine"
tags: [source, game-development, networking]
---

# Source: multiplayer synchronization and relevancy references

- **Author:** Glenn Fiedler; Epic Games
- **Published:** 2014 / continuously maintained documentation
- **URL:** https://gafferongames.com/post/state_synchronization/
- **Retrieved:** 2026-07-11

## Summary

State synchronization needs a defined authority, snapshot or command contract, and a way to detect
when replicas diverge. Interest management reduces work by sending entities according to relevance,
priority, distance, or dormancy. Both optimizations create correctness obligations: omitted state must
be recoverable, and a checksum must identify divergence without becoming the only debugging evidence.

## Compiled into

- [[desync-detection-and-recovery]]
- [[network-relevancy-and-interest-management]]

