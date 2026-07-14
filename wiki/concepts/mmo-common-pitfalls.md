---
title: MMO common pitfalls
type: concept
status: active
created: 2026-07-14
updated: 2026-07-14
verified: 2026-07-14
sources:
  - [[wiki/sources/aws-idempotent-apis|aws-idempotent-apis]]
  - [[wiki/sources/agones-fleets-and-autoscaling|agones-fleets-and-autoscaling]]
  - [[wiki/sources/epic-replication-graph|epic-replication-graph]]
  - [[wiki/sources/owasp-bot-management|owasp-bot-management]]
  - [[wiki/sources/anthropic-agent-evaluations|anthropic-agent-evaluations]]
tags: [game, mmo, architecture, testing, pitfalls]
---

# MMO common pitfalls

MMO projects repeatedly build scale before proving repeat play, trust client-authored outcomes, save
only on logout, split into microservices before measuring a bottleneck, and use a spatial radius as the
entire replication policy. These choices make distributed failure the default while the game remains
unproven.

Durability failures cluster around retries without stable command IDs, non-atomic item transfers,
duplicate ownership during reconnect or handoff, and per-player snapshot restores that ignore trade
history. Content failures cluster around a hand-authored treadmill, balance embedded in code, and no
schema-migration corpus. Operational failures cluster around average-load tests, untested backups,
unbounded player-triggered reads, no protocol-version policy, and no moderation or sunset plan.

AI assistance adds semantic entropy when one model writes the requirement, implementation, and test
from the same misunderstanding. Independent acceptance criteria, invariant and property tests,
architectural import rules, recorded replays, and human review of authority paths reduce this risk
([[wiki/sources/anthropic-agent-evaluations|anthropic-agent-evaluations]]).

## Related

- [[mmo-production-scope]]
- [[mmo-codebase-architecture]]
- [[mmo-durable-command-processing]]
- [[mmo-live-service-operations]]
