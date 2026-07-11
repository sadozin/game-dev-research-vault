---
title: "Source: VRChat — avatar performance ranks"
type: source
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "raw/vrchat-avatar-performance-ranks.md"
tags: [source, vrchat, optimization]
---

# Source: VRChat — avatar performance ranks

- **Author:** VRChat
- **Published:** Creator documentation
- **URL:** https://creators.vrchat.com/avatars/avatar-performance-ranking-system/
- **Retrieved:** 2026-07-11
- **Raw:** `raw/vrchat-avatar-performance-ranks.md` (provenance only)

## Summary

VRChat ranks avatars from their triangle and texture-memory cost, renderer and material-slot
counts, bones, animators, PhysBones, contacts, and constraints. Users can configure a minimum
displayed rank, which can replace an over-budget avatar with a fallback or strip expensive avatar
features. Disabled components still count toward the rank.

Mobile has hard component limits: at the retrieved date, eight PhysBone components, 64 affected
transforms, 16 colliders, 64 collision checks, 16 contacts, 150 constraints, and dependency depth
50. Exceeding a mobile component limit removes those limited components even when the avatar is
shown.

## Compiled into

- [[vrchat-avatar-optimization]] — measure the metrics VRChat actually enforces
- [[vrchat-avatar-physics]] — secondary motion constrained by mobile budgets
