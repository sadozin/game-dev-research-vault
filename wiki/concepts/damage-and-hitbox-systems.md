---
title: Damage and hitbox systems
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[gameplay-motion-and-architecture]]"
tags: [game-development, gameplay, combat]
---

# Damage and hitbox systems

A damage system separates attack intent, hit detection, target vulnerability, mitigation, and the
resulting gameplay effects.

## Why it works

Hitboxes and hurtboxes give precise authored contact regions while a central damage event can handle
armor, resistance, invulnerability, feedback, and attribution consistently.

## The catch

Duplicate colliders, multi-frame overlaps, lag, animation timing, and client authority create double
hits or impossible outcomes. Visual contact is not automatically authoritative contact.

## In practice

Define one damage authority, attach stable source and target IDs, deduplicate events, and test frame,
latency, and invulnerability boundaries.

