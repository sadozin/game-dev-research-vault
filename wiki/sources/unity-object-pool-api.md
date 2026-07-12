---
title: "Source: Unity — ObjectPool<T0> constructor reference"
type: source
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "https://docs.unity3d.com/6000.0/Documentation/ScriptReference/Pool.ObjectPool_1-ctor.html"
tags: [source, unity, optimization, memory]
---

# Source: Unity — ObjectPool<T0> constructor reference

- **Author:** Unity Technologies
- **Published:** Unity Scripting API (Unity 6 docs; `UnityEngine.Pool` since Unity 2021)
- **URL:** https://docs.unity3d.com/6000.0/Documentation/ScriptReference/Pool.ObjectPool_1-ctor.html
- **Also:** https://docs.unity3d.com/6000.0/Documentation/ScriptReference/Pool.ObjectPool_1.html
- **Retrieved:** 2026-07-11

## Summary

The constructor reference for `ObjectPool<T0>` settles two sizing parameters whose names invite
misreading. **`defaultCapacity`** is documented as the starting capacity of the stack-like structure
the pool uses for internal storage—and the reference states outright that instances are *not* created
at construction, but individually when `Get` is called. It is therefore a hint to the backing
collection about how much room to reserve, not a prewarm: a pool constructed with a capacity of 200
still holds zero instances and will pay for all 200 the first time gameplay asks for them. Growth
past `defaultCapacity` is allowed up to `maxSize`.

**`maxSize`** is the maximum number of instances the pool will *hold*, and it governs release rather
than get. Once the pool is full, further instances returned to it are not retained—they are dropped
(destroyed via `actionOnDestroy`, and otherwise left to garbage collection). `maxSize` is thus a cap
on retained memory, not a cap on how many objects can be live at once: `Get` on an empty pool always
runs `createFunc`, so a burst larger than the pool can still allocate beyond it, and those surplus
objects are then thrown away on release instead of being reused.

The remaining constructor arguments are the lifecycle callbacks—`createFunc`, `actionOnGet`,
`actionOnRelease`, `actionOnDestroy`—plus `collectionCheck`, which raises an error on releasing an
item already in the pool. The type exposes `CountActive` (created and currently in use),
`CountInactive` (available in the pool), and `CountAll` (the sum), which are the counters a project
can sample to find its true peak concurrent usage.

## Compiled into

- [[pool-warmup-and-budgeting]] — capacity vs. max size, why neither prewarms, and the counters to
  size a pool from
