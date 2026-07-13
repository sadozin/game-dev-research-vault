---
title: Platform memory budgets
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[microsoft-video-memory-budget]]"
  - "[[unreal-texture-memory-pools]]"
tags: [game-development, optimization, memory, rendering]
---

# Platform memory budgets

A platform memory budget is the working-set ceiling a game should stay under for a resource class,
especially GPU-local and shared video memory. It is not the same as the hardware's advertised VRAM:
the operating system, other applications, render targets, buffers, textures, streaming slack, and
driver allocations all compete for the usable portion. [[pool-warmup-and-budgeting]] and
[[mipmapping-and-texture-streaming]] are ways to spend that budget deliberately rather than discover
the limit through hitching.

## Why it works

Budgeting turns a fluctuating memory pool into an allocation plan. Reserve space for stable costs such
as the renderer and render targets, then divide the remainder among textures, meshes, effects, audio,
and streaming headroom. A streamer can lower mip residency or evict cached data when demand rises;
Unreal's texture streamer models this as texture, streaming, wanted, temporary, and safety pools.
On Windows, DXGI exposes an OS-provided process budget and current usage so an engine can react to
pressure instead of treating total VRAM as available.

## The catch

One global number is misleading. Budgets change with resolution, display mode, other processes,
device memory pressure, scene visibility, and transient upload or resize allocations. A texture pool
that is technically full may still thrash if it has no safety or temporary pool, while a pool set too
high can evict unrelated resources or trigger OS paging. Dropping texture mips fixes one class of
pressure but cannot hide oversized render targets, buffers, or non-streamable assets. Memory numbers
from the editor are especially poor evidence for a shipping build.

## In practice here

Measure peak usage on representative target devices and scenes, record stable and transient categories
separately, and leave explicit headroom for streaming and loading. Set texture and mesh policies from
the smallest supported device upward; do not let the highest-end machine define the budget. Use
[[game-performance-profiling]] to capture peaks and hitch correlation, then tune
[[vrchat-avatar-optimization]] and texture residency against the same budget. Treat an over-budget
frame as a correctness issue—stutter and paging are user-visible failures, not merely an optimization
warning.
