---
title: Unity MCP Import Settings
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[unity-presets-and-import-settings]]"
  - "[[mcp-tools-import-safety]]"
tags: [game-development, unity, mcp, assets, editor]
---

# Unity MCP Import Settings

An MCP import-settings tool should configure a known Unity importer through validated presets, not
rewrite arbitrary `.meta` files or guess at importer properties. Import settings affect mesh scale,
materials, textures, animations, platform overrides, and reimport behavior, so they are project data.

## Why it works

Unity Presets can store importer properties and apply defaults through the Preset Manager or by asset
path filters. An MCP server can inspect the asset type and current importer, preview the intended diff,
apply an approved preset, and report the resulting reimport. This makes a team convention repeatable
without requiring an agent to manipulate serialized files directly.

## The catch

Not every importer property is safe to overwrite, and platform overrides can make one setting correct
for PC but wrong for mobile. Reimport may alter generated materials, meshes, or animation data, while
glob filters can affect more files than intended. A tool that applies a preset without showing scope
can create broad, difficult-to-review asset churn.

## In practice here

Resolve the importer and asset path first, show the exact preset and affected files, restrict filters to
an allowed project area, and preserve the previous settings for rollback. Apply changes in small batches,
wait for reimport completion, inspect representative outputs per platform, and commit preset assets and
importer changes together.
