---
title: "Source: Glenn Fiedler — What Every Programmer Needs To Know About Game Networking"
type: source
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "https://www.gafferongames.com/post/what_every_programmer_needs_to_know_about_game_networking/"
tags: [source, game-development, multiplayer, networking, netcode]
---

# Source: Glenn Fiedler — What Every Programmer Needs To Know About Game Networking

- **Author:** Glenn Fiedler
- **Published:** undated archive page; copyright notice 2004–2024
- **URL:** https://www.gafferongames.com/post/what_every_programmer_needs_to_know_about_game_networking/
- **Retrieved:** 2026-07-11

## Summary

Fiedler explains why client-side prediction does not make the client authoritative. The client
simulates its own movement immediately, while the server validates the same input and remains the
source of truth. Each client keeps a circular history of local inputs and states. When a delayed
server correction arrives, the client rewinds to that acknowledged state and replays unacknowledged
inputs to reach the present. The approach works best when the client and server share sufficiently
similar movement rules; external events remain corrections the client cannot predict reliably.

## Compiled into

- [[client-prediction-and-reconciliation]] — input history, rewind, replay, and authority boundary
