---
title: "Source: Unity platform, localization, and diagnostics documentation"
type: source
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "https://docs.unity3d.com/Manual/com.unity.localization.html"
  - "https://docs.unity3d.com/Manual/IL2CPP.html"
  - "https://docs.unity3d.com/Manual/webgl.html"
  - "https://docs.unity3d.com/Manual/iphone-crash-reporting.html"
tags: [source, game-development, unity, platforms]
---

# Source: Unity platform, localization, and diagnostics documentation

- **Author:** Unity Technologies
- **Published:** continuously maintained documentation
- **URL:** https://docs.unity3d.com/Manual/IL2CPP.html
- **Retrieved:** 2026-07-11

## Summary

Unity’s Localization package separates locale data from gameplay, while IL2CPP and WebGL impose AOT,
managed-code, threading, and browser constraints. Mobile builds add thermal, memory, and battery
limits; crash diagnosis depends on platform logs and symbols. These are deployment contracts, not
editor-only settings, and should be tested on representative devices.

## Compiled into

- [[unity-localization-package]]
- [[unity-il2cpp-and-aot]]
- [[unity-webgl-limits]]
- [[unity-mobile-optimization]]
- [[unity-crash-and-log-diagnostics]]

