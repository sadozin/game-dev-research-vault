---
title: UDP, TCP, and WebRTC transport choices
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[rfc-transports-and-webrtc]]"
tags: [game-development, networking]
---

# UDP, TCP, and WebRTC transport choices

Transport selection is a message-contract decision: reliability, ordering, congestion behavior,
latency, and reachability have different costs.

## Why it works

Unreliable or selectively reliable UDP-style protocols avoid head-of-line blocking for real-time
state; TCP simplifies ordered delivery; WebRTC adds browser-compatible ICE and media/data channels.

## The catch

UDP requires reliability, sequencing, and congestion discipline to be designed. TCP can stall a game
behind one lost packet, while WebRTC adds signaling, NAT, and browser lifecycle complexity.

## In practice

Separate snapshots, inputs, chat, and account operations into contracts before choosing a library.

