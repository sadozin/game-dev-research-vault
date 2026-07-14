---
title: MMO interest management
type: concept
status: active
created: 2026-07-14
updated: 2026-07-14
verified: 2026-07-14
sources:
  - [[wiki/sources/epic-replication-graph|epic-replication-graph]]
tags: [game, mmo, networking, replication, performance]
---

# MMO interest management

Interest management chooses which entities and updates each connection may receive under a fixed byte
and CPU budget. It replaces broadcast-to-all replication with a connection-specific working set.

Spatial cells, grids, or graph nodes cheaply produce candidates. Priority then considers distance,
view, party membership, quest targets, combat relevance, recency, and starvation. Nearby combat may
update frequently while distant ambient actors update rarely; unchanged actors become dormant and cost
nothing until woken. Unreal's Replication Graph demonstrates persistent nodes that cache and assemble
per-connection replication lists ([[wiki/sources/epic-replication-graph|epic-replication-graph]]).

A radius is not a complete policy. It collapses when everyone enters the same capital or world-boss
arena. Define graceful degradation before launch: preserve commands and nearby threats, reduce distant
frequency, cap cosmetic state, and alert on budget starvation. Interest management is also a security
control because unsent entities cannot be extracted from client memory.

## Related

- [[mmo-server-architecture]]
- [[network-relevancy-and-interest-management]]
- [[delta-compression-netcode]]
