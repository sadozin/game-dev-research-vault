---
title: Blender MCP
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[ahujasid-blender-mcp]]"
tags: [blender, mcp, agents]
---

# Blender MCP

Blender MCP is a third-party, open-source Model Context Protocol server that lets an AI client drive
Blender—inspecting scenes, creating and editing objects, assigning materials, and running Python—
through a socket that a Blender addon opens. Like the Unity and Unreal editor bridges it turns
modelling operations into inspectable tool calls, and it carries the same local-authority risk.

## Why it works

The design is two parts: a Blender addon opens a loopback TCP socket (default port 9876) and a
separate MCP server forwards JSON commands to it, so any MCP-compatible assistant calls one common
tool set instead of a bespoke automation per assistant. Beyond primitive object and material
operations it can execute arbitrary Python inside Blender and can optionally pull ready assets from
Poly Haven or generate them through Hyper3D, which makes it a fast way to block out or populate a
scene. Keep it bound to localhost and treat each generated change as a reviewable step.

## The catch

The `execute_blender_code` tool runs arbitrary Python in the live Blender session—powerful and
dangerous—so the project's own guidance is to save first and avoid casual use in production; hold it
to the same discipline as [[editor-mcp-safety]]. It is community-maintained and explicitly not a
Blender product, so tool names, capabilities, and the socket contract can shift between versions:
pin a version and re-verify before depending on it. Most important for games, driving Blender is not
the same as producing a runtime asset—nothing here validates engine budgets or export correctness.

## In practice here

Use Blender MCP to accelerate authoring, then hand the result to the [[blender-game-asset-pipeline]]
for export validation and to [[texture-baking-for-games]] for baked detail; MCP controls Blender but
does not replace either step. Apply the loopback-only, versioned, human-reviewed rules from
[[editor-mcp-safety]] exactly as you would for the Unity and Unreal editor bridges.
