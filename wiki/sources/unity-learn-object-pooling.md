---
title: "Source: Unity Learn — Introduction to Object Pooling"
type: source
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "https://learn.unity.com/tutorial/introduction-to-object-pooling"
tags: [source, unity, optimization, memory]
---

# Source: Unity Learn — Introduction to Object Pooling

- **Author:** Unity Technologies (Unity Learn tutorial)
- **Published:** Unity Learn; content verified by Unity against 2019.3–2019.4
- **URL:** https://learn.unity.com/tutorial/introduction-to-object-pooling
- **Retrieved:** 2026-07-11

## Summary

Unity's introductory tutorial builds a pool by hand, and in doing so shows the warm-up step that the
later `ObjectPool<T0>` API leaves to the caller (see [[unity-object-pool-api]]). In `Start()`, a loop
instantiates the pooled prefab `amountToPool` times, deactivates each instance, and adds it to a
list; at spawn time the code walks the list for an inactive entry and reactivates it. Pre-creating
the instances during initialization—rather than on the first shot fired—is what keeps the
instantiate cost out of gameplay, and it is done with an explicit loop, not a constructor argument.

The tutorial's sizing advice is deliberately informal: pick "a relatively large number such as 20,"
enough objects to work with. It does not describe how to derive that number from actual peak
concurrent use, and—worth noting for anyone taking it as a complete guide—it does not discuss the
memory cost of holding those instances resident at all, framing pooling purely as relief for the
CPU. The omission is the gap: a hand-rolled pool sized by guesswork either runs dry under a burst
(the lookup finds no inactive entry) or quietly holds memory that nothing ever uses.

## Compiled into

- [[pool-warmup-and-budgeting]] — prewarming as an explicit init-time loop, and the cost of sizing
  a pool by guesswork
