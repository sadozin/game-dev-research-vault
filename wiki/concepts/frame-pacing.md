---
title: Frame pacing
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[unity-profiling-target-device]]"
  - "[[android-game-optimization]]"
tags: [game-development, optimization, rendering]
---

# Frame pacing

Frame pacing is the consistency with which completed frames reach the display. A game with a high
average frame rate can still feel bad when a few late frames miss a display interval and remain
on screen for an extra refresh period.

## Why it works

Set a frame-time budget from the display target—16.67 ms at 60 Hz, 33.33 ms at 30 Hz—and measure
the distribution, especially long-tail frames. Trace where late frames originate: main-thread
work, render-command submission, GPU saturation, locks, I/O, allocation, or queueing. Align game
and render work so the CPU does not routinely wait for the GPU, and reduce the proven bottleneck
rather than blindly uncapping FPS.

On mobile, presentation queues and thermal limits make this especially visible; platform frame
pacing support can synchronise swaps with display timing. The universal lesson is to target a
sustainable, consistent cadence rather than transient peak throughput.

## The catch

Parallelising work only helps when dependencies and command submission are designed for it.
Moving all simulation, loading, and rendering onto one thread may be simple, but it converts a
multicore machine into a serial frame-time limit. Conversely, adding threads without a trace can
create lock contention and worse spikes.

## In practice here

The Vulkan desktop client in [[minecwaft]] should treat frame-time spikes while entering chunks as
a frame-pacing problem first, then use [[game-performance-profiling]] to identify whether the
per-frame build budget, mesh generation, allocations, or GPU work is responsible.
