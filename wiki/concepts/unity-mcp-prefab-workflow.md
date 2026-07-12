---
title: Unity MCP Prefab Workflow
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[unity-prefab-variants-and-overrides]]"
  - "[[mcp-tools-prefab-safety]]"
tags: [game-development, unity, mcp, prefabs, editor]
---

# Unity MCP Prefab Workflow

An MCP prefab workflow must distinguish editing a prefab asset, editing an instance override, and
creating a variant. Those are different ownership operations: applying an instance override can alter
the shared source and propagate to every instance, while a variant should preserve its differences as
overrides.

## Why it works

Unity's prefab model provides reusable assets, instances, nested prefabs, and variants. A scene-authoring
tool can inspect the prefab source and override context, make a targeted change, and report whether the
result is local or shared. Structured operations map cleanly to actions such as add component, set
property override, create variant, or explicitly apply to a named base asset.

## The catch

The most dangerous failure is a context mistake: applying a change intended for one instance to the
base prefab changes every consumer. Nested prefabs add multiple possible apply targets, and stale
instances can have overrides that conflict with the requested edit. An agent that only sees a hierarchy
path cannot safely infer ownership.

## In practice here

Require the tool to return source asset, instance, variant, and override state before mutation. Make
instance edits the default, require explicit confirmation for Apply, and show the exact propagation
target. Reopen or re-query the asset after changes, save through Unity's prefab APIs, and test a sample
of dependent scenes before committing the result.
