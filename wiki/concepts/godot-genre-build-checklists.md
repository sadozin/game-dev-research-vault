---
title: Godot genre build checklists
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[godot-physics-docs]]"
  - "[[godot-systems-batch-2-docs]]"
tags: [game-development, godot]
---

# Godot genre build checklists

Concrete **node stacks and feature order** for common genres so models scaffold faster and
skip wrong architecture. Every checklist assumes you already know the playbook
([[godot-ai-build-playbook]]).

## Shared skeleton (all genres)

```
Main
├── World
└── GUI (CanvasLayer)
Autoloads (optional): Game, Audio, Save, Events
```

- Input Map actions defined first  
- Separate player scene  
- One vertical slice before systems sprawl  

---

## Side-view platformer (2D)

### Nodes

```
Player (CharacterBody2D)
├── Sprite2D / AnimatedSprite2D
├── CollisionShape2D
├── Camera2D
├── Hurtbox (Area2D)
└── AnimationPlayer or AnimationTree
Level (Node2D)
├── TileMapLayer(s)  OR StaticBody geometry
├── Checkpoints (Area2D / Marker2D)
└── Hazards / enemies (instances)
```

### Build order

1. Move + jump + `is_on_floor`  
2. Tile collision or StaticBody level  
3. Camera limits  
4. One enemy + death/respawn  
5. Coins + UI score  
6. Coyote time + jump buffer  
7. Animation states  
8. Pause menu + save checkpoint  

### Key settings

- `motion_mode` grounded; `up_direction = Vector2.UP`  
- Gravity via `get_gravity()` or custom  
- One-way platforms if needed  
- Layers: world / player / enemy / pickup  

### Links

[[godot-physics-bodies]] · [[godot-tilemaps]] · [[godot-animation-player]] · [[godot-ui-controls]]

---

## Top-down action (2D)

### Nodes

```
Player (CharacterBody2D)
├── Sprite2D
├── CollisionShape2D
├── Camera2D
└── WeaponPivot (Node2D) → Hitbox Area2D
```

### Build order

1. 8-way `get_vector` movement + `move_and_slide`  
2. Face mouse or move direction  
3. Attack one-shot animation + hitbox enable frames  
4. Enemy knockback + health  
5. Room/scene transition doors  
6. Inventory or simple weapon swap  
7. Minimap optional later  

### Key settings

- Often `motion_mode = floating` (no floor logic)  
- Separate attack hurt layers from body collision  
- Y-sort for depth: enable Y sort on parent and sprites  

---

## Twin-stick shooter (2D)

### Build order

1. Left stick / WASD move  
2. Right stick / mouse aim independent of move  
3. Projectile scene pool (prototype: instantiate)  
4. Enemy spawn waves (timer + markers)  
5. Camera shake on hit (tween offset)  
6. Upgrade level-up loop  
7. Audio randomizer for shots  

### Projectiles

- CharacterBody + `move_and_collide` **or** Area2D continuous  
- Lifetime timer; free off-screen  
- Layers: player_bullet vs enemy_bullet  

[[godot-input-handling]] · [[godot-particles]] · [[godot-audio]]

---

## Top-down RPG / adventure (2D)

### Build order

1. Grid or free movement (choose early)  
2. Interact ray/area in facing direction  
3. Dialogue UI (AcceptDialog custom or Label + panel)  
4. NPC scenes with Resource dialogue lines  
5. Party/stats Resources ([[godot-resources-and-data]])  
6. Save/load story flags ([[godot-save-and-load]])  
7. TileMap terrains for world  
8. Quests as data Resources, not hard-coded if-else forests  

### Avoid

- Putting all dialogue strings only in scripts — use Resources/JSON  

---

## Third-person action (3D)

### Nodes

```
Player (CharacterBody3D)
├── CollisionShape3D
├── Visual (instanced model + AnimationPlayer)
├── AnimationTree
├── SpringArm3D
│   └── Camera3D
└── Interaction ray (RayCast3D)
```

### Build order

1. Move on XZ + gravity + jump  
2. SpringArm camera pivot from mouse/gamepad  
3. Align visual yaw to velocity or camera  
4. Import glTF + AnimationTree idle/run  
5. One interactable StaticBody + Area  
6. Simple combat later  

[[godot-3d-rendering-basics]] · [[godot-animation-tree]] · [[godot-asset-placement]]

---

## First-person (3D)

### Nodes

```
Player (CharacterBody3D)
├── CollisionShape3D
├── Head (Node3D)  # pitch
│   └── Camera3D
│       └── RayCast3D (interact/shoot)
└── WeaponManager
```

### Build order

1. Mouse capture + look (yaw body, pitch head)  
2. WASD relative to yaw  
3. Interact ray  
4. Weapon hitscan or projectile  
5. Bob/sway polish last  

---

## Puzzle / narrative (2D or 3D)

### Build order

1. Click/tap or simple move  
2. Stateful interactables (`is_solved` + signals)  
3. Inventory item IDs  
4. Door unlock conditions as data  
5. Save after each room  
6. Minimal combat unless genre needs it  

---

## Local co-op / multiplayer genre notes

- Get **one** player perfect, then spawn Player with `set_multiplayer_authority(peer_id)`.  
- Lobby before arena ([[godot-multiplayer]]).  
- Server spawns world pickups; clients request interact.  
- Determinism is hard — prefer authority over lockstep for action games.  

---

## Vertical slice definition (any genre)

Ship a slice when a new player can:

1. Start from main menu  
2. Complete one loop (reach flag / kill wave / solve room)  
3. See UI feedback  
4. Die/fail and retry  
5. Quit cleanly  

Everything else is post-slice.

## Related

- [[godot-ai-build-playbook]] · [[godot-engine-workflow]] · [[godot-physics-bodies]] ·
  [[godot-scene-architecture]]
