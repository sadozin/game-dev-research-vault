---
title: Real-time lighting budget
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[unity-lighting-workflow]]"
tags: [game-development, 3d, lighting, rendering]
---

# Real-time lighting budget

A lighting budget decides which visual effects must react at runtime and which can be precomputed. The choice is architectural: it determines scene authoring, memory use, runtime cost, and how moving objects receive light.

## Why it works

Classify every lighting need before tuning individual lights. Baked global illumination is suited to stable geometry and provides inexpensive indirect light at runtime. Realtime lighting supports changing time, light sources, and geometry at a higher ongoing cost. Mixed lighting reserves dynamic behavior for the elements that need it while baking stable contribution. Reflection probes support environment reflections, while light probes provide indirect-light samples for moving objects in a baked scene.

## The catch

Baking is not a generic quality switch: dynamic and destructible content can invalidate its assumptions, and moving objects need probe data or they will not visually belong in a baked environment. Conversely, making every light realtime spends GPU budget continuously. Pick the GI strategy, light mode, and probe plan together, then test the player-facing day/night and traversal scenarios on target hardware.

## In practice here

[[minecwaft]] has generated terrain, edits, and a changing time of day. Treat the sun, ambient response, water highlights, and underwater effects as dynamic rendering concerns; do not assume a static lightmap can serve the world. If authored interiors or fixed structures are added later, evaluate localized baked data separately rather than applying it to the procedural world wholesale.
