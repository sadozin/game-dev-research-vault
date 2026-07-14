---
title: AI-assisted game development
type: concept
status: active
created: 2026-07-14
updated: 2026-07-14
verified: 2026-07-14
sources:
  - [[wiki/sources/metr-ai-developer-productivity|metr-ai-developer-productivity]]
  - [[wiki/sources/anthropic-agent-evaluations|anthropic-agent-evaluations]]
tags: [game, ai, software-engineering, testing, production]
---

# AI-assisted game development

AI coding assistance is most reliable on bounded work with objective outcomes: serializers, test
fixtures, content validators, administrative tools, migrations, load bots, and documentation verified
against code. Product scope, feel, authority boundaries, economy policy, incident decisions, and legal
or moderation policy remain human-owned.

Use a contract-first loop: specify invariants and failure cases, write acceptance tests, prove the test
fails, implement one bounded change, run deterministic and adversarial gates, review high-risk paths,
and record the architectural decision. Convert every production bug into a permanent replay or test
case. This matches eval-driven agent practice, which combines deterministic tests and static analysis
with human or rubric review where quality is not binary
([[wiki/sources/anthropic-agent-evaluations|anthropic-agent-evaluations]]).

Do not budget with a universal productivity multiplier. The METR result and its later methodology
update show that experienced developers, familiar repositories, tool generation, task shape, and
workflow can reverse the measured outcome ([[wiki/sources/metr-ai-developer-productivity|metr-ai-developer-productivity]]).
Measure time from accepted task to verified merge, rework, review burden, and escaped defects.

## Related

- [[mmo-codebase-architecture]]
- [[mmo-production-scope]]
- [[agent-tool-evaluation]]
