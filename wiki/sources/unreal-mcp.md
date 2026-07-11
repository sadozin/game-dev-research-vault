---
title: "Source: Epic — Unreal MCP"
type: source
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "raw/unreal-mcp.md"
tags: [source, unreal, mcp]
---

# Source: Epic — Unreal MCP

- **Author:** Epic Games
- **Published:** Unreal Engine 5.8 documentation
- **URL:** https://dev.epicgames.com/documentation/unreal-engine/unreal-mcp-in-unreal-editor
- **Retrieved:** 2026-07-11
- **Raw:** `raw/unreal-mcp.md` (provenance only)

## Summary

Unreal MCP is an official but experimental MCP server embedded in Unreal Editor. It can expose
editor functionality such as actor and material work, lighting, Slate inspection, and automation
tests. It runs locally by default without authentication, serializes tool calls on the game
thread, and needs the AllToolsets plugin to expose actual toolsets.

The documentation also supports runtime hosting, but that is distinct from editor tooling:
shipped builds must explicitly register their tools and must not inherit an unauthenticated editor
trust model. APIs and formats are explicitly subject to change.

## Compiled into

- [[unreal-mcp-integration]] — official experimental integration and setup
- [[editor-mcp-safety]] — local-only authority and tool-call discipline
