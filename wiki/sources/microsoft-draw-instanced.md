---
title: "Source: Microsoft — DrawIndexedInstanced"
type: source
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "https://learn.microsoft.com/en-us/windows/win32/api/d3d11/nf-d3d11-id3d11devicecontext-drawindexedinstanced"
tags: [source, game-development, optimization, rendering, graphics-api]
---

# Source: Microsoft — DrawIndexedInstanced

- **Author:** Microsoft
- **Published:** 2024-02-22 (last updated)
- **URL:** https://learn.microsoft.com/en-us/windows/win32/api/d3d11/nf-d3d11-id3d11devicecontext-drawindexedinstanced
- **Retrieved:** 2026-07-11

## Summary

Direct3D 11's indexed instanced draw takes an index count per instance and a separate instance
count, then reuses the indexed mesh for each copy. Microsoft describes the usual arrangement as
separate per-vertex and per-instance buffers: the latter carries data such as transforms or colors,
with the input layout marking it as per-instance data. The API makes the mechanism explicit and
engine-independent: instancing is geometry reuse plus an instance-data stream, not a promise that
all rendering work becomes free.

## Compiled into

- [[gpu-instancing]] — the underlying draw-call and per-instance-buffer mechanism
