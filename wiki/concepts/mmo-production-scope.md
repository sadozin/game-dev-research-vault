---
title: MMO production scope
type: concept
status: active
created: 2026-07-14
updated: 2026-07-14
verified: 2026-07-14
sources:
  - [[wiki/sources/aws-persistent-world-hosting-2025|aws-persistent-world-hosting-2025]]
  - [[wiki/sources/metr-ai-developer-productivity|metr-ai-developer-productivity]]
  - [[wiki/sources/online-service-privacy-and-platform-duties|online-service-privacy-and-platform-duties]]
tags: [game, mmo, design, production, planning]
---

# MMO production scope

An MMO scope is a promise about population, persistence, content throughput, trust, and operations, not
only map size. A one-to-three-person team should target a persistent small-world game: one regional
shard, explicit zone transitions, instanced adventures, and a measured concurrency cap. A persistent
hub combined with session-based activities can preserve social continuity without running every piece
of content continuously ([[wiki/sources/aws-persistent-world-hosting-2025|aws-persistent-world-hosting-2025]]).

The load-bearing design constraint is content economics: authored player-hours are consumed much faster
than a tiny team produces them. Systemic, social, procedural, and replayable structures must carry the
game. Low population is more likely than overload, so the game also needs a compact world, shared hubs,
asynchronous traces of activity, and encounters that remain useful with one player.

Live service is a separate decision from an MMO-shaped prototype. Pre-register gates around voluntary
replay, multi-session return, support load, restore capability, and sustainable content output. Do not
apply a generic AI schedule multiplier: empirical results vary with tool, task, repository familiarity,
and workflow ([[wiki/sources/metr-ai-developer-productivity|metr-ai-developer-productivity]]).

## Related

- [[mmo-content-economics]]
- [[mmo-server-architecture]]
- [[mmo-live-service-operations]]
- [[ai-assisted-game-development]]
