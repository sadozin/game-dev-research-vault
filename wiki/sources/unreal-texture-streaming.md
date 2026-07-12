---
title: "Source: Unreal Engine — Texture Streaming Overview"
type: source
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "https://dev.epicgames.com/documentation/en-us/unreal-engine/texture-streaming-overview-for-unreal-engine"
tags: [source, unreal, optimization, textures]
---

# Source: Unreal Engine — Texture Streaming Overview

- **Author:** Epic Games (Unreal Engine documentation)
- **Published:** Unreal Engine 5 documentation
- **URL:** https://dev.epicgames.com/documentation/en-us/unreal-engine/texture-streaming-overview-for-unreal-engine
- **Also:** https://dev.epicgames.com/documentation/unreal-engine/texture-streaming-metrics-in-unreal-engine
- **Retrieved:** 2026-07-11

## Summary

Unreal's streamer decides how much of each texture to keep resident by asking what resolution would
give a good texel-per-pixel ratio. It derives that from the world bounds and texel world sizes of
each primitive component, and factors in whether the component is actually visible—so the wanted mip
level is a function of how large the surface appears on screen, not of a hand-authored distance.

The pool is a hard ceiling, and the interesting behaviour is what happens at it. The streamer first
computes the resolutions it *wants*, then checks whether the streaming memory pool can hold them; if
it cannot, it **reduces planned quality, dropping one mip at a time, until the plan fits under
budget**. Degradation is therefore graceful and global rather than a failure of one asset—the whole
scene gets slightly blurrier. What gets sacrificed follows a retention order: landscape,
forced-resident, and already-degraded textures are protected first, then mips visible on screen, then
character textures and cheap assets, and finally invisible mips (most-recently-seen last to go).
Some textures are marked fully resident and never stream at all.

This is the machinery behind the familiar editor warning that the texture streaming pool is over
budget: it means the wanted set exceeded the pool, so the engine is already dropping mips to cope.
The pool size is configurable (`r.Streaming.PoolSize`, settable in `DefaultEngine.ini` under
`[/Script/Engine.RendererSettings]`), and defaults in relation to available VRAM. Raising it is the
tempting fix and the wrong first move—it buys resolution with memory the platform may not have;
reducing texture sizes and import resolutions addresses the cause. `stat streaming` reports the
pool metrics needed to tell which situation you are in.

## Compiled into

- [[mipmapping-and-texture-streaming]] — screen-size-driven mip selection and drop-one-mip-at-a-time
  budget behaviour
