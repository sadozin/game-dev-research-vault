---
title: "Source: CoplayDev — MCP for Unity"
type: source
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "raw/coplay-unity-mcp.md"
tags: [source, unity, mcp]
---

# Source: CoplayDev — MCP for Unity

- **Author:** CoplayDev contributors
- **Published:** Continuously maintained repository
- **URL:** https://github.com/CoplayDev/unity-mcp
- **Retrieved:** 2026-07-11
- **Raw:** `raw/coplay-unity-mcp.md` (provenance only)

## Summary

MCP for Unity is a third-party, MIT-licensed bridge between MCP clients and the Unity Editor. It
exposes focused tools for scene and asset work, scripts, tests, profiling, and builds. Its current
installation path is a Unity package from the repository's `MCPForUnity` subdirectory, with Python
and `uv` supplying the bridge process; it explicitly states that it is not affiliated with Unity
Technologies.

The project changes quickly. The retrieved repository lists v10.0.0 on 2026-06-30, so version pin
and upgrade verification are mandatory for an existing project.

## Compiled into

- [[unity-mcp-integration]] — third-party Unity Editor MCP workflow
- [[editor-mcp-safety]] — local-editor authority and upgrade boundaries
- [[unity-mcp]] — machine-specific connection notes
