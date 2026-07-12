---
title: Unreal Lumen
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[unreal-lumen-global-illumination]]"
  - "[[unreal-lumen-technical-details]]"
tags: [game-development, unreal, rendering, lighting, optimization]
---

# Unreal Lumen

Lumen is Unreal Engine's fully dynamic global-illumination and reflection system. It computes
diffuse bounce lighting and indirect specular reflections across large environments without a
lightmap-baking workflow, making it useful for moving lights, time of day, and destructible scenes.

## Why it works

Lumen combines screen traces with software or hardware ray tracing, a representation of scene
surfaces, and temporal accumulation. Software tracing can use mesh distance fields; hardware tracing
can use the platform's ray-tracing hardware. The system can therefore trade detail, compatibility,
and cost across scalability levels while keeping indirect lighting and reflections coherent with the
same dynamic scene.

## The catch

Dynamic lighting is paid for every frame. Lumen is aimed at high-end PCs and current consoles, and
its quality settings directly affect GPU time. Screen traces can miss off-screen information, hardware
ray tracing has scene-update costs, and enabling software tracing requires distance fields that add
build time, memory, and disk size. Smooth reflections, translucency, foliage, emissive lights, and
large instance counts each have their own quality or noise limits. Lumen is consequently a rendering
budget decision, not a free replacement for baked lighting or reflection captures.

## In practice here

Choose Lumen when the project needs dynamic indirect light and the target hardware can afford it.
Benchmark representative interiors, exteriors, camera cuts, translucent materials, foliage, and
emissive signage at the shipping resolution. Set global-illumination and reflection scalability from
the measured frame budget, inspect the Lumen visualization modes and GPU captures, and keep baked
lighting, reflection captures, or simpler screen-space methods as deliberate alternatives for lower
tiers and unsupported platforms. Coordinate geometry and lighting budgets with [[unreal-nanite]] and
[[platform-memory-budgets]].
