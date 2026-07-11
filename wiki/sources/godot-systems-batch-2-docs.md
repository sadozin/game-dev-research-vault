---
title: "Source: Godot — multiplayer, audio, particles, saving"
type: source
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "raw/godot-systems-batch-2.md"
tags: [source, godot, game-development]
---

# Source: Godot — multiplayer, audio, particles, saving

- **Author:** Godot Engine documentation contributors
- **Published:** Godot 4.x stable documentation
- **Retrieved:** 2026-07-11
- **Raw:** `raw/godot-systems-batch-2.md` (provenance only)

## Summary

**Multiplayer:** SceneTree MultiplayerAPI + MultiplayerPeer (ENet default); RPCs via `@rpc`;
server id 1; authority modes; channels; lobby patterns; server-authoritative design required
for security. **Audio:** dB buses left-to-right routing to Master; effects; StreamPlayer /
2D / 3D variants; Area bus diversion and reverb. **Particles:** GPUParticles preferred over
CPU; ParticleProcessMaterial; lifetime/explosiveness; flipbooks; 3D attractors/colliders.
**Saving:** Persist group + JSON lines in `user://`; binary `store_var` for complex types;
ConfigFile for settings.

## Compiled into

- [[godot-multiplayer]] · [[godot-audio]] · [[godot-particles]] · [[godot-save-and-load]] ·
  [[godot-genre-build-checklists]]
