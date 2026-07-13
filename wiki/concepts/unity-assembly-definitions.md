---
title: Unity assembly definitions
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[unity-lifecycle-serialization-architecture]]"
tags: [game-development, unity, tooling]
---

# Unity assembly definitions

Assembly definition files partition Unity scripts into explicit compilable assemblies.

## Why it works

When only one assembly changes, Unity can avoid recompiling unrelated code. Explicit references expose
architecture and allow tests or editor tooling to remain separate from runtime assemblies.

## The catch

Partitioning adds dependency management: circular references, platform filters, package boundaries,
and misplaced editor code produce confusing compile failures.

## In practice

Create boundaries around stable modules, keep dependency direction one-way, and measure compile times
before multiplying assemblies for cosmetic organization.

