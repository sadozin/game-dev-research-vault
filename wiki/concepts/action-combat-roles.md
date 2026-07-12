---
title: Action combat roles
type: concept
status: active
created: 2026-07-12
updated: 2026-07-12
verified: 2026-07-12
sources:
  - "[[mcdonald-mmo-character-roles]]"
  - "[[taugrim-action-combat]]"
  - "[[mmo-trinity-design]]"
tags: [mmo, classes, roles, game-design, combat]
---

# Action combat roles

Action combat roles are the party contributions that still matter when fights run on player aim,
movement, and readable attack patterns rather than sticky threat meters and auto-hit rotations.
They neighbour [[mmo-combat-roles]]: the design still names who prevents failure, who recovers from
mistakes, and who ends the encounter—but the tools change when taunt, tab-target locks, and UI
rotations are no longer the spine of play.

## Why it works

UI-based MMO combat optimises ability bars, cooldowns, and threat numbers; action combat shifts
attention to the world. Abilities can miss, require aim, and care about range and facing. Enemy
attacks are often shown as *telegraphs*—ground or body cues that mark hit volumes before damage
lands—so avoidance becomes a player skill instead of a dodge roll on a character sheet. Roles then
express themselves through what they do with that shared skill ceiling.

Without reliable taunt, “tank” means controlling space and protecting allies in real time: body
blocks, knocks, grips, shields, and forced movement rather than permanently owning an aggro table.
Damage dealers must choose targets under pressure—finish low health, peel for a friend with burst,
or leave a dangerous cast—because damage itself can be the peel when taunt does not exist. Support
leans toward ground heals, personal sustain, boons, cleanses, and timed saves that work while
everyone is moving; pure single-target heal-botting fights action camera and animation lock.

Sustain versus burst becomes an encounter budget, not only a class fantasy. Burst roles spike when
telegraphs create safe windows; sustain roles keep pressure through long mobile phases where
standing still to cast is a death sentence. Design encounters so those windows and pressures are
visible and learnable, then give [[mmo-skill-loadouts]] that trade peak damage for mitigation,
mobility, or control without forcing a second character.

## The catch

Dropping the classic trinity does not drop the coordination problem. Strict roles make pickup
groups readable; soft or hybrid action roles reward fixed teams and punish strangers who cannot
infer each other’s jobs. Adding more fixed roles (mandatory CC, buffer, off-tank) often worsens
queue pain without restoring in-fight decisions. Telegraph-heavy combat can recreate UI tunnel
vision as “watch the floor,” especially if animations are unreadable or patterns spam. And if every
class is fully self-sufficient for solo, group roles collapse into fashion—[[hybrid-class-balance]]
still applies.

## In practice here

When a project chooses action combat over tab-target trinity play, write the encounter failure
states first: who dies if nobody dodges, if nobody peels, if nobody finishes, if nobody sustains.
Map those to outputs (space control, peel damage, recovery, burst windows) before class names.
Link back to [[mmo-combat-roles]] for the general party-economy framing, and do not assume a taunt
button will paper over weak telegraph or positioning design.
