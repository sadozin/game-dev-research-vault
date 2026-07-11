---
title: "Source: Epic — collision overview"
type: source
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "raw/unreal-collision-overview.md"
tags: [source, 3d, collision, physics]
---

# Source: Epic — collision overview

- **Author:** Epic Games
- **Published:** Unreal Engine 5.8 documentation
- **URL:** https://dev.epicgames.com/documentation/en-us/unreal-engine/collision-in-unreal-engine---overview
- **Retrieved:** 2026-07-11
- **Raw:** `raw/unreal-collision-overview.md` (provenance only)

## Summary

Collision is a policy between object types and trace types, not merely geometry. Each pair can
block, overlap, or ignore; hit events require the relevant simulation/event settings. This
separates physical blocking, trigger behavior, and gameplay queries so each can use an appropriate
cost and fidelity.

## Compiled into

- [[game-collision-design]] — collision layers and simple proxy geometry
- [[mmo-combat-roles]] — gameplay traces as intentional interaction rules
