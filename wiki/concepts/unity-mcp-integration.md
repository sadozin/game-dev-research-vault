---
title: Unity MCP integration
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[coplay-unity-mcp]]"
tags: [unity, mcp, agents]
---

# Unity MCP integration

Unity has a practical MCP route through CoplayDev's third-party MCP for Unity package. It bridges
an MCP client to a running Unity Editor and can manage scenes and assets, edit code, run tests,
profile, and build. It is not an official Unity Technologies product.

## Why it works

The package provides a common tool interface to many MCP clients instead of a custom automation
integration per assistant. The current install supports Unity 2021.3 LTS through 6.x and uses
Python plus `uv` for the bridge. It can configure compatible clients and use HTTP or stdio
transport; the active machine configuration is captured in [[unity-mcp]].

## The catch

This is an Editor-authority tool. It can alter scenes, scripts, and builds, so use a versioned
project, make tool scope explicit, and verify changes with tests or an editor inspection. Pin the
package version before adopting it: upstream changes frequently, and the retrieved repository's
latest release was v10.0.0 on 2026-06-30. The installed version on this machine is unverified.

## In practice here

Follow [[unity-mcp]] for the known Windows connection and CodeDom constraints. Before attaching
it to a new Unity project, confirm the Unity version, installed package version, transport, and
test runner on that project rather than copying assumptions from the deleted Testgame project.
