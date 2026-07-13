---
title: Unity DOTS, Jobs, and Burst
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[unity-burst-compilation]]"
  - "[[unity-job-system-overview]]"
tags: [game-development, unity, optimization, jobs, burst, ecs]
---

# Unity DOTS, Jobs, and Burst

Unity's data-oriented path combines the Job System for parallel work, Burst for LLVM-generated native
code, and ECS/DOTS packages for data-oriented gameplay. Jobs split independent work across worker
threads; Burst accelerates compatible jobs and static methods; ECS supplies an architecture that makes
large collections of similar entities easier to process in batches.

## Why it works

Struct-based jobs and native containers make data ownership and dependencies explicit, allowing Unity
to schedule work across CPU cores. Burst compiles a supported C# subset to optimized native code and
can use platform-specific CPU instructions. ECS's contiguous component-oriented data improves access
patterns and makes parallel iteration practical for large populations.

## The catch

The performance path is constrained by safety, synchronization, and the Burst-supported C# subset:
managed objects, arbitrary reference graphs, and hidden main-thread calls do not fit cleanly. Jobs that
are too small lose to scheduling overhead; dependencies or `Complete` calls can serialize the pipeline;
and editor JIT behavior can differ from player AOT. Removing safety checks or using fast floating-point
settings can hide bugs or change numerical results.

## In practice here

Profile a real CPU hotspot first, move data into native containers, schedule coarse independent batches,
and keep ownership boundaries explicit. Leave safety checks on while developing, warm Burst before
timing, and test the actual player build on the target architecture. Use DOTS where the workload is
large and uniform; ordinary MonoBehaviours remain simpler for irregular, low-volume behavior.
