---
title: "Source: Epic — Gameplay Framework"
type: source
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "https://dev.epicgames.com/documentation/en-us/unreal-engine/gameplay-framework-in-unreal-engine"
tags: [source, unreal, game-development, architecture]
---

# Source: Epic — Gameplay Framework

- **Author:** Epic Games
- **Published:** Unreal Engine 5 documentation
- **URL:** https://dev.epicgames.com/documentation/en-us/unreal-engine/gameplay-framework-in-unreal-engine
- **Retrieved:** 2026-07-11

## Summary

Epic's gameplay framework is a fixed set of classes with assigned jobs, and the assignments carry
networking consequences. **GameMode** (and its lighter `GameModeBase`) is a server-side manager
holding the rules and structure of a session; it is created when the level loads and does not persist
across levels. **GameState** is the non-physical actor for game-wide data — team scores, objectives,
the list of players and their player states — and it is the thing clients are allowed to see.
**PlayerController** is the manager that takes input from a human, drives heads-up information, and
possesses a physical representation in the world. **PlayerState** carries the data and logic belonging
to one player, such as health, ammo, and inventory. **Pawn** is the player's physical manifestation
that a controller possesses and directs; **Character** is the specialised, vertically-oriented pawn
built to walk, run, jump, fly, and swim. **HUD** is the base object for screen-overlay elements, one
per human player. **GameInstance** is created when the engine launches and lives until it shuts down,
persisting across level loads.

The network distribution matters as much as the definitions: GameMode and GameInstance are
server-side; PlayerController, PlayerState, and HUD are per-player; and GameState and PlayerState are
the classes replicated out to clients.

## Compiled into

- [[unreal-gameplay-framework]] — which class owns which data, and which of them clients can see
