---
title: "Source: MCP — Reversible Scene Cleanup"
type: source
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "https://modelcontextprotocol.io/specification/2025-06-18/server/tools"
tags: [source, game-development, blender, mcp, assets, safety]
---

# Source: MCP — Reversible Scene Cleanup

- **Author:** Model Context Protocol project
- **Published:** 2025-06-18 specification
- **URL:** https://modelcontextprotocol.io/specification/2025-06-18/server/tools
- **Retrieved:** 2026-07-11

## Summary

MCP recommends visible tools, invocation indicators, and confirmation prompts. A cleanup tool should
show its target scope and proposed deletions or reparenting before execution, with a checkpoint or
recovery path for changes that cannot be inferred from a simple output diff.

## Compiled into

- [[blender-mcp-scene-cleanup]] — diagnostics, approval, and reversible mutation
