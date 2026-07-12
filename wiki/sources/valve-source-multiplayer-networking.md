---
title: "Source: Valve Developer Community — Source Multiplayer Networking"
type: source
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "https://developer.valvesoftware.com/wiki/Source_Multiplayer_Networking"
tags: [source, game-development, multiplayer, networking, netcode]
---

# Source: Valve Developer Community — Source Multiplayer Networking

- **Author:** Valve Developer Community contributors
- **Published:** undated documentation page
- **URL:** https://developer.valvesoftware.com/wiki/Source_Multiplayer_Networking
- **Retrieved:** 2026-07-11

## Summary

The Source networking overview describes a dedicated client-server model: the server advances the
authoritative simulation in discrete ticks, processes user commands, and sends snapshots rather
than every world change. Clients send sequenced input commands, predict the local player's result,
and interpolate other entities between received snapshots. When an authoritative snapshot differs,
the local prediction is corrected; the server remains the authority. The overview also connects
interpolation delay, packet loss, tick rate, bandwidth, and lag compensation, making clear that
raising update rates spends CPU and network budget rather than providing a free quality increase.

## Compiled into

- [[client-prediction-and-reconciliation]] — local responsiveness with server authority
