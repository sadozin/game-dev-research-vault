---
title: VRChat Avatar Shaders
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[vrchat-android-content-optimization]]"
  - "[[vrchat-avatar-optimization-tips]]"
tags: [game-development, vrchat, shaders, avatars, optimization]
---

# VRChat Avatar Shaders

An avatar shader controls how VRChat's avatar materials render color, lighting, outlines, emission,
transparency, and surface detail. Shader choice is both an artistic decision and a platform budget:
PC and Android/Quest do not expose the same shader capabilities.

## Why it works

Material features can be authored as shader variants and packed texture inputs, allowing one mesh to
support toon response, normal detail, emission, and masks. VRChat's mobile shader family narrows that
feature set into variants the Quest hardware can run, while GPU instancing and shared materials reduce
repeated setup and draw overhead.

## The catch

Android avatars are restricted to VRChat Mobile shaders, and alpha transparency is expensive on mobile
GPUs because of fill rate and sorting. Extra materials, shader keywords, outlines, normal/specular
features, and visible layered surfaces can multiply cost across many avatars. Performance ranks are a
useful warning signal but are static estimates and do not capture every shader or texture cost.

## In practice here

Choose opaque or cutout materials where possible, use the simplest variant that preserves the look,
enable GPU instancing, and test the actual Quest/Android build. Keep PC-only effects in a deliberate
fallback path, minimize material slots and mesh count, and inspect both shader blocking behavior and
frame timing rather than relying only on the avatar rank.
