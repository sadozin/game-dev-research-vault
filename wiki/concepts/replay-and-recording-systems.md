---
title: Replay and recording systems
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[unreal-replay-system]]"
  - "[[gaffer-deterministic-lockstep]]"
tags: [game-development, multiplayer, networking, simulation]
---

# Replay and recording systems

A replay reconstructs past gameplay without storing video. There are only two ways to do it, and they
sit at opposite ends of the same trade: **replay the inputs** and re-simulate, or **record the state
stream** and play it back. The first is tiny and fragile; the second is large and robust. Choosing
wrongly is expensive to undo, because the choice reaches into the simulation architecture itself.

## Why it works

Input replay stores only what the players did each tick and re-runs the simulation over that log. The
recording is a few bytes per tick and a match can be re-derived at any speed, from any camera, in
full fidelity — the same property that makes [[deterministic-lockstep]] cheap to network makes it
nearly free to record, because the input log *is* the replay. It also composes: the replay can be
re-simulated with a different renderer, at higher detail, or with the camera detached.

State recording makes no demands on the simulation at all. Unreal takes this route: rather than
logging inputs, its replay system captures the *network replication stream* through a
`DemoNetDriver`, and playback feeds that captured data back as though a server were sending it. The
recording is exactly the data a client would have received, so anything that already replicates is
already recorded, and the same machinery works in single-player and in the editor. Random access
comes from **checkpoints** — periodic world snapshots. To seek, the engine initialises the world,
applies the checkpoints up to the target time, and then replays the incremental replication data
forward from the last one.

## The catch

Input replay inherits every constraint of determinism. It requires a fixed step
([[fixed-timestep-and-determinism]]) and bit-exact reproduction, so a compiler upgrade, a different
CPU, or one `Random.value` called from render code silently invalidates the archive — and old replays
break on *every* patch that changes the simulation, which is why games that ship this model must
version their replays against the build that produced them. The failure is also silent: a replay that
diverges does not error, it just shows a match that never happened.

State recording escapes all of that and pays in bytes and in fidelity limits. Only what replicates is
recorded, so client-side effects, cosmetic-only systems, and anything the server never sent are
absent from playback. Unreal is explicit about a subtler hazard: replay actors make the same function
calls as live ones, so calls that reach shared objects like the `GameInstance`, `GameState`, or
`GameMode` remain live during playback and can perturb real game state. The checkpoint interval is a
direct size-versus-seek dial — Unreal's `demo.CheckpointUploadDelayInSeconds` defaults to 30 seconds,
and lengthening it shrinks the file but makes scrubbing backwards slower, because more incremental
data must be replayed from the previous checkpoint. Writing a checkpoint can itself hitch the frame,
so it is amortised across frames (`demo.CheckpointSaveMaxMSPerFrame`) — at the documented cost that
one checkpoint may hold actor data captured on different frames, producing small visual errors on
playback. That is the same "spread the spike, accept slight incorrectness" bargain
[[frame-pacing]] makes elsewhere.

## In practice

Pick by what already exists. If the game is already deterministic and lockstep-networked — RTS,
fighting game — record inputs; it is nearly free and the replays are tiny. If the game is an
authoritative-server action game with [[client-prediction-and-reconciliation]] and non-deterministic
clients, record the replication stream; you get replays for whatever already replicates without
constraining the simulation, and the recorder doubles as a spectator feed since both consume the same
stream.

Either way, treat replays as a *feature with a budget*: measure the file size per minute and the
worst-case seek, and tune the checkpoint interval against how players actually scrub (highlight
clipping seeks constantly; a match archive rarely does). Version every recording with the build that
made it and refuse to load mismatches rather than showing a wrong match. And keep in mind what
replays are worth beyond the highlight reel: a state recording plus the tick and checksum from a
desync is often the only practical way to reproduce a networking bug that happened once, on someone
else's machine.
