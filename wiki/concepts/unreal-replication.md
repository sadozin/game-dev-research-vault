---
title: Unreal replication
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[unreal-actor-roles]]"
  - "[[epic-networking-overview]]"
tags: [unreal, game-development, multiplayer, networking, server-authority]
---

# Unreal replication

Replication is how Unreal keeps a client's world in step with the server's. The engine is
client-server by construction: the server holds the one authoritative game state, clients send input
to it through remote calls on their pawn, and the server pushes the resulting state back out. Actors
are the unit — a replicated actor spawned on the server automatically appears as a proxy on the
clients, and is automatically destroyed and moved on them too. What is *not* automatic is which
properties, functions, and components take part; that is declared per member, and forgetting to
declare it is the most common way a feature works in the editor and breaks in a networked build.

## Why it works

There are two mechanisms and they are not interchangeable. **Replicated properties** are continuous
state: the server owns the value, the engine sends it when it changes, and clients converge on it —
with a `ReplicatedUsing` (RepNotify) variant that fires a callback on the client when the value
arrives, which is where cosmetic reactions belong. **RPCs** are events: a function called on one
machine that executes on another, directed at the server, at the owning client, or multicast to all.
The rule of thumb follows the semantics — durable state that a late-joining or reconnecting client
must also learn should be a replicated property, because it is a *fact about the world*; a one-shot
occurrence with no lasting state (a hit flash, a shout) can be an RPC, because a client that missed
it has missed nothing that persists. This is the same channel-semantics split that
[[reliable-udp-and-ordering]] makes at the transport level.

Every replicated actor carries a `Role`/`RemoteRole` pair, and the pair is relative to the machine
inspecting it: `Role` is how much control *this* machine has, `RemoteRole` how much the far end has.
`ROLE_Authority` holds the true state; `ROLE_AutonomousProxy` is your own pawn on your own client,
which simulates the true state and may still call remote functions; `ROLE_SimulatedProxy` is everyone
else's pawn on your client, which simulates but has no authority. That split is exactly the boundary
[[client-prediction-and-reconciliation]] operates on: the server does not replicate every frame — it
replicates at `NetUpdateFrequency` — so the gaps must be filled locally, and the roles decide *how*.
An autonomous proxy **predicts**, running the movement rules ahead of confirmation; a simulated proxy
only replays and smooths what it was sent, which is the interpolation problem rather than the
prediction one.

## The catch

Replication is bandwidth, and bandwidth is finite, so Unreal spends most of its networking surface
area on *not* sending things. Relevancy decides whether an actor is worth sending to a given
connection at all; net priority decides who wins when there is not enough bandwidth for everyone; and
dormancy — which Epic calls one of the most significant optimisations available — removes an actor
from a connection's replication consideration entirely until something wakes it. A world that
replicates everything to everyone will hit the bandwidth ceiling long before it hits a CPU one, and
the symptom is not a clean error but a rising net-update latency that looks like lag.

The authority model is also load-bearing for security, not just for consistency. Because a client's
own pawn is an autonomous proxy that runs the movement rules locally, it is *predicting*, not
*deciding* — the server still validates. Moving a decision to a client RPC that the server trusts
converts a design into an exploit, which is the trust boundary
[[authoritative-server-and-anti-cheat]] draws. And because RepNotify fires on *value change* rather
than on every update, a property that flips and flips back between two replication ticks can deliver
no notification at all; anything that must not be missed belongs in a reliable RPC or in state the
client can reconstruct.

## In practice

Model the world as replicated properties and reserve RPCs for genuine events. Put durable per-player
data on `PlayerState` (see [[unreal-gameplay-framework]]) so it survives respawns and reaches every
client, and keep server-only decision logic on `GameMode`, which clients never see. Check
`HasAuthority()` before mutating authoritative state rather than assuming code runs where you think
it does — the same Blueprint or C++ function frequently runs on all three roles, and the role is the
only thing distinguishing them.

When bandwidth becomes the constraint, reach for relevancy, priority, and dormancy before reaching
for a smaller update rate: cutting `NetUpdateFrequency` degrades every client's smoothing equally,
whereas dormancy costs idle actors nothing at all. Profile with the network profiler and treat the
per-connection byte budget the way [[game-performance-profiling]] treats a frame budget — as a
ceiling you degrade against deliberately, not one you discover by shipping.
