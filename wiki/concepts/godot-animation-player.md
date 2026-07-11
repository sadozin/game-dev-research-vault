---
title: Godot AnimationPlayer
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[godot-animation-docs]]"
tags: [game-development, godot, animation]
---

# Godot AnimationPlayer

**AnimationPlayer** is Godot's main timeline tool. It stores one or more named animations.
Each animation is a list of **tracks**. Each track points at a node property (or a method) and
holds **keyframes** over time. The engine **interpolates** values between keys.

You can animate almost anything the Inspector shows: position, modulate, UI size, shader
params, exported script vars, and more.

## Mental model

```
AnimationPlayer
  └── Animation "walk"
        ├── Track: Sprite2D:position
        ├── Track: Sprite2D:frame
        └── Track: Method call (footstep SFX)
```

- **Keyframe** = value at a time
- **Track** = one property path over the whole clip
- **Library** = named collection of animations (default `[Global]`)

## Setup rules

1. Add `AnimationPlayer` as a **sibling or child of a logic root**, not as a parent of the
   meshes you transform. AnimationPlayer is a bare `Node`; putting 2D/3D nodes under it breaks
   normal transform inheritance.
2. Create an animation (Animation panel → New).
3. Select a target node → key property buttons in the toolbar or key icons in the Inspector.
4. Set length, insert second keys, press Play.

```gdscript
$AnimationPlayer.play("walk")
$AnimationPlayer.play_backwards("open")
# section between markers (when set up in editor):
# $AnimationPlayer.play_section_with_markers("start_mark", "end_mark")
```

## Interpolation and update modes

| Setting | Meaning |
|---|---|
| Continuous | Update property every frame while playing |
| Discrete | Snap only on keyframes (good for sprite frames) |
| Linear / Cubic | How values blend between keys |
| Loop clamp / wrap | How looping joins end → start |

**Cubic** often feels more organic for motion; **linear** feels mechanical. Sprite sheet frames
usually want **discrete** updates.

## RESET animation

A special animation named exactly `RESET` (case-sensitive) stores the default pose at time 0.
It restores sensible values when you save the scene and helps blending systems know rest pose.
Enable **Reset On Save** on the player when you want the saved scene to store reset values.

## Autoplay and libraries

- **Autoplay on load** plays one clip when the scene starts.
- Put shared clips in animation libraries so multiple players can reuse the same walk set.

## Markers

Markers name points on the timeline so one long authored clip can play as sections (attack
startup vs recovery) without duplicating the whole animation asset.

## When to use what (roadmap)

| Need | Tool |
|---|---|
| UI fade, simple motion, prop spin | AnimationPlayer tracks |
| Character state machine (idle/run/attack blend) | AnimationTree (next depth after this page) |
| Imported skeletal clips from glTF | Skeleton3D + imported animations in player/tree |
| Code-only tweens | `Tween` / `create_tween()` for one-off transitions |

Learn AnimationPlayer solidly before AnimationTree. Tree builds on the same animation
resources.

## Why it works

Property tracks unify 2D, 3D, and UI animation under one mental model. Keyframes stay editable
in the editor without rewriting scripts for every polish pass.

## The catch

- Animating the wrong node path is common — double-click the track path to fix.
- Fighting scripts that also write the same property every frame cancels the animation.
- Huge AnimationPlayers with hundreds of unrelated clips become hard to maintain — split by
  character or system.

## Related

- [[godot-nodes-and-scenes]] · [[godot-gdscript-scripting]] · [[character-animation-graphs]] ·
  [[godot-asset-placement]]
