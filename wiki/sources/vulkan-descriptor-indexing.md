---
title: "Source: Khronos — VK_EXT_descriptor_indexing"
type: source
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "https://docs.vulkan.org/guide/latest/extensions/VK_EXT_descriptor_indexing.html"
tags: [source, game-development, optimization, rendering, textures, vulkan]
---

# Source: Khronos — VK_EXT_descriptor_indexing

- **Author:** Khronos Group
- **Published:** Undated (current Vulkan Guide; descriptor indexing promoted to Vulkan 1.2)
- **URL:** https://docs.vulkan.org/guide/latest/extensions/VK_EXT_descriptor_indexing.html
- **Retrieved:** 2026-07-11

## Summary

Khronos documents descriptor indexing as a collection of separately queryable features rather than a
single switch. Runtime-sized and partially bound arrays allow a large texture table without filling
every slot, update-after-bind changes when descriptors may be edited, and dynamic non-uniform indexing
allows different shader invocations to choose different descriptors. The shader must mark genuinely
non-uniform indices, and the application must enable the matching device features and descriptor-set
binding flags.

## Compiled into

- [[bindless-textures]] — descriptor arrays, non-uniform indexing, and feature/lifetime constraints
