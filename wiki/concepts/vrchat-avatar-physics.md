---
title: VRChat avatar physics
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[vrchat-physbones]]"
  - "[[vrchat-avatar-performance-ranks]]"
tags: [vrchat, avatars, physics, physbones]
---

# VRChat avatar physics

PhysBones supply secondary motion for avatar hair, clothing, ears, and tails. They should amplify
a clean rig, not compensate for poor weights or create a simulation chain for every detail.

## Why it works

Author PhysBones directly rather than relying on Dynamic Bone conversion. Build short, purposeful
bone chains, use collisions and grabbing only when they add an interaction, and inspect behavior
in the SDK before upload. Split an exceptionally large branching set only when it helps execution;
otherwise reduce unnecessary bones first. Never place a Unity or VRChat Constraint and a PhysBone
on the same GameObject.

## The catch

Physics is a platform budget. Mobile currently hard-limits PhysBone components, affected
transforms, colliders, and collision checks; exceeding one limit removes all limited avatar
components on that platform. A single PhysBone component can technically touch 256 transforms,
but a chain that large is a warning to simplify, not a target.

## In practice here

For a skirt, coat tail, or loose hair on [[arii-blend-avatar]], first build deformation with the
existing rig, then add the smallest PhysBone chain that creates the desired secondary motion.
Keep fitted tankini-style clothing skinned to body bones; it does not need simulation merely
because it is clothing.
