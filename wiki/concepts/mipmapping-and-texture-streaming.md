---
title: Mipmapping and texture streaming
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[unity-mipmap-streaming]]"
  - "[[unreal-texture-streaming]]"
tags: [game-development, optimization, rendering, textures, memory]
---

# Mipmapping and texture streaming

A mipmap chain is a texture stored at every halving of its resolution, so the GPU can sample a size
that roughly matches how large the surface actually appears on screen. Texture streaming is the
system that then keeps only the levels currently needed in memory and leaves the rest on disk.
Mipmapping is what makes distant surfaces look right; streaming is what makes a project's texture
memory bounded. They are one topic because streaming is only possible *because* the chain exists—the
mip level is the unit a streamer adds and drops.

## Why it works

Without mipmaps, a surface squeezed into few pixels forces the sampler to take sparse point samples
of a large texture, and the result shimmers and crawls as the camera moves—minification aliasing.
Sampling a pre-filtered smaller level instead gives a stable, correctly averaged result, and it is
faster: the smaller level is likelier to be in cache, so mipmapping usually *improves* throughput on
distant geometry rather than costing it. The whole chain adds only about a third to a texture's size,
since each level is a quarter of the last and the series 1 + 1/4 + 1/16 + … converges to 4/3.

Streaming exploits the fact that a scene almost never needs the top level of every texture at once.
Both major engines choose the wanted level from apparent size on screen: Unreal computes what
resolution yields a good texel-per-pixel ratio from each component's world bounds and texel sizes,
and factors in visibility; Unity's Mipmap Streaming loads only the levels needed for the current
camera. The result is memory proportional to what is *visible and close*, not to what exists in the
level, which is what allows a world with far more texture data than VRAM to run at all. Unity frames
the trade honestly—a little CPU to save a lot of GPU memory—and reports 25–30% texture-memory savings
in its own demo scene.

## The catch

The budget is a ceiling, not a promise, and both engines degrade rather than fail. Unreal computes
the resolutions it wants and, if the pool cannot hold them, drops one mip at a time until the plan
fits—so an over-budget pool does not crash, it quietly makes the entire scene blurrier, which is
exactly what the familiar "texture streaming pool over budget" warning is telling you has already
happened. Unity behaves the same way: too small a Memory Budget yields textures that render at lower
resolution or pop in late. Raising the pool size is therefore the tempting fix and usually the wrong
first move—it buys resolution with memory the platform may not have, whereas reducing source
resolutions addresses the cause.

The sharper trap is that the unstreamable cases fail *silently and expensively*, staying fully
resident while you believe they are streaming. Unity does not stream terrain textures (they must be
full-resolution to tile and blend), meshes without UV distribution metrics (procedural meshes need
`Mesh.RecalculateUVDistributionMetrics()`), textures drawn through direct API calls, decal projectors
and reflection probes, shaders sampling on anything but UV0, and shaders with animated UVs beyond
simple scale and translation. A project can enable streaming, see memory barely move, and be looking
at precisely the assets on that list. Unity adds a second-order surprise: **Max Level Reduction**
caps how many levels may be dropped, and Unity prioritises it *over* the memory budget—so a
conservative reduction limit can hold memory above the ceiling you thought you set.

Streaming also converts a memory problem into a bandwidth-and-latency problem. Levels must arrive
before they are seen, so a fast camera cut, a teleport, or a door opening onto a new vista can
out-run the streamer and show visible pop-in; this is a [[frame-pacing]] concern as much as a memory
one, since the loads compete with the frame.

## In practice here

Keep mipmaps on for anything sampled in 3D—switching them off to save that ~33% is a false economy
that trades a small memory win for shimmering and worse cache behaviour. The exception is textures
that are never minified: screen-aligned UI and sprites drawn at native size gain nothing from a
chain, which is the same reasoning that lets [[texture-atlasing]] pack UI without mip padding.

Size the budget from measurement rather than instinct—Unity exposes `Texture.desiredTextureMemory`
(what the loaded textures actually want) as the number to set the budget slightly above, and Unreal's
`stat streaming` reports the pool metrics. When [[game-performance-profiling]] shows texture memory
as the constraint, work the causes in order: cut source resolutions, then check that the heavy assets
are actually streamable, and only then consider enlarging the pool. Note that the streamable/
non-streamable split interacts with how textures are packed—a terrain built on [[texture-arrays-vs-atlases]]
inherits terrain's full-residency rule, so the memory won by arraying it does not come back through
streaming.
