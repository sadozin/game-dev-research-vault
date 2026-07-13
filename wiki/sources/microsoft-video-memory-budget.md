---
title: "Source: Microsoft — QueryVideoMemoryInfo"
type: source
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "https://learn.microsoft.com/en-us/windows/win32/api/dxgi1_4/nf-dxgi1_4-idxgiadapter3-queryvideomemoryinfo"
tags: [source, game-development, optimization, memory, directx]
---

# Source: Microsoft — QueryVideoMemoryInfo

- **Author:** Microsoft
- **Published:** 2024-02-22 (last updated)
- **URL:** https://learn.microsoft.com/en-us/windows/win32/api/dxgi1_4/nf-dxgi1_4-idxgiadapter3-queryvideomemoryinfo
- **Retrieved:** 2026-07-11

## Summary

DXGI's `QueryVideoMemoryInfo` reports the process's current video-memory budget and usage for local
or non-local memory segments. Microsoft explicitly says applications must manage physical memory
within the assigned budget: exceeding it can cause stuttering while the operating system pages work
to make room for other processes. The companion interface can notify an application when the budget
changes, so a renderer can adapt instead of assuming a fixed VRAM ceiling.

## Compiled into

- [[platform-memory-budgets]] — the difference between advertised VRAM and an OS-managed process budget
