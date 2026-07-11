---
title: "Source: VRChat — rig requirements"
type: source
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "raw/vrchat-rig-requirements.md"
tags: [source, vrchat, rigging]
---

# Source: VRChat — rig requirements

- **Author:** VRChat
- **Published:** Creator documentation, last updated 2025-05-14
- **URL:** https://creators.vrchat.com/avatars/rig-requirements/
- **Retrieved:** 2026-07-11
- **Raw:** `raw/vrchat-rig-requirements.md` (provenance only)

## Summary

A Humanoid VRChat avatar needs Unity Mecanim mapping for the essential human bones, including
head, hands, and feet. The Hips bone must be an ancestor of the other mapped humanoid bones; split
hierarchies can break IK. Toe mapping is optional but improves tiptoe and automatic foot-placement
appearance, while three mapped finger chains are needed for full IK and gesture behavior.

The page warns that it is significantly out of date. Treat the Unity SDK Build Control Panel's
validation result as the final authority for an actual upload.

## Compiled into

- [[vrchat-humanoid-rigging]] — hierarchy and humanoid validation
- [[vrchat-clothing-workflow]] — garments must follow the same export rig
