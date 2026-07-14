---
title: Doom-style shooter weapon and enemy design
type: concept
status: active
created: 2026-07-14
updated: 2026-07-14
verified: 2026-07-14
sources:
  - [[doom-open-source-release]]
  - [[doom-full-body-animation-gdc]]
tags: [game, design, shooter, doom, combat, ai, animation]
---

# Doom-style shooter weapon and enemy design

Weapons should change decisions through range, burst or sustain, single-target or area damage, ammo
economy, cadence, switch latency, self-risk, precision, and utility. Fast swapping supports expressive
play; reloads are optional and must justify their interruption.

Classic Doom combines hitscan bullets and pellets with moving projectiles and simple state-driven
enemies. Its source shows sight/sound acquisition, chase states, melee/ranged selection, fixed-tick
movement, auto-aim, and distinct pellet/spread behavior ([[doom-open-source-release]]). These are
shipped mechanics, not universal modern constants.

Enemy roles include chaser, space-denial projectile, hitscan urgency, anchor, flanker, support or
summoner, and fodder or resource carrier. Complexity should emerge from combinations of readable
roles. Dense crossfire favors dodgeable projectiles; hitscan needs stricter density, warning,
exposure windows, or geometry counterplay.

Treat each attack as anticipation, commitment, damage/projectile event, recovery, and interrupt
windows. id Software's full-body-animation talk reports that Doom's stylized combat characters
required robust and flexible AI-animation control rather than naive clip playback
([[doom-full-body-animation-gdc]]). Animation, sound, VFX, impact, and damage timing must agree.

## Related

- [[doom-style-shooter-combat-profiles]]
- [[doom-style-shooter-level-and-encounter-design]]
- [[character-animation-graphs]]
- [[game-collision-design]]
