---
title: MCP tool permission scoping
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[mcp-agent-safety-workflows]]"
tags: [game-development, ai, mcp, security]
---

# MCP tool permission scoping

Permission scoping limits an agent tool to the resources, operations, and side effects needed for one
task.

## Why it works

Separate read, preview, write, delete, build, and publish capabilities reduce the blast radius of a
bad argument or misunderstood instruction. Schemas and allowlists make the boundary inspectable.

## The catch

Granular permissions add friction and can become misleading if a “safe” tool calls a broad shell or
editor escape hatch underneath.

## In practice

Expose narrow typed operations, require confirmation for destructive effects, and audit the underlying
implementation rather than trusting tool names.

