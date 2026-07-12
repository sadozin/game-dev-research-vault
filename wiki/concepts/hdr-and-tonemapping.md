---
title: HDR and tone mapping
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[unity-render-pipelines-tonemapping]]"
tags: [game-development, rendering, color]
---

# HDR and tone mapping

HDR rendering preserves a wider range of scene light values before tone mapping converts them for a
display’s output range.

## Why it works

Bright sources can remain bright during lighting and exposure; a tone curve compresses that range into
displayable values while controlling highlight rolloff and contrast.

## The catch

Tone mapping is not a universal “cinematic” filter. Exposure, UI composition, bloom, and display
calibration change its result; clipping or double conversion destroys the benefit of HDR.

## In practice

Keep scene and display transforms explicit, place UI in the intended color space, and evaluate curves
with luminance ramps and bright gameplay cases.

