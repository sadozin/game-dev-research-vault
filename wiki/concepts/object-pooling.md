---
title: Object pooling
type: concept
status: active
created: 2026-07-12
updated: 2026-07-12
verified: 2026-07-12
sources:
  - "[[nystrom-object-pool]]"
  - "[[unity-object-pooling]]"
tags: [game-development, optimization, performance, memory]
---

# Object pooling

Object pooling reuses a fixed or bounded set of instances instead of allocating and freeing the same
kind of object over and over. Projectiles, hitsparks, short-lived enemies, and temporary lists are
classic cases: only a few are “alive” at once, but create/destroy traffic would otherwise hammer the
allocator and, in managed runtimes, the garbage collector. It is a neighbour of
[[game-performance-profiling]]—an answer to allocation stalls and spawn-rate CPU cost once those
costs are measured, not a default for every entity.

## Why it works

Construction and teardown are expensive beyond the bytes of the object: engines wire components,
register physics, wake renderers, and may run constructors and finalizers. Destroying managed
objects defers cleanup to GC, which can stall a frame later and hurt [[frame-pacing]]. A pool
pre-creates instances (or grows to a cap), marks them free or in use, and on spawn returns a free
one after a cheap reset; on despawn it deactivates and returns the instance to the free set.

Growth policy matters. A fixed pool fails closed when exhausted (refuse spawn, or steal oldest).
A growable pool with a max size creates on empty and destroys on over-capacity release. Either way,
amortise creation at load or quiet moments so combat does not pay first-touch spikes. Pools apply
to more than GameObjects: temporary `List`/`Dictionary` helpers that would otherwise allocate every
frame belong in the same pattern.

## The catch

Reused objects keep state. Position, velocity, health, timers, animation, particles, coroutines,
event subscriptions, and parent transforms must be reset on get or release—or the next spawn
inherits last frame’s life. Double-release and use-after-release bugs are common; development-time
collection checks help. Idle pool capacity is resident memory: oversized pools trade GC for RAM
and load cost. Pooling does nothing useful for long-lived unique objects or rare spawns, and the
extra lifecycle code is a frequent source of subtle bugs when applied without a profiler signal.

## In practice here

During [[game-performance-profiling]], if spawn/despawn or GC.Alloc spikes line up with projectiles,
VFX, or chunk entity churn, introduce a pool for that type only: size from peak concurrent need plus
margin, reset fully on release, and measure worst-frame time again. Prefer engine pool APIs where
they exist so create/get/release/destroy hooks stay explicit. Do not pool “everything” as a style
rule—confirm the allocation or instantiate cost first.
