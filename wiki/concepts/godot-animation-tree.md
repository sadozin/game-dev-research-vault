---
title: Godot AnimationTree
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[godot-animation-docs]]"
tags: [game-development, godot, animation]
---

# Godot AnimationTree

**AnimationTree** blends and switches animations for complex characters. It does **not** store
clips. Clips live in an **AnimationPlayer**; the tree references that player and outputs blended
poses.

Use AnimationPlayer alone for props/UI. Use AnimationTree when you need locomotion blends,
one-shot attacks layered on walk, or state graphs.

## Setup pattern

1. Import/create clips in `AnimationPlayer`.
2. Add `AnimationTree`, assign `anim_player` path to that player.
3. Choose a **root** node type (StateMachine, BlendSpace2D, BlendTree, …).
4. Set `active = true`.
5. Drive parameters from code each frame / on events.

```
Player (CharacterBody3D)
├── Model (instanced import with AnimationPlayer)
└── AnimationTree  → points at Model/AnimationPlayer
```

## Root node types

| Root | Purpose |
|---|---|
| **StateMachine** | Graph of states + transitions (idle/run/jump/attack) |
| **BlendSpace1D** | Blend along one axis (walk↔run speed) |
| **BlendSpace2D** | Strafe/direction blends (forward/back/left/right) |
| **BlendTree** | Node graph: Blend2, OneShot, TimeScale, Transition… |

## StateMachine essentials

- Connect states with transitions: Immediate / Sync / At End.
- **Xfade Time** for cross-fades.
- **Advance Expression** (Godot 4) for conditions like `is_on_floor() and speed > 0.1`.
- Point **Advance Expression Base Node** at the CharacterBody that owns variables.

```gdscript
@onready var tree: AnimationTree = $AnimationTree
@onready var playback: AnimationNodeStateMachinePlayback = tree.get("parameters/playback")

func _ready() -> void:
    tree.active = true
    playback.start("Idle")  # or connect Start in editor

func _physics_process(delta: float) -> void:
    # update tree params used by advance expressions / blend spaces
    tree.set("parameters/conditions/is_moving", velocity.length() > 0.1)

func attack() -> void:
    playback.travel("Attack")
```

`travel("State")` finds a path through transitions (A*); if none, jumps.

## BlendTree nodes AI uses often

| Node | Use |
|---|---|
| Blend2/3 | Manual mix by float |
| OneShot | Fire attack overlay; `ONE_SHOT_REQUEST_FIRE` |
| TimeScale | Speed up/slow anim |
| TimeSeek | Jump to time |
| Transition | Simplified multi-state switch by name |

```gdscript
tree.set("parameters/OneShot/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
tree.set("parameters/IdleRun/blend_position", speed_ratio)  # BlendSpace1D
```

Parameters are on the **AnimationTree instance**, not on shared graph resources — critical when
many enemies share a tree resource layout.

## RESET and blending quality

Missing tracks in one clip blend toward **0** or bone rest unless `RESET` animation defines
defaults. For humanoids, T-pose rest helps rotation blending. See [[godot-animation-player]] RESET.

## Root motion

If locomotion is baked into the root bone:

1. Select root motion track on AnimationTree.
2. Read deltas: `get_root_motion_position()` / rotation / scale.
3. Apply to CharacterBody (`move_and_slide` with computed velocity).

Visual root bone cancels so feet match authored steps.

## AI builder recipe: third-person character

1. Import glTF with idle, walk, run, jump, attack.
2. AnimationPlayer holds clips; ensure loop flags on locomotion.
3. AnimationTree root = StateMachine: Idle ⇄ Run, Jump, Attack (At End back to Idle/Run).
4. Code sets conditions from CharacterBody velocity and `is_on_floor()`.
5. Attack button → `travel("Attack")` or OneShot.

## Deep recipe: locomotion BlendSpace + StateMachine

### Clip prep

- Idle (loop), Walk (loop), Run (loop) same foot phase if possible.  
- Jump start / fall / land separate or one Jump state At End → Idle.  
- Attack non-loop; transition At End back.  
- RESET animation with default pose for clean blends ([[godot-animation-player]]).  

### Tree layout (recommended)

```
AnimationTree (active)
└── root: StateMachine
      ├── Idle  --(speed > 0.1)--> Locomotion
      ├── Locomotion (BlendSpace1D: Walk@0.0 … Run@1.0)
      ├── Jump
      └── Attack
```

Or root **BlendTree**: StateMachine output → OneShot(Attack) → Output for layered attacks.

### Code each physics frame

```gdscript
@onready var tree: AnimationTree = $AnimationTree
@onready var playback: AnimationNodeStateMachinePlayback = tree["parameters/playback"]

func _physics_process(delta: float) -> void:
    var speed_xz := Vector2(velocity.x, velocity.z).length()
    var grounded := is_on_floor()
    tree["parameters/conditions/is_moving"] = speed_xz > 0.1
    tree["parameters/conditions/is_grounded"] = grounded
    # BlendSpace1D path example:
    tree["parameters/Locomotion/blend_position"] = clampf(speed_xz / run_speed, 0.0, 1.0)
    if not grounded and playback.get_current_node() != "Jump":
        playback.travel("Jump")

func try_attack() -> void:
    playback.travel("Attack")
    # or: tree["parameters/OneShot/request"] = AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE
```

Set Advance Expression Base Node to the CharacterBody. Expressions: `is_moving`,
`is_grounded`, `speed_xz > 0.1` (match property names / snake_case).

### Sync modes for blended walks

When Walk/Run lengths differ, use BlendSpace **Cyclic** sync so feet stay phase-aligned
(docs: Cyclic Mutable / Constant). Prefer similar cycle lengths when possible.

### Root motion locomotion

1. Animator authors movement on root bone.  
2. AnimationTree root motion track selected.  
3. Each frame:

```gdscript
var motion := tree.get_root_motion_position()
# convert to velocity / move_and_slide on CharacterBody3D
velocity = motion / delta  # adjust to your scale and yaw
move_and_slide()
```

Use with caution with pure code velocity — pick **either** root motion **or** code locomotion
as the primary driver.

### Facing

Rotate visual yaw toward `velocity` (or camera-relative move dir) with `lerp_angle` /
basis slerp ([[godot-3d-transforms]]), independent of blend_position.

## Why it works

Tree separates **clip authoring** from **runtime choreography**. State machines match how
gameplay code already thinks about character modes.

## The catch

- Editing shared AnimationNode resources affects all instances — change **parameters** per tree.
- Advance expressions are case-sensitive and need correct base node.
- Jumping to AnimationTree before solid AnimationPlayer clips wastes time.

## Related

- [[godot-animation-player]] · [[character-animation-graphs]] · [[godot-physics-bodies]] ·
  [[godot-asset-placement]]
