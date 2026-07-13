---
title: "Source: Ahuja — BlenderMCP"
type: source
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "https://github.com/ahujasid/blender-mcp"
tags: [source, blender, mcp]
---

# Source: Ahuja — BlenderMCP

- **Author:** Siddharth Ahuja (`ahujasid`)
- **Published:** BlenderMCP repository README (GitHub)
- **URL:** https://github.com/ahujasid/blender-mcp
- **Retrieved:** 2026-07-11

## Summary

BlenderMCP is a third-party, open-source MCP server that connects Blender to an LLM client for
prompt-assisted modelling. Its architecture is two parts: a Blender addon (`addon.py`) opens a TCP
socket server on loopback—port 9876 by default, overridable through `BLENDER_HOST` and
`BLENDER_PORT`—and a separate MCP server process implements the protocol and forwards commands to
that socket using a simple JSON exchange of a typed request and a status/result response.

The exposed tools cover scene and object inspection, creating, modifying, and deleting objects,
material control, and an `execute_blender_code` tool that runs arbitrary Python inside the Blender
session. Optional integrations download ready assets from Poly Haven (models, textures, HDRIs) and
generate models through Hyper3D or Hunyuan3D, each toggleable in preferences. The README explicitly
warns that arbitrary-code execution is "powerful but potentially dangerous," to use caution in
production, and to "ALWAYS save your work before using it," and it states plainly that this is "a
third-party integration and not made by Blender." Because it is community-maintained, pin a version
and re-check the tool set and socket contract before relying on it.

## Compiled into

- [[blender-mcp]] — socket architecture, capabilities, and asset integrations
- [[editor-mcp-safety]] — arbitrary-code risk and local-only authority
