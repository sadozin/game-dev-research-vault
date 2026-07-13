---
title: "Source: MCP — Authoring Tool Safety"
type: source
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "https://modelcontextprotocol.io/specification/2025-06-18/server/tools"
tags: [source, game-development, mcp, editor, safety]
---

# Source: MCP — Authoring Tool Safety

- **Author:** Model Context Protocol project
- **Published:** 2025-06-18 specification
- **URL:** https://modelcontextprotocol.io/specification/2025-06-18/server/tools
- **Retrieved:** 2026-07-11

## Summary

MCP tools are model-controlled functions, and the specification recommends clear exposure, invocation
indicators, and confirmation prompts. Editor integrations should therefore expose narrow, reviewable
operations with explicit target and scope instead of arbitrary code execution.

## Compiled into

- [[unreal-mcp-blueprint-authoring]] — graph mutation safety
- [[unreal-mcp-level-scripting]] — actor and level mutation safety
- [[godot-mcp-integration]] — scene and resource mutation safety
