---
title: Overdraw and transparency cost
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[unreal-transparency-overdraw]]"
  - "[[unreal-shader-complexity-view]]"
tags: [game-development, optimization, rendering, performance]
---

# Overdraw and transparency cost

Overdraw is the repeated shading of the same screen pixels when transparent, particle, foliage, or
layered surfaces overlap. Opaque geometry can often reject hidden fragments with depth testing; blended
transparency usually must shade and combine each layer, so cost grows with screen coverage and overlap.
It is a fill-rate and pixel-shader problem, distinct from the CPU submission problem in
[[draw-call-batching]].

## Why it works

Each transparent layer reads the destination and blends its result into it. A stack of six full-screen
particles can therefore execute the material six times over the same pixels, and lit transparency adds
more instructions and texture work per pass. The useful diagnostic is screen-space coverage: shader
complexity or quad-overdraw visualization makes expensive overlap visible even when object counts look
small.

## The catch

Overdraw is not proportional to particle count alone. A thousand tiny, cheap sparks may cost less than
one full-screen translucent quad with a complex material. Masking can recover depth rejection but
introduces hard cutouts and still costs the shader for covered samples. Sorting, refraction, soft
particles, reflections, and multiple render passes can make transparency more expensive than its
material graph suggests. Reducing overdraw can also change the intended softness or layering of an
effect, so the fix is a visual tradeoff as well as a performance one.

## In practice here

Profile GPU time and inspect shader-complexity or quad-overdraw views on the target resolution. Reduce
screen coverage first: shrink or split large quads, lower particle counts by scalability tier, use
masked materials where the look permits, and simplify translucent shaders. Check the result in motion,
not only from a static editor camera; camera alignment and effects stacking determine the worst case.
Use [[game-performance-profiling]] to confirm that the bottleneck is pixel work rather than draw calls
or bandwidth elsewhere.
