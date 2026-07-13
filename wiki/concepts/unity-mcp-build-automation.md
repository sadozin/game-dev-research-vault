---
title: Unity MCP Build Automation
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[unity-command-line-builds]]"
  - "[[mcp-tools-build-approval]]"
tags: [game-development, unity, mcp, build, automation]
---

# Unity MCP Build Automation

Unity build automation through MCP should be a bounded orchestration tool: select a project, target,
build profile, scenes, output, and log location, then run a known build entry point and return the
result. It should not expose arbitrary shell commands or silently ship artifacts.

## Why it works

Unity supports command-line builds and custom `-executeMethod` build scripts, with batch mode, target
selection, logs, and an explicit quit. An MCP server can wrap those known entry points, validate paths
and profiles, stream progress, and return artifact metadata and exit status to a CI or agent workflow.

## The catch

Builds mutate caches, consume substantial time and disk, depend on installed modules and credentials,
and can overwrite an output path. A successful editor exit does not guarantee a playable or signed
artifact. Arbitrary build methods and unvalidated paths turn an editor automation tool into general
code execution.

## In practice here

Allowlist build methods and targets, require an explicit output directory, refuse path traversal and
overwrites by default, capture logs, enforce a timeout, and verify the produced artifact. Separate
build-from-source from upload/release, require confirmation for external side effects, and preserve
the exact Unity version, profile, commit, and arguments used.
