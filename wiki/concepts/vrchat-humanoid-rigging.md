---
title: VRChat humanoid rigging
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[vrchat-rig-requirements]]"
tags: [vrchat, avatars, rigging, humanoid]
---

# VRChat humanoid rigging

A VRChat Humanoid avatar needs a coherent Mecanim humanoid mapping and a bone hierarchy that
supports IK. The Hips mapping must be an ancestor of all mapped humanoid bones; head, hands, and
feet are essential for a valid humanoid avatar.

## Why it works

Set a clean rest T-pose, map bones in Unity's Humanoid configuration, and use the SDK Build
Control Panel as the final validator. Map toe bones when their extra motion is desired. Map the
thumb, index, and middle finger chains for full IK, automatic foot placement, crouching behavior,
and gesture animation support. Export the same armature used by the body and clothing rather than
creating a parallel garment rig.

## The catch

The cited VRChat rigging page is explicitly marked out of date. Do not override current SDK
warnings from a tutorial or old avatar. Non-humanoid creatures need a Generic rig and custom
animation controller, which is a different and more advanced design path.

## In practice here

[[arii-blend-avatar]] already has an `Armature` and a T-pose. Validate its Unity Humanoid mapping
before changing bones; fitted clothes should bind to that existing armature. Do not confuse the
known Blender armature with a verified Unity upload configuration.
