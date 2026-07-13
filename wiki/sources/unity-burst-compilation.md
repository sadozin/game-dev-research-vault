---
title: "Source: Unity — Burst compilation"
type: source
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "https://docs.unity3d.com/ja/current/Manual/script-compilation-burst.html"
tags: [source, game-development, unity, optimization, jobs, burst]
---

# Source: Unity — Burst compilation

- **Author:** Unity Technologies
- **Published:** Unity 6.0 manual
- **URL:** https://docs.unity3d.com/ja/current/Manual/script-compilation-burst.html
- **Retrieved:** 2026-07-11

## Summary

Unity describes Burst as an LLVM-based compiler for a supported subset of C# called HPC#. It was
designed for the Job System, compiles marked compatible code to native code, and is central to ECS but
can also be used independently. Editor play mode uses JIT compilation while player builds use AOT;
managed objects are outside the supported model, so compatible collections and math types are used
instead.

## Compiled into

- [[unity-dots-jobs-and-burst]] — Burst's compilation model, scope, and managed-code boundary
