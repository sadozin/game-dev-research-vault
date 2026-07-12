---
title: Authoritative server and anti-cheat
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[epic-networking-overview]]"
  - "[[valve-source-multiplayer-networking]]"
tags: [game-development, multiplayer, networking, server-authority, security]
---

# Authoritative server and anti-cheat

An authoritative server is the trust boundary for multiplayer state: clients submit inputs or
requests, while the server decides whether movement, combat, inventory, progression, and world
changes are valid. Client prediction can improve responsiveness, but it cannot grant the client
permission to write durable game truth.

## Why it works

Validate each command against server-owned state and rules: the actor's ownership, position and
reach, cooldowns, available resources, permissions, sequence or idempotency key, and rate limits.
Replicate only the state a connection needs to render and play, separating essential gameplay from
cosmetic effects. A headless dedicated server also removes the host player's direct access to the
authoritative simulation and keeps moderation, persistence, and audit decisions in one place.

## The catch

Server authority is not a complete anti-cheat product. Bugs in validation, excessive trust in client
timestamps, information leaks, weak account security, automation, and compromised servers remain
risks. Validation must be designed per action rather than reduced to a single "is this client
allowed" flag. Rejecting suspicious commands should be observable and explainable; silent client
correction without telemetry makes exploits and false positives hard to diagnose.

## In practice

For a persistent multiplayer game, expose commands such as move, interact, craft, spend, and attack
instead of accepting client-authored inventory or reward state. Make commands idempotent, attach
server sequence/tick information, and write durable outcomes only after validation. Treat the
client's animation, prediction, and UI as provisional. Combine this boundary with
[[state-synchronization-strategies]] for transport choices and [[lag-compensation]] only where a
time-sensitive combat query justifies a bounded rewind.
