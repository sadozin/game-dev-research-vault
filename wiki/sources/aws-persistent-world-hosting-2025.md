---
title: 'Source: Host persistent world games on Amazon GameLift Servers'
type: source
status: active
created: 2026-07-14
updated: 2026-07-14
verified: 2026-07-14
sources:
  - raw/aws-persistent-world-hosting-2025.md
tags: [source, game, mmo, backend, operations]
---

# Source: Host persistent world games on Amazon GameLift Servers

- **Author:** Juho Jantunen
- **Published:** 2025-06-18
- **URL:** https://aws.amazon.com/blogs/gametech/host-persistent-world-games-on-amazon-gamelift-servers/
- **Raw:** raw/aws-persistent-world-hosting-2025.md (provenance only)

## Summary

AWS separates persistent-world lifecycle, player-session routing, game-server processes, and external
world storage. Long-running worlds still need periodic external persistence for crash recovery,
rotation, and idle shutdown. The article presents object storage, local database backups, key-value
storage, and secure persistence APIs as different trade-offs rather than one universal answer.

The useful general lesson is that a persistent world has two lifecycles: the simulation process and
the durable world. A process may be replaced without losing the identity of the world. Mixing
persistent hubs with session-based dungeons also reduces the amount of simulation that must run
continuously. The page is vendor guidance and should not be read as proof that every component must
be an AWS service.

## Compiled into

- [[mmo-server-architecture]]
- [[mmo-live-service-operations]]
- [[mmo-production-scope]]
