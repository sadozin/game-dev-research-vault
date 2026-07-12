---
title: "Source: Gabriel Gambetta — Lag Compensation"
type: source
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "https://gabrielgambetta.com/lag-compensation.html"
tags: [source, game-development, multiplayer, networking, netcode, combat]
---

# Source: Gabriel Gambetta — Lag Compensation

- **Author:** Gabriel Gambetta
- **Published:** undated article; series page copyright 2026
- **URL:** https://gabrielgambetta.com/lag-compensation.html
- **Retrieved:** 2026-07-11

## Summary

In an interpolated client/server game, a player aims at a target rendered in the past while the
server processes the shot later. Gambetta's solution is for the client to send the shot timestamp
and aim, then for the authoritative server to reconstruct the relevant past world state and test
the shot there. This makes the attacker's view consistent with hit registration, but creates a
deliberate fairness tradeoff: a target may be hit shortly after reaching cover because the server
is honoring the attacker's earlier view.

## Compiled into

- [[lag-compensation]] — bounded server rewind for time-sensitive combat
