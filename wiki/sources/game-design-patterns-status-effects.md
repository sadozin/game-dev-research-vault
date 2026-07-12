---
title: "Source: game design patterns for state and cooldowns"
type: source
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "https://gameprogrammingpatterns.com/state.html"
  - "https://gameprogrammingpatterns.com/"
tags: [source, game-development, gameplay]
---

# Source: game design patterns for state and cooldowns

- **Author:** Robert Nystrom
- **Published:** 2014
- **URL:** https://gameprogrammingpatterns.com/state.html
- **Retrieved:** 2026-07-11

## Summary

The State pattern makes behavior transitions explicit instead of scattering conditionals through an
object. The same separation is useful for abilities and status effects: represent timing, ownership,
stacking, and removal as data and policy. The catch is indirection; a badly factored effect system
can make simple behavior harder to debug than a local implementation.

## Compiled into

- [[ability-and-cooldown-systems]]
- [[status-effects-and-buffs]]

