---
title: "Source: Epic — Replay system, DemoNetDriver and streamers"
type: source
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "https://dev.epicgames.com/documentation/en-us/unreal-engine/using-the-replay-system-in-unreal-engine"
  - "https://dev.epicgames.com/documentation/unreal-engine/demonetdriver-and-streamers-in-unreal-engine"
tags: [source, unreal, game-development, multiplayer, networking]
---

# Source: Epic — Replay system, DemoNetDriver and streamers

- **Author:** Epic Games
- **Published:** Unreal Engine 5 documentation (5.7/5.8 pages)
- **URL:** https://dev.epicgames.com/documentation/en-us/unreal-engine/using-the-replay-system-in-unreal-engine
  and https://dev.epicgames.com/documentation/unreal-engine/demonetdriver-and-streamers-in-unreal-engine
- **Retrieved:** 2026-07-11

## Summary

Unreal does not record replays by logging inputs and re-simulating them. It records the *network
replication stream*: a specialised `DemoNetDriver` captures the same replicated data the engine would
send to a client, and playback feeds that data back in as though it came from a server. The
consequence Epic draws out is that replay actors behave like live actors and make the same function
calls — which is useful, but also means calls that touch shared objects such as the `GameInstance`,
`GameState`, or `GameMode` remain live during playback and can alter game state in unintended ways.
Because it is a replication capture, the technique works for single-player and editor sessions too,
not only multiplayer.

Random access comes from **checkpoints**: periodic snapshots of world state. Any moment is
reconstructed by initialising the world, applying the checkpoints up to the target time, then
replaying the incremental replication data from the most recent checkpoint forward. That makes the
checkpoint interval a direct size-versus-seek-time dial — Epic states the default
`demo.CheckpointUploadDelayInSeconds` is 30 seconds, and that increasing it shrinks replays but makes
scrubbing backwards and skipping around slower. Recording a checkpoint can also cost enough time to
hitch the game, so `demo.CheckpointSaveMaxMSPerFrame` caps the per-frame checkpoint work and queues
the remaining actors to the next frame; the documented price is that a checkpoint can then contain
actor data captured on different frames, producing slight visual errors on playback. Scrubbing is
driven by `UDemoNetDriver::GotoTimeInSeconds` (the `demoscrub` console command), with playback speed
via `DemoPlayTimeDilation`.

Where the bytes go is a separate choice of **streamer**: a local file streamer (the default,
asynchronous to disk), an in-memory streamer for instant replays, and an HTTP streamer that ships
replay data to a remote service.

## Compiled into

- [[replay-and-recording-systems]] — replication-capture versus deterministic input replay,
  checkpoints, and the seek-time/size trade
