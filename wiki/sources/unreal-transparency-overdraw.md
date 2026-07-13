---
title: "Source: Epic — Using Transparency in Unreal Engine Materials"
type: source
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "https://dev.epicgames.com/documentation/unreal-engine/using-transparency-in-unreal-engine-materials?lang=en-US"
tags: [source, game-development, optimization, rendering, unreal]
---

# Source: Epic — Using Transparency in Unreal Engine Materials

- **Author:** Epic Games
- **Published:** Undated (Unreal Engine 5.8 documentation)
- **URL:** https://dev.epicgames.com/documentation/unreal-engine/using-transparency-in-unreal-engine-materials?lang=en-US
- **Retrieved:** 2026-07-11

## Summary

Epic identifies overdraw as the performance problem created when transparent objects render over one
another. Lit transparency becomes especially costly because every additional overlapping layer adds
more rendering work. Unreal's Shader Complexity view colors expensive regions, making overlap visible
as objects move into the same line of sight. The guidance treats some overdraw as unavoidable but makes
measurement part of the material workflow.

## Compiled into

- [[overdraw-and-transparency-cost]] — layered pixel cost and the shader-complexity diagnostic
