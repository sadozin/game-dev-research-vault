---
title: "Source: MCP agent safety workflow references"
type: source
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "https://modelcontextprotocol.io/specification/2025-06-18/server/tools"
  - "https://modelcontextprotocol.io/specification/2025-06-18/server/resources"
tags: [source, game-development, ai, mcp]
---

# Source: MCP agent safety workflow references

- **Author:** Model Context Protocol maintainers
- **Published:** 2025-06-18 specification
- **URL:** https://modelcontextprotocol.io/specification/2025-06-18/server/tools
- **Retrieved:** 2026-07-11

## Summary

MCP tools expose named operations with schemas, descriptions, and structured results; resources expose
readable context separately. Safe editor automation benefits from the same separation: checkpoint
state, scope permissions, validate arguments, and require confirmation for destructive or externally
visible effects. A tool schema reduces ambiguity but does not make an unsafe operation safe by itself.

## Compiled into

- [[mcp-editor-checkpointing]]
- [[mcp-tool-permission-scoping]]
- [[ai-batch-asset-generation]]
- [[ai-gameplay-script-generation]]

