---
title: MMO codebase architecture
type: concept
status: active
created: 2026-07-14
updated: 2026-07-14
verified: 2026-07-14
sources:
  - [[wiki/sources/aws-idempotent-apis|aws-idempotent-apis]]
  - [[wiki/sources/anthropic-agent-evaluations|anthropic-agent-evaluations]]
  - [[wiki/sources/metr-ai-developer-productivity|metr-ai-developer-productivity]]
tags: [game, mmo, architecture, testing, codebase]
---

# MMO codebase architecture

An MMO codebase should encode authority and durability as dependency rules. A pure fixed-step
simulation imports no network, persistence, system clock, or ambient random source. A command module
turns authenticated client intent into validated domain operations. A persistence module is the only
code allowed to construct transaction handles or touch the durable database. Protocol and content
packages are versioned separately, and the client cannot import server persistence.

Enforce the graph in CI instead of relying on review memory. The release gates are deterministic replay
hashes, property-based idempotency, concurrent resource races, economy conservation, protocol
compatibility, golden saves from every shipped schema, bytes per client, and simulation tick p99.
Agent evaluation guidance supports deterministic outcome checks and stable tasks
([[wiki/sources/anthropic-agent-evaluations|anthropic-agent-evaluations]]); MMO-specific invariants make
those checks relevant to distributed game state.

Artificial intelligence accelerates bounded changes only when the contract states inputs, invariants,
failure behavior, budgets, forbidden edits, and completion tests. Human review is reserved for command,
persistence, authentication, economy, and migration paths. Empirical AI productivity varies enough
that local cycle time and escaped defects are more credible than a universal schedule multiplier
([[wiki/sources/metr-ai-developer-productivity|metr-ai-developer-productivity]]).

## Related

- [[ai-assisted-game-development]]
- [[mmo-durable-command-processing]]
- [[mmo-server-architecture]]
- [[fixed-timestep-and-determinism]]
