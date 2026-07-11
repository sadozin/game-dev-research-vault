---
title: Editor MCP safety
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[coplay-unity-mcp]]"
  - "[[unreal-mcp]]"
tags: [mcp, agents, security, game-development]
---

# Editor MCP safety

An editor MCP server gives an AI client authority to inspect and mutate a game project. Treat it
as local development automation with the same care as a shell that can modify scenes, source,
assets, settings, and builds.

## Why it works

MCP makes editor operations inspectable, reusable, and callable from compatible assistants. Keep
the server bound to loopback, use a project under version control, make changes in small verified
steps, and run editor or play-mode tests after agent-authored changes. Expose custom tools that
express safe domain operations rather than unrestricted arbitrary code where possible.

## The catch

Neither integration should be assumed safe to publish remotely. Unreal MCP defaults to local-only
with no authentication, and the current Unity MCP bridge is third-party and must be version-pinned
and reviewed before upgrade. Experimental integration and no authentication are release blockers,
not details to defer until after a game is shipped.

## In practice here

[[unity-mcp]] already documents connection-specific safety and testing gotchas. Apply the same
local-only discipline to any future [[unreal-mcp-integration]] setup and retain a human review
step for destructive project changes.
