---
title: 'Source: Making retries safe with idempotent APIs'
type: source
status: active
created: 2026-07-14
updated: 2026-07-14
verified: 2026-07-14
sources:
  - raw/aws-idempotent-apis.md
tags: [source, distributed-systems, persistence, reliability, game]
---

# Source: Making retries safe with idempotent APIs

- **Author:** Malcolm Featonby
- **Published:** 2021-01-15
- **URL:** https://aws.amazon.com/builders-library/making-retries-safe-with-idempotent-APIs/
- **Raw:** raw/aws-idempotent-apis.md (provenance only)

## Summary

Retries turn an unknown result into a correctness problem: a request can commit while its response is
lost, so repeating it can create a second side effect. AWS uses caller-provided request identifiers to
recognize a retry and return a semantically equivalent response. Recording the identifier and applying
the mutation must itself be atomic; otherwise a crash can separate the dedupe record from the effect.

For a persistent game, the same pattern applies to crafting, purchases, mail, trades, loot claims, and
zone transfers. The command ID belongs to the player's intent, not to one socket delivery. A repeated
command either produces the original canonical result or fails because the same ID was reused for a
different intent.

## Compiled into

- [[mmo-durable-command-processing]]
- [[mmo-common-pitfalls]]
- [[mmo-codebase-architecture]]
