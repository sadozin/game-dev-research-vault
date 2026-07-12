---
title: Utility AI
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[utility-ai-and-flow-fields]]"
tags: [game-development, ai, gameplay]
---

# Utility AI

Utility AI chooses among actions by scoring how desirable each action is under current facts.

## Why it works

Curves convert hunger, danger, distance, and urgency into comparable utilities. Designers can tune
continuous preferences without encoding every combination as a branch.

## The catch

Scores are only as good as their normalization and context. Unstable inputs can cause thrashing, and
an apparently rational maximum can be tactically dull or exploit a scoring loophole.

## In practice

Normalize inputs, add hysteresis or commitment windows, log score breakdowns, and reserve hard rules
for safety constraints.

