---
title: Unreal C++ gameplay basics
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "https://dev.epicgames.com/documentation/en-us/unreal-engine/programming-with-cplusplus-in-unreal-engine"
tags: [game-development, unreal, programming]
---

# Unreal C++ gameplay basics

Unreal C++ gameplay combines ordinary C++ with reflected classes, properties, functions, components,
and engine lifecycle conventions.

## Why it works

Reflection exposes selected types to the editor, serialization, networking, and Blueprints while C++
provides control over performance and reusable systems.

## The catch

Reflected objects have ownership, garbage collection, module, and header-tool constraints beyond normal
C++. Incorrect lifetime or property metadata can compile yet fail in editor, cook, or replication.

## In practice

Keep reflected boundaries intentional, follow engine ownership rules, and test editor, packaged, and
networked builds rather than relying on native compilation alone.

