---
title: "Source: Wloka — Batch, Batch, Batch: What Does It Really Mean?"
type: source
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "https://www.nvidia.com/docs/io/8228/batchbatchbatch.pdf"
tags: [source, optimization, rendering]
---

# Source: Wloka — Batch, Batch, Batch: What Does It Really Mean?

- **Author:** Matthias Wloka (NVIDIA)
- **Published:** Game Developers Conference 2003
- **URL:** https://www.nvidia.com/docs/io/8228/batchbatchbatch.pdf
- **Retrieved:** 2026-07-11

## Summary

The presentation quantifies the cost of a draw call—the CPU-side work to submit and set up a batch
of geometry—and shows that this cost, not triangle throughput, is what most scenes hit first. On
the fastest hardware of the day (an Athlon XP 2700+ paired with a GeForce FX 5800), any batch of
roughly 130 triangles or fewer left the system completely CPU-bound: the processor could not issue
draw calls quickly enough to keep the GPU busy, so triangles added inside an existing call were
effectively free.

The governing metric is therefore batches submitted per frame, not triangles per frame. Because GPU
throughput was already scaling faster than single-thread CPU performance, the author predicted the
imbalance would only grow—a prediction later hardware confirmed. The practical conclusion is to cut
the number of batches by merging geometry that shares render state, since per-batch CPU cost
dominates.

## Compiled into

- [[draw-call-batching]] — why per-call CPU overhead, not triangle count, sets the batch ceiling
