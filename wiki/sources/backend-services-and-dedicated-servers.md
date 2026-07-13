---
title: "Source: dedicated servers, cloud persistence, and game service references"
type: source
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "https://learn.microsoft.com/en-us/gaming/playfab/multiplayer/servers/"
  - "https://learn.microsoft.com/en-us/gaming/playfab/features/leaderboards/"
  - "https://learn.microsoft.com/en-us/gaming/playfab/features/authentication/"
tags: [source, game-development, backend, multiplayer]
---

# Source: dedicated servers, cloud persistence, and game service references

- **Author:** Microsoft PlayFab
- **Published:** continuously maintained documentation
- **URL:** https://learn.microsoft.com/en-us/gaming/playfab/multiplayer/servers/
- **Retrieved:** 2026-07-11

## Summary

Dedicated server fleets, cloud saves, leaderboards, and player authentication are separate service
contracts. They need lifecycle, identity, persistence, validation, and failure policies rather than a
single “backend” abstraction. Managed services reduce operations work but add quotas, latency,
provider coupling, and reconciliation concerns.

## Compiled into

- [[dedicated-server-scaling]]
- [[cloud-save-and-leaderboards]]
- [[player-auth-and-accounts]]

