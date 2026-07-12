---
title: "Source: Nystrom — Object Pool (Game Programming Patterns)"
type: source
status: active
created: 2026-07-12
updated: 2026-07-12
verified: 2026-07-12
sources:
  - "https://gameprogrammingpatterns.com/object-pool.html"
tags: [source, optimization, patterns, memory]
---

# Source: Nystrom — Object Pool (Game Programming Patterns)

- **Author:** Bob Nystrom
- **Published:** 2014 (book; free online chapter)
- **URL:** https://gameprogrammingpatterns.com/object-pool.html
- **Retrieved:** 2026-07-12

## Summary

The Object Pool pattern improves performance and memory behaviour by reusing instances from a
managed collection instead of allocating and freeing them one by one. A pool holds reusable objects
that report whether they are in use; clients ask the pool for an instance, which marks it active and
returns it, then mark it free when finished so another client can claim it later.

The chapter stresses the performance motivation (allocation cost, fragmentation, and avoidable work
on hot spawn paths) and the design cost: reused objects are not automatically clean, so
initialization and teardown must be explicit. Fixed-size pools trade simplicity and predictable
memory for the need to handle exhaustion; the pattern is an optimization, not a default structure
for every type.

## Compiled into

- [[object-pooling]] — definition, reuse lifecycle, and the reset/exhaustion catch
