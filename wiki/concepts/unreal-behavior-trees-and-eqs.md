---
title: Unreal Behavior Trees and EQS
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[unreal-ai-and-effects]]"
tags: [game-development, unreal, ai]
---

# Unreal Behavior Trees and EQS

Behavior Trees select executable branches from Blackboard state; the Environment Query System searches
world candidates against tests.

## Why it works

Decision structure and spatial selection are separated: a tree can ask for cover, targets, or patrol
locations without hardcoding every world coordinate.

## The catch

Stale Blackboard facts, expensive queries, and conflicting services produce AI that is technically
active but tactically confused.

## In practice

Bound query frequency and candidate counts, log the selected branch and score, and treat Blackboard
ownership as part of the AI architecture.

