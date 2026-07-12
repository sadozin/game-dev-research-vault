---
title: "Source: Glenn Fiedler — Snapshot Compression"
type: source
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "https://gafferongames.com/post/snapshot_compression/"
tags: [source, game-development, multiplayer, networking, netcode, compression]
---

# Source: Glenn Fiedler — Snapshot Compression

- **Author:** Glenn Fiedler
- **Published:** 2015-01-04
- **URL:** https://gafferongames.com/post/snapshot_compression/
- **Retrieved:** 2026-07-11

## Summary

Fiedler reduces snapshot bandwidth in stages: quantize fields to the precision gameplay needs,
omit values that are unchanged or at rest, then encode a snapshot relative to a baseline the
receiver has acknowledged. A packet must identify its baseline because the receiver cannot decode a
delta it never received. The sender keeps an initial/full-state path for startup or recovery and
chooses between changed-bit and changed-index encodings based on the current data. The resulting
bandwidth depends on measured state distributions, not a universal bit budget.

## Compiled into

- [[delta-compression-netcode]] — baseline acknowledgements, quantization, and recovery paths
