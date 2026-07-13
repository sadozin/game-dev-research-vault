---
title: "Source: Bridson fast Poisson disk sampling"
type: source
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "https://www.cs.ubc.ca/~rbridson/docs/bridson-siggraph07-poissondisk.pdf"
tags: [source, game-development, procedural-generation]
---

# Source: Bridson fast Poisson disk sampling

- **Author:** Robert Bridson
- **Published:** 2007
- **URL:** https://www.cs.ubc.ca/~rbridson/docs/bridson-siggraph07-poissondisk.pdf
- **Retrieved:** 2026-07-11

## Summary

The method samples a domain while enforcing a minimum distance between points. A background grid
keeps neighbour checks local; an active list proposes candidates around existing samples and retires
points after failed attempts. It gives more even distributions than independent random points, but
the minimum-distance constraint can reduce density near boundaries and does not encode semantic
placement rules.

## Compiled into

- [[poisson-disk-sampling]]

