---
title: "Source: MCP — Tool Confirmation and Scope"
type: source
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "https://modelcontextprotocol.io/specification/2025-06-18/server/tools"
tags: [source, game-development, mcp, unity, prefabs, safety]
---

# Source: MCP — Tool Confirmation and Scope

- **Author:** Model Context Protocol project
- **Published:** 2025-06-18 specification
- **URL:** https://modelcontextprotocol.io/specification/2025-06-18/server/tools
- **Retrieved:** 2026-07-11

## Summary

MCP tool guidance calls for visible tool exposure and confirmation prompts so users can deny operations.
For prefab editing, that principle means exposing the target asset and propagation scope before a call,
with Apply-to-base treated as a materially different operation from a local override.

## Compiled into

- [[unity-mcp-prefab-workflow]] — explicit mutation scope and human confirmation
