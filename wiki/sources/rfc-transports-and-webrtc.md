---
title: "Source: IETF transport protocols and WebRTC"
type: source
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "https://www.rfc-editor.org/rfc/rfc9293"
  - "https://www.rfc-editor.org/rfc/rfc9000"
  - "https://www.rfc-editor.org/rfc/rfc8445"
tags: [source, game-development, networking]
---

# Source: IETF transport protocols and WebRTC

- **Author:** Internet Engineering Task Force
- **Published:** 2022-08 / 2021-05 / 2018-07
- **URL:** https://www.rfc-editor.org/rfc/rfc9293
- **Retrieved:** 2026-07-11

## Summary

TCP provides an ordered reliable byte stream; QUIC provides encrypted streams over UDP with
connection migration; ICE combines candidate discovery, connectivity checks, and relays for
peer-to-peer sessions. The protocols expose different failure and latency contracts, so a game
should choose per message class rather than treat “networking” as one transport problem.

## Compiled into

- [[transport-udp-tcp-webrtc]]
- [[nat-traversal-and-relays]]

