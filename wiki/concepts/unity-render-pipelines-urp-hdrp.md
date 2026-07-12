---
title: Unity render pipelines URP and HDRP
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[unity-render-pipelines-tonemapping]]"
tags: [game-development, unity, rendering]
---

# Unity render pipelines URP and HDRP

Unity render pipelines package different rendering features and scalability assumptions behind a
project-wide rendering architecture.

## Why it works

URP targets a broad range of hardware with a configurable forward-oriented feature set; HDRP exposes
more high-end lighting, materials, and volumetric tools. A pipeline makes defaults and extension
points consistent across a project.

## The catch

Migration is not a material checkbox: shaders, lighting, post-processing, custom passes, and assets
may need conversion. Choosing by screenshot quality can ignore target bandwidth and GPU capability.

## In practice

Choose from shipping platforms and required features first, then prototype representative scenes before
committing content production.

