---
title: Unity Netcode for GameObjects
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[unity-netcode-for-gameobjects-overview]]"
  - "[[unity-netcode-networkobjects]]"
tags: [game-development, unity, multiplayer, networking, netcode]
---

# Unity Netcode for GameObjects

Netcode for GameObjects is Unity's high-level networking library for GameObject and MonoBehaviour
workflows. It provides networked objects, synchronized variables, RPC messaging, scenes, and
serialization on top of a transport layer, helping a project build authoritative multiplayer without
implementing every wire protocol from scratch.

## Why it works

NetworkObjects give spawned entities a network identity and ownership; NetworkVariables replicate
state while RPCs communicate events or commands. The abstraction fits projects already structured as
GameObjects and can coexist with Unity Transport and services such as Relay. Server authority and
explicit ownership keep durable state out of arbitrary client writes, complementing
[[client-prediction-and-reconciliation]].

## The catch

High-level object replication does not solve bandwidth, authority, prediction, interest management, or
cheating. A NetworkVariable updated every frame can become expensive, and RPCs can encode the wrong
reliability or ownership semantics. NetworkObject lifecycle, prefab registration, scene synchronization,
late join, disconnect, and host migration need explicit testing; a convenient local host can hide
latency and packet-loss failures.

## In practice here

Choose the authoritative owner for each state, replicate only state other clients need, and use events
for discrete actions rather than streaming values that can be derived. Test dedicated server and
client builds under delay, loss, reconnect, late join, and malicious input. Profile serialization,
bandwidth, and spawned-object counts, and move to a lower-level or ECS-oriented stack when object-level
replication no longer matches the scale of the simulation.
