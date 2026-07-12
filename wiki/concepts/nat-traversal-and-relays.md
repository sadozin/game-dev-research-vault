---
title: NAT traversal and relays
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[rfc-transports-and-webrtc]]"
tags: [game-development, networking, multiplayer]
---

# NAT traversal and relays

NAT traversal establishes a path between clients that do not have directly reachable addresses.

## Why it works

ICE gathers local, reflexive, and relay candidates, then checks pairs; a relay provides a dependable
fallback when direct paths fail.

## The catch

Symmetric NATs, firewalls, changing networks, and IPv6/IPv4 differences make direct connectivity
probabilistic. Relays improve success at bandwidth and operational cost.

## In practice

Design matchmaking and session state around a relay-capable fallback, expose connection diagnostics,
and avoid treating local-network success as proof of internet readiness.

