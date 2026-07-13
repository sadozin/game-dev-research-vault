---
title: Reliable UDP and ordering
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[gaffer-reliability-over-udp]]"
  - "[[valve-source-multiplayer-networking]]"
tags: [game-development, multiplayer, networking, netcode, udp]
---

# Reliable UDP and ordering

Game protocols often need both low-latency updates and reliable commands, but not every packet
deserves the same delivery policy. A reliability layer over UDP can preserve a steady stream while
letting the application decide which messages are obsolete, which need retransmission, and which
must be applied exactly once and in order.

## Why it works

Put a sequence number on every packet and report received sequences with acknowledgements plus a
redundant bitfield. Use packet order to discard stale or duplicate packets, and use message IDs to
make retransmitted commands idempotent. Do not resend a lost real-time snapshot as the same packet;
send a newer snapshot that supersedes it. For durable commands, retain the command until acknowledged
or until a timeout policy expires. Track smoothed RTT and back off send rate when latency indicates
congestion. This complements [[state-synchronization-strategies]], where snapshots and deltas have
different loss semantics.

## The catch

UDP provides no safety by itself. Sequence wraparound, duplicate commands, ack loss, out-of-order
delivery, fragmentation, retransmission storms, and congestion all become application problems.
Making every channel reliable recreates head-of-line blocking; making every channel unreliable loses
inventory, authentication, or world edits. The header, ack window, timeout, and idempotency rules
must be specified and tested together, including packet loss bursts and reconnects. Measure RTT,
loss, send rate, queue depth, and bandwidth with [[game-performance-profiling]].

## In practice

Use separate logical channels over one transport: sequenced-unreliable snapshots for movement and
remote presentation, and reliable-ordered or reliable-idempotent commands for login, block edits,
inventory, crafting, rewards, and chat. Include a protocol version, packet sequence, server tick,
ack state, and message ID where the channel needs them. Reject duplicate durable commands after the
server records their result; never let a retransmitted request duplicate an item, spend, or reward.
Keep snapshots disposable so a late packet cannot hold newer movement behind an old one, and pair
the design with [[authoritative-server-and-anti-cheat]] for validation.
