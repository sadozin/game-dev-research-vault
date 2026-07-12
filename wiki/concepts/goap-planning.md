---
title: GOAP planning
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[jeff-orkin-goap]]"
tags: [game-development, ai, gameplay]
---

# GOAP planning

Goal-Oriented Action Planning searches for a sequence of actions whose preconditions and effects move
the world toward a desired goal.

## Why it works

Designers author reusable facts and actions rather than every complete behavior path. The planner can
adapt when the current world state changes.

## The catch

Search cost and action interactions grow quickly. Incomplete world state can produce a valid-looking
plan that fails in execution, while unconstrained actions create repetitive or unsafe behavior.

## In practice

Bound search depth, add action costs and safety preconditions, and validate plans against the live
world before committing to them.

