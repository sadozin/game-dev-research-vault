---
title: Root motion vs in-place animation
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[unity-root-motion]]"
  - "[[unreal-root-motion]]"
tags: [game-development, animation, unity, unreal]
---

# Root motion vs in-place animation

Two things can decide where a character ends up: the animation, or the code. **Root motion** takes the
displacement authored into the clip and applies it to the character. **In-place** animation authors
the clip with the character running on the spot and lets a movement component or script translate it.
The choice determines which of the two is allowed to be wrong — and the visible symptom of getting it
wrong is the same either way: feet that slide across the ground because the distance the legs cover
and the distance the body travels disagree.

## Why it works

Root motion is derived, not authored directly. Unity separates the **body transform** — the
character's centre of mass — from the **root transform**, which is a projection of it onto the Y
plane, computed at runtime. Each frame the engine computes the *change* in that root transform and
applies the delta to the GameObject; the character moves because the animation says it moved. The
attraction is fidelity: an animator can author a lunge, a roll, or a turn with exactly the arc and
acceleration they intended, and the character will travel exactly that arc. Because the motion comes
from the same clip that moves the legs, foot contact is correct by construction rather than by tuning.

In-place animation inverts the responsibility: code owns the position, and the animation is a
best-effort depiction of it, blended by speed inside the state machine described in
[[character-animation-graphs]]. That keeps movement predictable and cheap to reason about — the speed
is whatever the code says it is, which is exactly what a networked or physics-driven character wants.

Both engines let the two be mixed per clip and per axis rather than chosen globally. Unity's "Bake
Into Pose" keeps a clip's motion inside the pose instead of exporting it to the GameObject, per
component: bake the horizontal position of an idle and its delta is forced to zero, which stops tiny
per-evaluation deltas accumulating into visible drift over many loops; bake a clip's root *rotation*
and it will not rotate the GameObject at all. Unreal's equivalent is a per-asset **Enable Root Motion**
plus an Animation Blueprint **Root Motion Mode**, most usefully "Root Motion from Montages Only" —
locomotion stays code-driven, while montages (attacks, dodges, finishers) drive the character
themselves.

## The catch

Root motion surrenders control over position to the animation data, and gameplay usually wants that
control back. The character now accelerates the way the clip accelerates, so responsiveness is an
authoring problem, not a tuning value; and a clip that must cover a variable distance — walk exactly
*here*, hit a ledge exactly *there* — cannot, without warping. It also interleaves with the physics
state rather than replacing it: Unreal honours root motion on X and Y while gravity owns Z during
walking and falling, and only applies the full motion in flight, so "the animation moves the
character" is true in fewer axes than it sounds.

The costs are concrete. Unreal's root motion moves the Animation Graph update onto the **game thread**
instead of a worker thread — enabling it, in either mode, gives up that parallelism, and on a crowd
that is a frame-time decision as much as an animation one. In multiplayer, root motion and prediction
pull against each other: the authoritative position now depends on animation state, which the client
and server must agree on, and reconciling a mispredicted position mid-montage is far messier than
reconciling a velocity — the replay step in [[client-prediction-and-reconciliation]] has to reproduce
the animation too. This is why "root motion from montages only" is the common shipping compromise:
the predictable, continuously-corrected locomotion stays code-driven, and only the discrete,
short-lived, gameplay-authoritative actions borrow the animation's displacement.

In-place has the opposite failure, and it is the familiar one: the code picks a speed the animation
was not authored for, the feet slide, and no amount of blend tuning fully hides it. The honest fixes
are to author the clip at the speed the code actually uses, scale playback rate with speed, or lock
the feet with IK — not to keep nudging the multiplier.

## In practice

Default to in-place locomotion driven by code, and use root motion for discrete, self-contained
actions where the exact arc *is* the gameplay: attacks, dodges, vaults, mantles, cinematic
traversals. That maps cleanly onto Unreal's "Root Motion from Montages Only" and onto Unity's
per-clip Bake Into Pose settings, and it keeps the parts of the game that must be predicted and
corrected over the network on the side where prediction is cheap.

Set the vertical reference deliberately: Unity's root transform can track the **Feet**, matching root
Y to the lowest foot each frame so the blend point stays at ground level and characters do not float
when transitioning between clips authored at different heights. Bake the horizontal delta of looping
idles to zero so they cannot drift. And when feet slide, measure before tuning — compare the distance
the clip's root actually travels per second against the speed the code is applying; one of the two
numbers is the bug, and the blend tree is usually innocent.
