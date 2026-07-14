---
title: MMO durable command processing
type: concept
status: active
created: 2026-07-14
updated: 2026-07-14
verified: 2026-07-14
sources:
  - [[wiki/sources/aws-idempotent-apis|aws-idempotent-apis]]
tags: [game, mmo, persistence, transactions, security]
---

# MMO durable command processing

A durable game command carries player intent and a stable command identifier. The server authenticates
the actor, validates ownership, reach, resources, cooldowns, permissions, rate, and expected version,
then applies the complete state change in one transaction. Success is reported only after commit.

The identifier survives retries and reconnects. Recording it, applying the mutation, and storing the
canonical response must be atomic; a repeated delivery returns the original result instead of creating
another side effect ([[wiki/sources/aws-idempotent-apis|aws-idempotent-apis]]). Reusing the same ID for
different intent is an error.

This pattern applies to crafting, purchase, loot claim, trade, mail, auction, quest completion, and zone
transfer. Property tests should deliver every durable command multiple times and race commands against
the same resource. An append-only ledger supplies support forensics and economy conservation, while
current state supplies efficient reads.

## Related

- [[mmo-server-architecture]]
- [[mmo-codebase-architecture]]
- [[mmo-common-pitfalls]]
- [[authoritative-server-and-anti-cheat]]
