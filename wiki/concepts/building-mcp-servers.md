---
title: Building MCP Servers
type: concept
status: active
created: 2026-07-14
updated: 2026-07-14
verified: 2026-07-14
tags: [ai-tooling, mcp, agents]
---

# Building MCP Servers

How to build (not just consume) Model Context Protocol servers, as of mid-2026. The tool
*interface* rules live in [[llm-tool-design]]; hardening and evals in [[agent-tool-evaluation]].
Local consumption experience is on [[blender-mcp]], [[unity-mcp]], and [[hermes]].

## Protocol shape

Six primitives: **tools** (model-invokable functions), **resources** (addressable, subscribable
data), **prompts** (reusable templates), **sampling** (server asks the client for an LLM
completion), **roots** (server asks what filesystem/URI boundaries it may touch), and
**elicitation** (server asks the user a direct question mid-session, added 2025-06-18).

Spec revision 2025-06-18: OAuth resource-server model with RFC 8707 Resource Indicators,
structured tool output (`structuredContent`), `resource_link` results, and **JSON-RPC batching
removed** (breaking). Revision 2025-11-25: OIDC Discovery, Client ID Metadata Documents for
registration, incremental scope consent, tool-calling inside sampling, experimental durable
"tasks", JSON Schema 2020-12 as default dialect, and a mandate that servers return HTTP 403 on
invalid `Origin` for Streamable HTTP. ⚠️ unverified: the 2025-11-25 changelog above came from a
secondary aggregator, not the spec repo's own changelog.

## SDKs

Python: the standalone **FastMCP** package (v3.x) is the de-facto standard and the maintained
successor to the `mcp.server.fastmcp` module in the official SDK — `@mcp.tool` on a typed
function is a complete server. TypeScript: `@modelcontextprotocol/sdk` with `McpServer` +
zod input schemas. Both default to stdio transport.

## Transports

**stdio** for local/CLI use — one process per client, no networking; this is what Claude Code
and Hermes launch. **Streamable HTTP** for remote/multi-client — replaced the old HTTP+SSE
dual-endpoint design; sessions ride an `Mcp-Session-Id` header, resumable via `Last-Event-ID`
replay. Stateful mode (in-memory session manager) breaks on restart/scale-to-zero — a known
FastMCP issue — so prefer **stateless** mode for serverless deployment. Not every client speaks
Streamable HTTP yet; check before building remote-only.

## Security

OAuth 2.1 with mandatory PKCE; validate token audience and never pass a client's token through
to an upstream API (confused-deputy risk). Attack classes to design against: **tool poisoning**
(malicious instructions in a tool's own description — found in 5.5% of 1,899 surveyed open-source
servers), **prompt injection via tool results** (instructions hidden in fetched content, executed
with the agent's existing permissions), and SSRF from tool-driven network calls (block egress to
private IP ranges). Treat tool descriptions from third-party servers as untrusted input. The
architectural framing for all of this is the lethal trifecta — see [[agent-tool-evaluation]].

## Testing and the #1 gotcha

**On stdio, stdout is exclusively for JSON-RPC.** Any stray `print()`/`console.log()` corrupts
the stream and silently kills the session (shows up as "Unexpected token" parse errors in the
Inspector). All logging goes to stderr — the 2025-11-25 spec says so explicitly. We hit the same
symptom class locally with the lowercase blender server's telemetry prompt hanging the
`initialize` handshake ([[blender-mcp]]). Use **MCP Inspector** to invoke tools against either
transport; also watch for handlers returning a raw value instead of a shaped `CallToolResult`,
which fails silently.

## Sources

- [MCP specification](https://modelcontextprotocol.io/specification/2025-06-18) · [2025-11-25 changelog (secondary)](https://modelcontextprotocol.info/specification/2025-11-25/changelog/)
- [FastMCP](https://github.com/PrefectHQ/fastmcp) · [TypeScript SDK](https://github.com/modelcontextprotocol/typescript-sdk)
- [MCP Security cheat sheet — OWASP](https://cheatsheetseries.owasp.org/cheatsheets/MCP_Security_Cheat_Sheet.html)
- [MCP debugging docs](https://modelcontextprotocol.io/docs/tools/debugging)
