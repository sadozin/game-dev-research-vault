---
title: Unreal MCP integration
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[unreal-mcp]]"
tags: [unreal, mcp, agents]
---

# Unreal MCP integration

Unreal MCP is Epic's experimental MCP server built into Unreal Editor. Enable the `Unreal MCP`
plugin, configure auto-start, and connect an MCP client to its local HTTP endpoint. It exposes
editor functions through toolsets and can be extended with custom tools.

## Why it works

An embedded server can run actions on the Unreal game thread, so an agent can drive scene work,
materials, lighting, inspection, and automation tests through a standard protocol. Tool-search
mode limits the initial tool list to discovery tools, which reduces agent context pressure until a
specific toolset is needed.

## The catch

The feature is explicitly experimental: APIs and data formats can change. Calls are serialized on
the game thread, so clients must not issue overlapping tool calls. By default it binds locally,
has no authentication, and is not for remote exposure. The AllToolsets plugin supplies tools;
enabling the server alone does not provide a useful editor surface.

## In practice here

No Unreal project or installation is verified on this machine. If one is created, use the
documented default `http://127.0.0.1:8000/mcp`, generate the client configuration from the
editor, and restrict the connection to the local development machine. See [[editor-mcp-safety]].
