---
title: Unreal gameplay framework
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[unreal-gameplay-framework-docs]]"
  - "[[epic-networking-overview]]"
tags: [unreal, game-development, architecture]
---

# Unreal gameplay framework

Unreal does not leave the top-level architecture of a game to the developer: GameMode, GameState,
PlayerController, PlayerState, Pawn, Character, HUD, and GameInstance already exist, and each has an
assigned job. The framework is worth learning as a set of *ownership rules* rather than a class list,
because where a piece of data lives determines who can see it, who can change it, and whether it
survives a respawn or a level change. Most Unreal architecture mistakes are a piece of state living
in the wrong one of these boxes.

## Why it works

The split follows lifetime and visibility. **GameInstance** is created at engine launch and lives
until shutdown, so it is the only place state survives a level change — session data, persistent
settings. **GameMode** holds the rules of the session, is created on level load, and does not persist
across levels; crucially it exists **only on the server**, which makes it the natural home for
authoritative decisions (who scored, when the round ends, where a player respawns) precisely because
no client can see or call into it. **GameState** is its client-visible counterpart: game-wide data —
scores, objectives, the list of players — replicated out so every client can render the same match
status.

Per player, the split repeats. **PlayerController** takes the human's input, drives HUD information,
and possesses a physical representation. **Pawn** *is* that physical representation, and **Character**
is the specialised vertically-oriented pawn with walking, jumping, flying, and swimming built in.
**PlayerState** carries the data belonging to a player — health, ammo, inventory, score — and it, like
GameState, is replicated to clients. **HUD** is the screen-overlay object, one per human player.

The reason this matters is that the boxes line up with the replication roles in
[[unreal-replication]]: a controller possesses a pawn, the pawn is what other clients see as a
simulated proxy, and the durable facts about the player sit in PlayerState where everyone can read
them.

## The catch

The distinction that costs people the most time is **Pawn versus PlayerState**. A pawn is destroyed
and respawned on death; anything stored on it dies with it. Score, loadout, team, and stats belong on
PlayerState, which outlives the pawn — putting them on the Character means they vanish on respawn,
and putting them on the PlayerController means other clients cannot see them, because a client only
holds *its own* controller. That last point catches almost everyone: PlayerControllers are not
replicated to other players, so "read the other player's controller" is not a thing you can do.

**GameMode being server-only** is the mirror-image trap. Client code that reaches for GameMode
compiles, runs fine in a single-player PIE session, and returns null the moment the game is a
listen-server client — one of the most common reasons a mechanic works in the editor and breaks in
multiplayer. And GameMode's non-persistence across levels means anything that must survive a travel
belongs in GameInstance instead.

## In practice

Place state by asking two questions: *how long must it live*, and *who must see it*. Session-spanning
state goes in GameInstance; match rules and authoritative decisions in GameMode (server-only);
match-wide facts clients must render in GameState; per-player durable facts in PlayerState; and only
the physical, respawnable body in the Pawn or Character. Input handling and the player's viewpoint
belong to the PlayerController, which is also the right place to route requests to the server, since
it is the client's authenticated line to it.

Prefer `GameModeBase` when you do not need the full match/round scaffolding, and reach for
`Character` only when you actually want its movement component — a vehicle or a turret is usually a
plain Pawn, and inheriting Character to get a capsule you then fight against is a common source of
movement bugs. When a mechanic behaves differently in a networked build, check where its state lives
before debugging the mechanic; more often than not the class, not the logic, is what is wrong. See
[[unreal-engine-workflow]] for how these pieces sit inside a project.
