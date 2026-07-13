---
title: Unity MCP Test and Playmode
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[unity-test-framework-edit-and-playmode]]"
  - "[[mcp-tools-test-confirmation]]"
tags: [game-development, unity, mcp, testing, editor]
---

# Unity MCP Test and Playmode

An MCP test tool for Unity should expose deterministic test discovery, explicit Edit Mode or Play Mode
selection, bounded execution, and machine-readable results. It should help an agent verify a scene or
change without granting an uncontrolled “press Play and inspect anything” capability.

## Why it works

Unity Test Framework separates Edit Mode tests from Play Mode tests and can emit XML results. An MCP
server can list available tests, run a selected set on a disposable or named scene, collect logs and
artifacts, and return pass/fail details. This gives scene-authoring tools a feedback loop that is more
reliable than visual confidence alone.

## The catch

Play Mode changes time, scene state, domain reload behavior, and external services; tests can leak state
or become order-dependent. Running arbitrary tests may mutate assets or take unbounded time, and a green
test result does not prove rendering, performance, or platform behavior. A tool must also distinguish a
test failure from a runner crash or timeout.

## In practice here

Require a test scope and timeout, run in a clean or explicitly named scene, capture structured results,
and restore the editor state afterward. Prefer focused Edit Mode tests for pure asset logic and Play
Mode tests for lifecycle and runtime behavior. Surface logs, failed assertions, and runner status to the
agent, then require human approval before destructive or long-running suites.
