---
title: Wave Function Collapse
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[mxgmn-wave-function-collapse]]"
tags: [game-development, procedural-generation]
---

# Wave Function Collapse

Wave Function Collapse generates a grid by choosing among locally compatible patterns and propagating
the consequences of each choice.

## Why it works

Example-based or authored adjacency rules preserve a visual grammar while allowing combinatorial
variation. Entropy-based selection tends to resolve the most constrained cells first.

## The catch

Local compatibility does not guarantee a solution or a coherent macro layout. Contradictions need
restart or backtracking, and a poor sample teaches poor rules.

## In practice

Add connectivity and boundary constraints, detect contradictions, seed important structures, and
keep a deterministic seed for debugging.

