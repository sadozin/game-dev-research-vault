---
title: Blender MCP Scene Cleanup
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[blender-collections-and-organization]]"
  - "[[mcp-tools-scene-cleanup-safety]]"
tags: [game-development, blender, mcp, assets, tooling]
---

# Blender MCP Scene Cleanup

Scene cleanup through MCP is controlled normalization: naming objects and collections, removing known
temporary data, fixing collection membership, and applying documented transforms without changing the
asset's intended content. It should produce a report and be reversible.

## Why it works

Blender Collections provide logical grouping, visibility, linking, and export scope. A cleanup tool can
use those structures and stable datablock identities to organize scenes consistently, while checking
duplicates, unused data, naming conventions, and transforms before writing.

## The catch

Names are references for artists and tools, and collections can be shared, linked, instanced, or used as
export boundaries. Deleting “unused” data can break hidden references; moving an object can change export
scope; applying transforms can alter animation or modifier results. A broad cleanup pass can therefore
damage a scene while making it look tidier.

## In practice here

Run read-only diagnostics first, classify every proposed change, exclude linked/library data by default,
and require confirmation for deletion, reparenting, or transform application. Save a checkpoint, emit a
machine-readable diff, and validate object counts, collections, references, and export output afterward.
