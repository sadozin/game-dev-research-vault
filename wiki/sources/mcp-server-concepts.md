---
title: "Source: Model Context Protocol — Server Concepts"
type: source
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "https://modelcontextprotocol.io/docs/learn/server-concepts"
  - "https://modelcontextprotocol.io/docs/learn/architecture"
tags: [source, game-development, mcp, tooling]
---

# Source: Model Context Protocol — Server Concepts

- **Author:** Model Context Protocol project
- **Published:** Undated
- **URL:** https://modelcontextprotocol.io/docs/learn/server-concepts
- **Retrieved:** 2026-07-11

## Summary

MCP server guidance distinguishes tools for actions from resources for contextual data and describes
tool discovery through `tools/list` followed by invocation through `tools/call`. This separation makes
it possible to offer read-only editor context without granting mutation authority, while dynamic tool
lists require clients to handle capability changes deliberately.

## Compiled into

- [[mcp-editor-tool-design]] — inspect/apply separation and discoverable editor contracts
