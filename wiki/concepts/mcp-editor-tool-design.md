---
title: MCP Editor Tool Design
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[mcp-tools-specification-and-safety]]"
  - "[[mcp-server-concepts]]"
tags: [game-development, mcp, tooling, editor, safety]
---

# MCP Editor Tool Design

An editor MCP tool should expose a narrow, high-level game-development operation with explicit inputs,
clear previews or results, and a bounded authority. The design target is an agent that can perform
useful editor work without receiving a raw shell, arbitrary code-execution, or ambiguous mutation API.

## Why it works

The MCP tool schema becomes a contract: the model discovers a named operation, supplies structured
arguments, and receives a result the host can log and review. Operations such as “create prefab from
selected objects” or “set material property” encode domain invariants that a generic file-write tool
cannot. Read-only inspection tools and preview/diff results let an agent plan before a mutating call.

## The catch

Tools are model-controlled execution surfaces, and a descriptive schema is not a security boundary by
itself. Broad tools increase blast radius, hidden side effects make approval meaningless, and chained
results can carry untrusted data between servers. Editor state also changes underneath a long-running
agent, so stale object identifiers and partial failures need explicit handling.

## In practice here

Separate inspect, plan/preview, and apply operations; validate every input server-side; identify the
target scene or asset explicitly; and return changed objects plus reversible checkpoints. Require
confirmation for destructive or wide-scope mutations, log the actor and parameters, reject stale
revisions, and make idempotence or rollback behavior part of the tool contract.
