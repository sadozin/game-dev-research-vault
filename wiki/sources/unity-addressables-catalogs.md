---
title: "Source: Unity — Addressables content catalogs"
type: source
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "https://docs.unity3d.com/kr/Packages/com.unity.addressables%401.21/manual/build-content-catalogs.html"
tags: [source, game-development, unity, assets, streaming]
---

# Source: Unity — Addressables content catalogs

- **Author:** Unity Technologies
- **Published:** Addressables 1.21.17 documentation
- **URL:** https://docs.unity3d.com/kr/Packages/com.unity.addressables%401.21/manual/build-content-catalogs.html
- **Retrieved:** 2026-07-11

## Summary

Unity's catalog documentation explains that a catalog maps Addressables keys to asset locations and
dependencies. A remote catalog and hash let a player detect and cache changed content; catalog updates
can block other Addressables requests while they run. Unity also warns that updating a catalog while
old bundles are loaded can create conflicts, making bundle identity, handle release, and content-update
planning part of the runtime design.

## Compiled into

- [[unity-addressables]] — catalogs, cache updates, blocking behavior, and loaded-bundle hazards
