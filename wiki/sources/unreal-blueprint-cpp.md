---
title: "Source: Epic — Blueprint versus C++"
type: source
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "raw/unreal-blueprint-cpp.md"
tags: [source, unreal, engine]
---

# Source: Epic — Blueprint versus C++

- **Author:** Epic Games
- **Published:** Unreal Engine 5.6 documentation
- **URL:** https://dev.epicgames.com/documentation/en-us/unreal-engine/coding-in-unreal-engine-blueprint-vs.-cplusplus?application_version=5.6
- **Retrieved:** 2026-07-11
- **Raw:** `raw/unreal-blueprint-cpp.md` (provenance only)

## Summary

Unreal supports pure Blueprint or pure C++ projects, but Epic recommends a mix for many projects:
C++ establishes systems, performance-sensitive code, lower-level access, and text-based
collaboration; Blueprint provides faster, visual iteration for behavior and content. Blueprint
overhead matters most in tight loops, large data processing, and many ticking instances, where
profiling should identify the actual bottleneck before converting logic.

## Compiled into

- [[unreal-engine-workflow]] — C++ foundation with Blueprint extension
- [[game-engine-selection]] — compare engine and team fit
