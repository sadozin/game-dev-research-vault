---
title: 'Source: Demystifying evals for AI agents'
type: source
status: active
created: 2026-07-14
updated: 2026-07-14
verified: 2026-07-14
sources:
  - raw/anthropic-agent-evaluations.md
tags: [source, ai, agents, testing, software-engineering, game-development]
---

# Source: Demystifying evals for AI agents

- **Author:** Anthropic
- **Published:** 2026-01-09
- **URL:** https://www.anthropic.com/engineering/demystifying-evals-for-ai-agents
- **Raw:** raw/anthropic-agent-evaluations.md (provenance only)

## Summary

Anthropic recommends evaluating coding agents with stable, unambiguous tasks and deterministic outcome
checks such as tests, static analysis, and state verification. Human and model-based rubrics complement
these checks when quality is not binary. Existing bugs and manual release checks are valuable seeds for
an evaluation corpus.

For persistent-game work, the important extension is adversarial and invariant testing. An agent's code
does not belong because it compiles; it belongs when duplicate delivery, races, crash recovery,
deterministic replay, economy conservation, bandwidth, and migration gates still pass.

## Compiled into

- [[ai-assisted-game-development]]
- [[mmo-codebase-architecture]]
- [[mmo-common-pitfalls]]
