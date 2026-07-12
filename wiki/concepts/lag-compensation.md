---
title: Lag compensation
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[gambetta-lag-compensation]]"
  - "[[valve-source-multiplayer-networking]]"
tags: [game-development, multiplayer, networking, netcode, combat]
---

# Lag compensation

Lag compensation lets an authoritative server evaluate a time-sensitive action against the world
state the acting player actually saw, instead of only against the server's later present. It is a
server-side hit-registration policy layered on top of [[client-prediction-and-reconciliation]] and
remote-entity interpolation, not permission for a client to declare that a hit happened.

## Why it works

The client sends an action with a sequence or timestamp and the relevant aim or query data. The
server retains a bounded history of relevant entity transforms, estimates the action's execution
time from server time, latency, and interpolation delay, rewinds those entities, evaluates the
authoritative query, then restores the current world. This makes a shot against a moving target
match the attacker's rendered view while keeping the server in control of damage and rewards.

## The catch

Rewinding favors the attacker and can allow a target to be hit just after reaching cover from the
target's perspective. History costs memory and bookkeeping, and clock disagreement, packet delay,
high speed, or changing collision geometry can make the reconstructed scene imperfect. Bound the
maximum rewind window, reject implausible timestamps, record the server decision, and test the policy
under latency rather than presenting it as universally fair. Do not rewind durable world mutations
or inventory outcomes merely to make a client animation feel right.

## In practice

For an authoritative multiplayer action game, restrict lag compensation to explicitly chosen combat
queries such as hitscan or short-window melee traces. Keep block edits, loot, crafting, and rewards
on current server state; clients may predict feedback, but the server confirms the durable result.
Expose a debug view of current versus rewound hit volumes and measure the rewind window, correction
rate, and false-positive/false-negative reports alongside [[state-synchronization-strategies]].
