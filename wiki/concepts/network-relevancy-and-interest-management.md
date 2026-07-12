---
title: Network relevancy and interest management
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[netcode-desync-and-relevancy]]"
tags: [game-development, networking, multiplayer, optimization]
---

# Network relevancy and interest management

Interest management decides which entities and updates a connection should receive.

## Why it works

Spatial partitions, ownership, priority, dormancy, and visibility turn an all-to-all replication
problem into a per-client budget. Unimportant actors can update less often or not at all.

## The catch

Filtering is a gameplay correctness boundary: late relevance changes need baselines, hidden entities
may still affect prediction, and distance alone misses sound, quests, and team information.

## In practice

Define relevance by gameplay information, keep a per-client byte budget, and test enter/leave-area
transitions as carefully as replication itself.

