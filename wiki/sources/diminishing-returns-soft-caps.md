---
title: "Source: Soft caps and diminishing returns formulas"
type: source
status: active
created: 2026-07-12
updated: 2026-07-12
verified: 2026-07-12
sources:
  - "https://gamedev.stackexchange.com/questions/109985/simple-diminishing-return-with-cap"
tags: [source, game-design, economy, math]
---

# Source: Soft caps and diminishing returns formulas

- **Author:** Game Development Stack Exchange (community answer; formula discussion)
- **Published:** 2015-10-20 (question/answers)
- **URL:** https://gamedev.stackexchange.com/questions/109985/simple-diminishing-return-with-cap
- **Also:** https://blog.nerdbucket.com/diminishing-returns-in-game-design-the-logarithm/article (log-shaped returns without a hard ceiling)
- **Retrieved:** 2026-07-12

## Summary

Designers often need a bonus that grows with investment yet approaches a practical ceiling so late
points still cost effort without dominating balance. A simple family is
`y = a · x / (x + n)`: as input *x* grows, output *y* rises quickly at first and asymptotically
approaches scale *a*, with *n* controlling how soon returns feel soft. Multiplying by a scale sets
the effective cap (for example crit chance never quite reaching 40%).

Logarithmic mapping is a related soft shape with no hard upper bound: each new unit of investment
adds less to the output than the last, which suits cumulative stats that should remain meaningful
forever but not explode. Both families are tools for soft-capping effects of prestige spends and
meta currencies without a binary “maxed” switch—pair them with explicit hard caps only when a
resource must stop (storage, offline hours).

## Compiled into

- [[prestige-currency-soft-caps]] — soft-cap formulas for meta currency *effects*
