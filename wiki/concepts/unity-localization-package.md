---
title: Unity Localization package
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[unity-platform-localization-diagnostics]]"
tags: [game-development, unity, localization]
---

# Unity Localization package

Unity Localization stores localized strings, assets, locales, and smart formatting as data-driven
tables rather than hardcoded text.

## Why it works

Locale selection, fallback, pluralization, and asset variants can be managed consistently across UI,
dialogue, textures, and audio.

## The catch

Text expansion, missing keys, font coverage, right-to-left layout, and asynchronous table loading can
break a UI that looked correct in the source language.

## In practice

Validate keys in builds, test long and translated strings early, use stable identifiers, and treat
locale changes as asynchronous state transitions.

