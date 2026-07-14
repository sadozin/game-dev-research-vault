---
title: Doom-style shooter combat profiles
type: concept
status: active
created: 2026-07-14
updated: 2026-07-14
verified: 2026-07-14
sources:
  - [[doom-open-source-release]]
  - [[doom-push-forward-combat-gdc]]
tags: [game, design, shooter, doom, combat]
---

# Doom-style shooter combat profiles

Classic Doom and Doom (2016) share speed and aggression but use different resource loops. Treat them
as distinct profiles rather than one genre formula.

Classic attrition/exploration uses finite placed health and ammunition, route choice, secrets,
infighting, and quiet navigation between fights. The released source confirms tick-driven movement,
hitscan and projectile attacks, simple legible enemy states, and data-driven weapons and actors
([[doom-open-source-release]]). Retreat and exploration are valid play.

Doom (2016)'s push-forward combat rejects conventions that interrupt aggression - regenerating
health, reload, and cover - and asks the player to take needed resources from enemies. This is the
explicit account from id Software's GDC presentation ([[doom-push-forward-combat-gdc]]).

A hybrid must teach when the player should conserve, search, or engage. Scarce placed resources plus
mandatory attrition arenas creates death spirals; plentiful combat drops plus conservation messaging
creates hoarding confusion. Choose the economy before encounter tuning.

The shared reusable loop is move, read threats, choose weapon and position, fire, receive feedback,
reposition or resupply, then reassess. Movement, roster, geometry, resources, and feedback must
support the same profile.

## Related

- [[doom-style-shooter-weapon-and-enemy-design]]
- [[doom-style-shooter-level-and-encounter-design]]
- [[doom-style-shooter-testing-and-architecture]]
