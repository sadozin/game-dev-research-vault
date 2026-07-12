---
title: Unity IL2CPP and AOT
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[unity-platform-localization-diagnostics]]"
tags: [game-development, unity, platforms]
---

# Unity IL2CPP and AOT

IL2CPP converts managed assemblies to C++ and native platform code, providing an ahead-of-time player
runtime rather than a JIT-dependent deployment.

## Why it works

AOT compilation supports platforms that restrict runtime code generation and can produce native builds
with predictable deployment behavior.

## The catch

Reflection, generic code paths, native plugins, stripping, and platform toolchains expose failures that
may not appear in the editor or Mono backend.

## In practice

Test IL2CPP early, preserve reflected types deliberately, inspect stripping reports, and treat native
crash symbols and platform SDKs as part of the build artifact.

