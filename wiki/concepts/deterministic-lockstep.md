---
title: Deterministic lockstep
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[gaffer-deterministic-lockstep]]"
  - "[[gaffer-floating-point-determinism]]"
tags: [game-development, multiplayer, networking, netcode, simulation]
---

# Deterministic lockstep

Deterministic lockstep networks a simulation by sending the *inputs* that drive it instead of the
*state* it produces. Every peer runs the same simulation over the same input stream and, if the
simulation is genuinely deterministic, arrives at the same world without anyone ever transmitting a
position. It is the opposite trade from [[state-synchronization-strategies]], which sends world state
and tolerates divergence; lockstep sends almost nothing and tolerates none.

## Why it works

Bandwidth scales with the size of an input struct, not with the number of entities. A simulation of a
million objects costs the same to network as one object, because the objects are never sent — only
the handful of bytes describing what each player pressed on each tick. That is what makes lockstep
the traditional model for RTS games, where a state-replication approach would have to stream
thousands of units to every client. It also makes replays nearly free: the input log *is* the
recording, which is the relationship [[replay-and-recording-systems]] exploits.

The whole scheme rests on the simulation advancing in discrete, identical steps, so
[[fixed-timestep-and-determinism]] is a hard precondition rather than an optimisation. Inputs are
tagged with the tick they apply to, and a peer may not advance tick *n* until it holds every peer's
input for tick *n*.

## The catch

That last sentence is also the failure mode: lockstep is structurally blocking. A peer cannot
simulate ahead of the slowest input it is waiting on, so one player's lost packet or latency spike
stalls everybody. A playout delay buffer smooths jitter by holding inputs briefly before presenting
them, but it pays for steadiness with latency that every player feels — and running lockstep over a
reliable-ordered transport under packet loss produces exactly the head-of-line hitching that
[[reliable-udp-and-ordering]] warns about.

The harder constraint is bit-exactness. "Deterministic" here means every machine produces identical
results down to the last bit, which puts floating-point behaviour, compiler flags, CPU architecture,
and every use of randomness on the critical path — see [[gaffer-floating-point-determinism]] for how
many ways that guarantee breaks. A divergence does not stay small or self-correct: once two peers
disagree by one bit, they keep simulating from different states and drift apart permanently. Lockstep
therefore needs an explicit desync *detector* (typically a periodic checksum of world state) and a
recovery story, because it has no mechanism for tolerating disagreement. Cheating is the other
structural weakness: every client holds the full simulation, so lockstep gives away complete world
knowledge and cannot enforce the trust boundary that
[[authoritative-server-and-anti-cheat]] describes — maphack-style cheats are inherent to the model,
not a bug in it.

## In practice

Reach for lockstep when entity counts are high, the simulation is naturally turn- or tick-based, and
latency of 100–200 ms is acceptable: strategy games, simulation-heavy co-op, and deterministic
fighting games (which layer rollback on top, predicting remote inputs and re-simulating when the real
ones arrive, rather than blocking on them). Avoid it for open-world action and shooters, where a
stalled tick is unacceptable and the client cannot be trusted with the world — there,
[[client-prediction-and-reconciliation]] over an authoritative server is the better shape.

If you do commit to it, treat determinism as a testable property rather than an assumption: run the
same input log on every target platform in CI and compare state checksums, log the tick and checksum
on desync so the divergent tick can be replayed, and keep anything non-deterministic — particle
systems, cosmetic animation, UI, floating-point-heavy rendering code — strictly outside the simulated
state.
