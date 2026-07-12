---
title: "Source: Epic — Actor Role and Remote Role"
type: source
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "https://dev.epicgames.com/documentation/en-us/unreal-engine/actor-role-and-remote-role-in-unreal-engine"
tags: [source, unreal, game-development, multiplayer, networking, server-authority]
---

# Source: Epic — Actor Role and Remote Role

- **Author:** Epic Games
- **Published:** Unreal Engine 5 documentation
- **URL:** https://dev.epicgames.com/documentation/en-us/unreal-engine/actor-role-and-remote-role-in-unreal-engine
- **Retrieved:** 2026-07-11

## Summary

Every replicated actor in Unreal carries two role values, and the pair is relative to the machine
asking. `Role` says how much control *this* machine has over the actor; `RemoteRole` says how much
control the machine at the other end has. The same actor therefore reports different roles depending
on where you inspect it.

The three values are `ROLE_Authority` — this machine holds the true state and may change it and call
remote functions; `ROLE_AutonomousProxy` — this machine simulates the true state and may still change
it and call remote functions, the role a player's own pawn has on their client; and
`ROLE_SimulatedProxy` — this machine simulates the state but has no authority to change it or invoke
remote functions, the role every *other* player's pawn has on your client. Concretely, a
player-controlled actor is `Role = ROLE_Authority, RemoteRole = ROLE_AutonomousProxy` on the server;
`Role = ROLE_AutonomousProxy, RemoteRole = ROLE_Authority` on that player's own client; and
`Role = ROLE_SimulatedProxy, RemoteRole = ROLE_Authority` on everybody else's.

The distinction exists because the server does not replicate every frame — it replicates at
`NetUpdateFrequency` — so clients must fill the gaps locally or movement would visibly step. The two
proxy roles fill them differently: an autonomous proxy *predicts*, running the movement rules itself
ahead of confirmation, while a simulated proxy merely replays and smooths the data it was sent.

## Compiled into

- [[unreal-replication]] — the authority/proxy split and who is allowed to predict
