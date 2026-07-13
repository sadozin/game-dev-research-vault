---
title: "Source: Unity rendering paths and anti-aliasing"
type: source
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "https://docs.unity3d.com/Manual/render-pipelines.html"
tags: [source, game-development, rendering, optimization]
---

# Source: Unity rendering paths and anti-aliasing

- **Author:** Unity Technologies
- **Published:** continuously maintained documentation
- **URL:** https://docs.unity3d.com/Manual/render-pipelines.html
- **Retrieved:** 2026-07-11

## Summary

Unity documents forward and deferred pipeline choices as workload decisions: deferred rendering
stores material and geometric information before lighting, while forward rendering shades visible
objects during submission. Anti-aliasing methods trade edge quality, temporal stability, bandwidth,
and transparency support. The exact options vary by render pipeline and version.

## Compiled into

- [[anti-aliasing-techniques]]
- [[deferred-vs-forward-rendering]]

