---
title: Unity Timeline and Cinemachine
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[unity-editor-and-rendering-systems]]"
tags: [game-development, unity, cinematics]
---

# Unity Timeline and Cinemachine

Timeline sequences time-based clips and signals; Cinemachine supplies reusable camera behaviors and
blends.

## Why it works

Directable tracks let designers author cutscenes, camera composition, animation, audio, and gameplay
signals on a shared timeline while camera logic remains reusable.

## The catch

Signals and bindings are hidden dependencies. Runtime interruptions, skipped sequences, and multiple
camera authorities can leave state or blends behind.

## In practice

Make sequence entry and exit idempotent, define binding ownership, test skip/rewind paths, and keep
gameplay-critical state outside a cinematic asset.

