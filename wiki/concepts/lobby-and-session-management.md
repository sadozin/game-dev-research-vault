---
title: Lobby and session management
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[unity-multiplayer-sessions]]"
tags: [game-development, networking, multiplayer]
---

# Lobby and session management

Lobby and session management coordinates discovery, membership, readiness, connection data, and the
transition into a running game.

## Why it works

Separating a searchable lobby from the game server lets players form groups, exchange metadata, and
handle host or relay details before gameplay starts.

## The catch

Membership is distributed state: invites, disconnects, stale records, host migration, and duplicate
joins need explicit transitions. A lobby can outlive the server it describes.

## In practice

Model the session as a state machine, give every transition an owner and timeout, and clean up stale
records with idempotent operations.

