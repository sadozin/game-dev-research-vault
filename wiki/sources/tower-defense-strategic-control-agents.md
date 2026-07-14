---
title: 'Source: Reinforcement Learning for High-Level Strategic Control in Tower Defense Games'
type: source
status: active
created: 2026-07-14
updated: 2026-07-14
verified: 2026-07-14
sources:
  - raw/tower-defense-strategic-control-agents.md
tags: [source, game, tower-defense, ai, testing]
---

# Source: Reinforcement Learning for High-Level Strategic Control in Tower Defense Games

- **Authors:** Joakim Bergdahl, Alessandro Sestini, Linus Gisslen; EA SEED
- **Published:** 2024, IEEE Conference on Games
- **URL:** https://arxiv.org/abs/2406.07980
- **Retrieved:** 2026-07-14
- **Raw:** raw/tower-defense-strategic-control-agents.md (provenance only)

## Summary

EA SEED models tower defense as high-level strategic choices over economy, attack, defense, and
preparation, with scripted low-level execution. Across forty tested levels, its hybrid learned and
scripted agent reached a 57.12 percent success rate compared with 47.95 percent for the heuristic
baseline.

The agent generalized poorly to unseen levels. The result supports automated agents as scalable
playtest instruments while rejecting the idea that one capable bot is a universal difficulty oracle.
Use multiple policies and seeds, preserve targeted scripts for edge cases, and retain human tests for
comprehension and perceived fairness.

## Compiled into

- [[tower-defense-economy-and-wave-design]]
- [[tower-defense-targeting-and-balance]]
