---
title: "Source: Glenn Fiedler — Floating Point Determinism"
type: source
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "https://gafferongames.com/post/floating_point_determinism/"
tags: [source, game-development, physics, simulation, netcode]
---

# Source: Glenn Fiedler — Floating Point Determinism

- **Author:** Glenn Fiedler
- **Published:** 2010-02-24
- **URL:** https://gafferongames.com/post/floating_point_determinism/
- **Retrieved:** 2026-07-11

## Summary

Fiedler answers the question "is floating point deterministic?" with a qualified yes: the same
binary, on the same CPU architecture, given the same inputs, will reproduce its results — but almost
every step away from that narrows the guarantee. He catalogues what breaks it. The x87 unit computes
at 80-bit extended precision and rounds on store, so intermediate results depend on register
allocation; SSE behaviour is not identically specified everywhere; compilers reassociate arithmetic,
fuse multiply-adds, and under fast-math flags apply algebraic rewrites that are not bit-exact;
transcendental functions such as sine and cosine are implemented differently by AMD and Intel; and a
third-party library can change the FPU control word and never restore it.

His recommendations are correspondingly narrow. If determinism is a requirement, pin the compiler,
the binary, and the architecture; force strict IEEE 754 semantics (`/fp:strict`); set and verify the
FPU control word; avoid or wrap the transcendentals; or step outside floating point altogether and
use fixed-point arithmetic. He is explicit about the price: cross-platform determinism costs
considerable engineering effort and measurably slower floating-point math, which is why many
networked games avoid designs that depend on it.

## Compiled into

- [[fixed-timestep-and-determinism]] — why a fixed step buys repeatability but not cross-platform
  bit-exactness
