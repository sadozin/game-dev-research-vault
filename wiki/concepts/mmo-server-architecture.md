---
title: MMO server architecture
type: concept
status: active
created: 2026-07-14
updated: 2026-07-14
verified: 2026-07-14
sources:
  - [[wiki/sources/aws-persistent-world-hosting-2025|aws-persistent-world-hosting-2025]]
  - [[wiki/sources/agones-fleets-and-autoscaling|agones-fleets-and-autoscaling]]
  - [[wiki/sources/epic-replication-graph|epic-replication-graph]]
tags: [game, mmo, networking, backend, architecture]
---

# MMO server architecture

A small MMO backend should begin as a modular monolith: one authoritative world process per explicit
zone, one durable database, and code-level boundaries between simulation, commands, persistence,
protocol, content, and telemetry. Microservices turn local calls into partial failure and distributed
transactions before the team has a measured reason to pay that cost.

The simulation process and durable world have separate lifecycles. A zone may crash, drain, rotate, or
move while the world identity survives through external persistence
([[wiki/sources/aws-persistent-world-hosting-2025|aws-persistent-world-hosting-2025]]). Hard loading
boundaries make ownership transfer visible and testable; seamless cross-process handoff is a later
distributed-systems problem, not a prerequisite for persistence.

Interest management controls bandwidth, CPU, and information exposure. Spatial partitioning supplies
candidates; gameplay priority, connection byte budgets, frequency tiers, and dormancy decide what is
sent. Unreal's Replication Graph is one concrete implementation of cached, connection-specific actor
lists ([[wiki/sources/epic-replication-graph|epic-replication-graph]]).

Fleet orchestration is bought only when session lifecycle and measured demand justify it. Agones can
maintain ready capacity and autoscale from player or room counters, but it adds Kubernetes operations
and does not replace matchmaking policy, persistence, or simulation design
([[wiki/sources/agones-fleets-and-autoscaling|agones-fleets-and-autoscaling]]).

## Related

- [[mmo-interest-management]]
- [[mmo-durable-command-processing]]
- [[mmo-codebase-architecture]]
- [[mmo-live-service-operations]]
