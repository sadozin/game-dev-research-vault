---
title: "Source: Glenn Fiedler — Reliability and Congestion Avoidance over UDP"
type: source
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "https://gafferongames.com/post/reliability_ordering_and_congestion_avoidance_over_udp/"
tags: [source, game-development, multiplayer, networking, netcode, udp]
---

# Source: Glenn Fiedler — Reliability and Congestion Avoidance over UDP

- **Author:** Glenn Fiedler
- **Published:** 2008-10-20
- **URL:** https://gafferongames.com/post/reliability_ordering_and_congestion_avoidance_over_udp/
- **Retrieved:** 2026-07-11

## Summary

Fiedler builds a game-oriented reliability layer over UDP rather than treating every message as a
reliable ordered stream. Packet sequence numbers identify arrival order; acknowledgements and an
ack bitfield report recent receipt redundantly. Lost packets are inferred from missing acknowledgements,
but the protocol does not stop the stream to resend an old packet. The application composes a new
message when data still matters and gives that message its own idempotent identifier. Smoothed RTT
drives a simple congestion response that lowers send rate when the connection is being flooded.

## Compiled into

- [[reliable-udp-and-ordering]] — transport semantics for mixed real-time and reliable game traffic
