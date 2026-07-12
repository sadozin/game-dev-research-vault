---
title: Tweening and easing
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[gameplay-motion-and-architecture]]"
tags: [game-development, animation, ui]
---

# Tweening and easing

Tweening interpolates a value over time; easing shapes the interpolation’s rate to communicate weight,
response, or emphasis.

## Why it works

Reusable curves make UI, camera, and gameplay transitions readable without hand-authoring every frame.
Composing sequences also keeps timing intent visible.

## The catch

Tweens can fight authoritative state, accumulate on repeated triggers, or complete after their target
has been destroyed. Easing that feels good for UI may make gameplay timing ambiguous.

## In practice

Give tweens ownership and cancellation, use unscaled time only deliberately, and make completion
callbacks safe when interrupted or replayed.

