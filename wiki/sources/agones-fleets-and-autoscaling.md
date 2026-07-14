---
title: 'Source: Agones fleets and autoscaling'
type: source
status: active
created: 2026-07-14
updated: 2026-07-14
verified: 2026-07-14
sources:
  - raw/agones-fleets-and-autoscaling.md
tags: [source, game, backend, hosting, kubernetes]
---

# Source: Agones fleets and autoscaling

- **Author:** Agones project
- **Updated:** 2026-07-08
- **URLs:** https://agones.dev/site/docs/overview/ and https://agones.dev/site/docs/reference/fleetautoscaler/
- **Raw:** raw/agones-fleets-and-autoscaling.md (provenance only)

## Summary

Agones extends Kubernetes with game-server lifecycle, allocation, health, fleets, rolling updates,
metrics, and autoscaling. A fleet is a pool of ready or allocated game servers. Autoscaling can keep a
ready buffer and can use player, room, or other capacity counters to preserve spare capacity across a
fleet.

The generalizable lesson is to scale against player-serving capacity and startup latency, not generic
container CPU alone. The operational cost is equally important: Agones is an orchestration layer on
Kubernetes, not a replacement for match policy, durable world storage, simulation architecture, or a
team capable of operating the cluster.

## Compiled into

- [[mmo-server-architecture]]
- [[mmo-live-service-operations]]
- [[mmo-common-pitfalls]]
