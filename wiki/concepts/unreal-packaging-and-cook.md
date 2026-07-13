---
title: Unreal packaging and cook
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[unreal-build-profiling-and-platforms]]"
tags: [game-development, unreal, build]
---

# Unreal packaging and cook

Unreal packaging builds code, cooks content, stages outputs, and bundles a target-platform distribution.

## Why it works

Cooking converts editor assets to runtime formats and can exclude unused content; staging and packaging
make the exact files to test or ship visible.

## The catch

Editor availability is not proof that an asset will cook. References, platform variants, plugins,
chunks, and build configuration can produce missing content or a build that only works locally.

## In practice

Test packaged builds in CI and on target devices, audit cooked content, and keep build/cook/package
steps separately observable.

