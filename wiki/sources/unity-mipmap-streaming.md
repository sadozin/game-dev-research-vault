---
title: "Source: Unity — The Mipmap Streaming system"
type: source
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "https://docs.unity3d.com/2023.2/Documentation/Manual/TextureStreaming.html"
tags: [source, unity, optimization, textures]
---

# Source: Unity — The Mipmap Streaming system

- **Author:** Unity Technologies
- **Published:** Unity Manual (2023.2; the system dates to Unity 2018.2)
- **URL:** https://docs.unity3d.com/2023.2/Documentation/Manual/TextureStreaming.html
- **Also:** https://docs.unity3d.com/Manual/TextureStreaming.html
- **Retrieved:** 2026-07-11

## Summary

Mipmap Streaming forces Unity to load only the mipmap levels needed to render the current camera
position instead of loading every level by default. Unity frames the bargain explicitly: it trades a
small amount of CPU to save a potentially large amount of GPU memory, and cites its Viking Village
demo saving roughly 25–30% of texture memory.

The control is a **Memory Budget** in Quality Settings—a ceiling on texture memory, not a target. As
the budget fills, Unity discards mipmaps it does not currently need to make room for ones it does. If
the budget is set too small, the consequence is visible rather than fatal: textures render at lower
resolution than intended, or load in late and pop. A second setting, **Max Level Reduction**, caps
how many mip levels Unity may drop, and the manual notes Unity **prioritises Max Level Reduction over
the memory budget**—so the two can conflict, and the reduction limit wins. To size the budget, Unity
suggests reading `Texture.desiredTextureMemory` (the memory the loaded textures actually want) and
setting the budget slightly above it.

The limitations matter more than the feature, because each is a silent full-resolution fallback
rather than an error. Unity does not stream: **terrain textures**, which must stay at full resolution
so the engine can tile and blend them; **meshes lacking UV distribution metrics**, so procedurally
generated meshes need a manual `Mesh.RecalculateUVDistributionMetrics()` call; **textures drawn
through direct graphics API calls** such as `Graphics.DrawMeshNow`, where the mip level must be set
by hand; **non-standard renderers**—decal projectors, reflection probes, and shaders sampling with
coordinates other than UV0—which require assigning `requestedMipmapLevel` manually; and **shaders
with animated UVs**, beyond simple scale and translation. Anything in that list keeps every mip
resident regardless of the budget.

## Compiled into

- [[mipmapping-and-texture-streaming]] — the budget-as-ceiling model and the unstreamable cases
