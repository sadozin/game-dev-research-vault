---
title: Game performance profiling
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[unity-profiling-target-device]]"
  - "[[android-game-optimization]]"
  - "[[blender-gltf-export]]"
tags: [game-development, optimization, profiling]
---

# Game performance profiling

Game optimisation is a measured loop: reproduce a player-visible problem on the shipping target,
capture enough evidence to identify its limiting subsystem, change one cause, then validate the
same scenario again. It is not a checklist of folklore optimisations.

## Why it works

Start with a fixed scene, camera path, gameplay action, graphics setting, target hardware, and
frame-time goal. Capture CPU, GPU, memory, loading/I/O, and presentation data appropriate to the
question. Classify the bottleneck before editing: CPU-bound work needs less simulation or better
scheduling; GPU-bound work needs less rendering cost; I/O and allocation stalls need a different
fix entirely. Measure on target hardware because editor measurements include editor work and can
both create and hide bottlenecks.

Optimise the largest proven cost first, then repeat the capture. Track median and worst-frame
times, memory high-water mark, load duration, and the affected scene; average FPS alone erases
the spikes a player notices. See [[frame-pacing]] for presentation consistency.

## The catch

Profilers perturb execution. High-detail instrumentation is valuable for a short investigation
but can introduce enough overhead to change the result, so use a broad trace to locate the
problem and narrow instrumentation to explain it. Do not declare success from an editor-only or
single high-end-machine result.

## In practice here

[[minecwaft]] already limits chunk building per frame to avoid traversal hitches. Keep that
decision under measurement: capture chunk-entry and world-save scenarios on the desktop Vulkan
client, then distinguish main-thread simulation, mesh generation, render submission, GPU time,
and allocation pressure before changing the budget. For all Blender work, profile the exported
asset in-game rather than judging the source `.blend` alone.
