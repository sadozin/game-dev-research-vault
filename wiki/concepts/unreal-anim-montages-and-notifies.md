---
title: Unreal animation montages and notifies
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[unreal-communication-animation]]"
tags: [game-development, unreal, animation]
---

# Unreal animation montages and notifies

Animation Montages package sequences into slots and sections that gameplay can start, blend, branch,
and annotate with notifies.

## Why it works

Combat, reloads, emotes, and one-shot actions can coordinate animation timing with sounds, effects,
damage windows, and root motion.

## The catch

Notifies are timing events, not authoritative gameplay state. Interruptions, network correction, and
animation rate changes can fire or skip them at surprising times.

## In practice

Keep gameplay validation outside the montage, make notify handlers idempotent, and define interruption
and replication policy for every action.

