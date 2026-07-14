---
title: 'Source: ViZDoom - A Doom-based AI Research Platform'
type: source
status: active
created: 2026-07-14
updated: 2026-07-14
verified: 2026-07-14
sources:
  - raw/vizdoom-research-platform.md
tags: [source, game, shooter, doom, ai, testing]
---

# Source: ViZDoom - A Doom-based AI Research Platform

- **Authors:** Michal Kempka, Marek Wydmuch, Grzegorz Runc, Jakub Toczek, Wojciech Jaskowski
- **Published:** 2016-05-06
- **URL:** https://arxiv.org/abs/1605.02097
- **Retrieved:** 2026-07-14
- **Raw:** raw/vizdoom-research-platform.md (provenance only)

## Summary

ViZDoom exposes configurable Doom scenarios through C++, Python, and Java APIs for visual
reinforcement-learning research. It supports offscreen rendering, frame skipping, scenario-specific
rewards, and optional depth information.

The platform supports headless combat micro-scenarios and automated telemetry, while showing that
throughput still depends on actor count, resolution, and depth-buffer generation. Automated runs can
find logic and balance regressions but do not replace human evaluation of readability, navigation,
motion comfort, rhythm, and fun.

## Compiled into

- [[doom-style-shooter-testing-and-architecture]]
