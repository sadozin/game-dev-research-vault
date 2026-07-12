---
title: "Source: Epic — Networking Overview"
type: source
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "https://dev.epicgames.com/documentation/unreal-engine/networking-overview"
tags: [source, game-development, multiplayer, networking, server-authority, security]
---

# Source: Epic — Networking Overview

- **Author:** Epic Games
- **Published:** Unreal Engine 5.8 documentation
- **URL:** https://dev.epicgames.com/documentation/unreal-engine/networking-overview
- **Retrieved:** 2026-07-11

## Summary

Epic's overview treats the server as the one authoritative game state while clients maintain close
visual approximations. Clients send requests or RPCs from locally owned objects; the server runs
gameplay and replicates selected state back. The documentation separates essential interactions
such as movement, collision, and damage from cosmetic effects and HUD data, because replication
must be deliberately scoped to each connection to avoid saturating bandwidth. Ownership determines
which client may request actions, but server authority determines which state changes are accepted.

## Compiled into

- [[authoritative-server-and-anti-cheat]] — trust boundaries, validation, ownership, and selective replication
