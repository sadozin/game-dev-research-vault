---
title: Pool warmup and budgeting
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[unity-object-pool-api]]"
  - "[[unity-learn-object-pooling]]"
  - "[[nystrom-object-pool]]"
tags: [game-development, optimization, performance, memory]
---

# Pool warmup and budgeting

[[object-pooling]] says to reuse instances rather than allocate them; this is the part that decides
*how many* and *when they get made*. A pool has two independent numbers—how many instances exist
before gameplay starts (the warmup) and how many the pool is allowed to keep resident (the
budget)—and getting either wrong reintroduces the very stall the pool was built to remove. An
unwarmed pool pays its instantiate cost on the first burst, in the middle of combat, which is
precisely the frame that could least afford it.

## Why it works

Pooling moves allocation cost in time. The cost does not vanish: constructing an instance, wiring its
components, and registering it with physics and rendering all still happen, and the pool's only real
power is to make them happen when nobody is looking. Warmup is that scheduling decision—pre-create
during a load screen, a level transition, or a quiet moment, so the hot path only ever performs a
cheap "mark this one in use." A pool that creates lazily on demand has merely relocated the spike to
the first time the player fires the gun.

Budgeting is the other half, because a warmed pool is resident memory whether or not anything uses
it. The right size comes from measuring **peak concurrent** use, not total spawns: a projectile fired
600 times a minute but living half a second has perhaps a dozen alive at once, and that peak—plus
headroom—is the pool, while the 600 is irrelevant. Engine pools expose the counters to measure it
directly; Unity's `ObjectPool<T0>` reports `CountActive`, `CountInactive`, and `CountAll`, so
sampling the high-water mark of `CountActive` across representative play *is* the sizing experiment.
Size from that measurement and the pool holds steady: no allocation during play, no memory paid for
instances that never coexist.

## The catch

The parameter that looks like warmup usually is not. In Unity's `ObjectPool<T0>`, `defaultCapacity`
sounds like a preallocation and is not one—the API reference states plainly that instances are not
created at construction but individually when `Get` is called. It sizes the *internal stack's*
backing storage, so a pool declared with a capacity of 200 still contains zero objects and will
instantiate all 200 during the first burst that demands them. Prewarming is something the caller
does explicitly: a loop at init that creates instances and releases them into the pool, exactly as
Unity's own hand-rolled tutorial does with a `Start()` loop, which is why that older tutorial code
warms up correctly while a naive switch to the modern API silently does not.

`maxSize` misleads in the opposite direction: it caps what the pool *retains*, not what can be
alive. `Get` on an empty pool always creates, so a burst beyond the cap still allocates—and those
surplus instances are then destroyed on release rather than kept, so an under-budgeted pool under a
sustained burst degrades into plain allocate/destroy churn *plus* pool bookkeeping, which is worse
than no pool at all. The failure is quiet: throughput looks fine, and only the frame-time graph and
GC show it.

Overshooting has its own bill. Warmup is load time, and a project that prewarms every pool at boot
trades a gameplay hitch for a startup that takes noticeably longer—on memory-constrained platforms,
resident pool memory competes directly with the streaming and texture budgets, so pools sized "just
to be safe" can push the game over a platform memory limit to solve a stall that a profiler never
recorded. Fixed-size pools, as Nystrom notes, buy predictable memory at the price of having to decide
what happens when they run dry: refuse the spawn, or recycle the oldest live instance. Both are
design choices with visible consequences—a bullet that fails to fire, or one that vanishes mid-flight
—and they must be chosen deliberately rather than discovered.

## In practice here

Derive the number, do not guess it: instrument `CountActive` (or the equivalent high-water mark) over
representative play, including the worst case the design permits—the boss that spawns adds, the shotgun,
the wave that overlaps the previous wave—then set the budget at that peak plus margin and the warmup
at the same figure. Prewarm during an existing load or transition where the cost is already hidden;
if the warmup itself is large enough to hitch, spread it across frames rather than moving it into
gameplay.

Then confirm the fix the same way [[object-pooling]] was justified in the first place. Under
[[game-performance-profiling]], a correctly warmed and budgeted pool shows a flat allocation line
during combat; if instantiate spikes still appear, the pool is under-budgeted and quietly churning at
its cap, and if worst-frame time improved but memory regressed past the platform's ceiling, the pool
is oversized. Both are [[frame-pacing]] problems wearing a memory costume, and the counters tell
which one you have.
