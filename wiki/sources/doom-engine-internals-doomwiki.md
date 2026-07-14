---
title: 'Source: Doom engine internals (DoomWiki)'
type: source
status: active
created: 2026-07-14
updated: 2026-07-14
verified: 2026-07-14
sources:
  - raw/doom-engine-internals-doomwiki.md
tags: [source, game, shooter, doom, engine]
---

# Source: Doom engine internals (DoomWiki)

- **Author:** DoomWiki community (community-maintained technical reference)
- **URL:** https://doomwiki.org/wiki/Engine_bug · https://doomwiki.org/wiki/Sound_propagation
- **Retrieved:** 2026-07-14
- **Raw:** raw/doom-engine-internals-doomwiki.md (provenance only)

## Summary

DoomWiki documents the shipped engine's quirks with cause-level precision. Sound "propagation" is
not audio: pressing the attack button calls P_NoiseAlert, which flood-fills a soundtarget pointer
through sector adjacency (recursing across two-sided lines with open height). A line flagged
sound-blocking only attenuates once — a sound must cross **two** such lines to stop. Monsters in
A_Look chase any valid soundtarget in their sector; ambush-flagged ("deaf") monsters still wake on
sound but hold position until they see a target, and a woken monster gains 360° perception.
Soundtargets persist forever and wake monsters spawned later into the sector.

The engine-bug catalog splits into gameplay bugs (blockmap-edge collision paralysis, the
intercepts overflow that produces "all-ghosts" walls, spechits overflow, the lost soul spawn cap,
rockets initially ignoring their firer) and rendering bugs from static limits (visplane overflow,
hall of mirrors, tutti-frutti, medusa, slime trails). Wallrunning and straferunning are movement
bugs that the community reclassified as beloved techniques.

## Compiled into

- [[classic-doom-engine-internals]]
- [[classic-doom-engine-quirks-and-bugs]]
