---
title: Tower-defense readability and onboarding
type: concept
status: active
created: 2026-07-14
updated: 2026-07-14
verified: 2026-07-14
sources:
  - [[wiki/sources/plants-vs-zombies-onboarding-gdc|plants-vs-zombies-onboarding-gdc]]
  - [[wiki/sources/kingdom-rush-press-kit|kingdom-rush-press-kit]]
tags: [game, design, tower-defense, user-interface, onboarding, accessibility]
---

# Tower-defense readability and onboarding

Readability is a balance system. A counter the player cannot see before committing is functionally
harder than the same numeric counter with a preview, and a tower whose wasted shots are hidden is
harder to learn than one with lower damage but clear feedback.

## Information before, during, and after commitment

Before placement, show footprint, legal cells, range, covered path length, blocked-route effects,
price, total owned, refund, and a precise rejection reason. Before upgrade, show total cost and the
meaningful deltas: damage type, cadence, range, targets, splash, control, branch lockout, and new role.
Before a wave, show arrival lane, timing, exceptional traits, and any rule capable of invalidating a
normal defense.

During combat, preserve route contrast, enemy silhouettes, direction, health/status, tower target,
attack travel, and hit result. Effects should reinforce damage type and priority rather than cover
the lane. Aggregate damage numbers, cap flashes, and reserve the strongest audiovisual signals for
new threats, leaks, abilities, and phase changes.

After combat, expose first leak, enemy type, lane, tower eligibility or damage mismatch, and economy
state. A lightweight combat breakdown is more educational than a generic “defeat” screen.

## Teach through safe action

George Fan's Plants vs. Zombies talk ([[wiki/sources/plants-vs-zombies-onboarding-gdc|plants-vs-zombies-onboarding-gdc]]) shows why a tooltip is not
enough when players do not value a resource producer: the introduction, payoff timing, and wider
balance all matter. Introduce one concept in a safe situation, let the player act, make the result
visible, repeat with variation, combine it with a known concept, then test mastery.

Keep the first action obvious. Delay optional panels, encyclopedias, talent trees, speed controls,
and dense tooltips until the core loop is experienced. Passive contextual prompts are less disruptive
than modal explanations, but only if the underlying feedback already makes the action legible.

## A visual grammar

Use consistent shape, motion, color, icon, and audio families. Do not encode armor, element, or
priority only by color; pair color with silhouette or icon for accessibility. Display targeting
priority and target restrictions on selection. Range previews must use the same inclusion rule as
the simulation so edge cases do not teach distrust.

Camera framing must keep spawn, route, build space, goals, and active crises discoverable. On mobile,
touch targets, safe areas, finger occlusion, and readable text constrain map and HUD design. On PC,
hotkeys, hover inspection, speed control, pause semantics, and ultrawide layouts need deliberate
support.

## Readability test

Pause at an arbitrary moment and ask a new player to identify the next threat, the most endangered
lane, what each nearby tower can hit, why a status is active, and what their next purchase changes.
After a leak, ask for a causal explanation. If the explanation requires hidden debug data, the game
is not yet teaching its own rules.

## Related

- [[tower-defense-core-loop-and-player-decisions]]
- [[tower-defense-economy-and-wave-design]]
- [[tower-defense-common-pitfalls]]
