---
title: 'Source: Replication Graph in Unreal Engine'
type: source
status: active
created: 2026-07-14
updated: 2026-07-14
verified: 2026-07-14
sources:
  - raw/epic-replication-graph.md
tags: [source, game, unreal, networking, replication]
---

# Source: Replication Graph in Unreal Engine

- **Author:** Epic Games
- **Version:** Unreal Engine 5.7 documentation
- **URL:** https://dev.epicgames.com/documentation/en-us/unreal-engine/replication-graph-in-unreal-engine
- **Raw:** raw/epic-replication-graph.md (provenance only)

## Summary

Unreal's Replication Graph organizes actors into persistent graph nodes that produce replication lists
for individual connections. Its goal is to reduce per-actor, per-connection CPU work when a server has
many synchronized actors and clients. Nodes can encode spatial and game-specific relevance instead of
testing every actor against every connection every frame.

The engine feature demonstrates a broader rule: interest management needs cached structure, gameplay
priority, and per-connection selection. It does not prove a universal player limit, and installing the
feature does not supply a complete MMO topology or capacity plan.

## Compiled into

- [[mmo-interest-management]]
- [[mmo-server-architecture]]
- [[mmo-common-pitfalls]]
