---
title: Godot navigation and pathfinding
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[godot-navigation-docs]]"
tags: [game-development, godot]
---

# Godot navigation and pathfinding

Navigation answers: **how does an actor walk from A to B without walking through walls?**
Godot offers two families of tools. Pick based on how free movement is in your game.

## Two approaches

| Approach | Classes | Best when |
|---|---|---|
| **Point graph** | `AStar2D`, `AStarGrid2D` (3D: `AStar3D`) | Grid/cell games; only certain positions matter |
| **Navigation mesh** | `NavigationServer2D/3D` + regions/agents | Actors may stand anywhere inside walkable polygons |

Mesh navigation scales better for large open areas: one polygon can replace thousands of grid
cells.

## Mesh navigation pieces (2D names; 3D swaps the suffix)

| Piece | Role |
|---|---|
| `NavigationRegion2D` | Holds a `NavigationPolygon` (walkable area) |
| `NavigationPolygon` | The mesh data; draw and **Bake** in editor |
| `NavigationAgent2D` | Helper on a moving character for path + avoidance API |
| `NavigationLink2D` | Teleport/jump edge between distant mesh points |
| `NavigationObstacle2D` | Affects **avoidance velocity**, not the baked mesh itself |

**Important:** obstacles for avoidance ≠ holes in the navmesh. To block pathfinding, edit the
navigation polygon (or disable regions). To make agents steer around each other, use agents +
optional obstacles.

## Minimal setup (2D pattern)

1. Add `NavigationRegion2D` → new `NavigationPolygon`.
2. Draw walkable area; leave **margin** from walls so the agent center does not clip collision.
3. Click **Bake NavigationPolygon**.
4. Character: `CharacterBody2D` + collision + `NavigationAgent2D` child.
5. After the tree is ready, wait one physics frame, then set `target_position`.

```gdscript
extends CharacterBody2D

@export var movement_speed := 200.0
@onready var agent: NavigationAgent2D = $NavigationAgent2D

func _ready() -> void:
    agent.path_desired_distance = 4.0
    agent.target_desired_distance = 4.0
    actor_setup.call_deferred()

func actor_setup() -> void:
    await get_tree().physics_frame  # server must sync first
    agent.target_position = Vector2(60, 180)

func _physics_process(_delta: float) -> void:
    if agent.is_navigation_finished():
        return
    var next := agent.get_next_path_position()
    velocity = global_position.direction_to(next) * movement_speed
    move_and_slide()
```

On the **first** frame, the navigation map is empty — path queries return nothing until sync.

## AStar grid (when cells are enough)

Use `AStarGrid2D` for tile maps and dungeon cells: mark solid cells, query paths between cell
coordinates. Simpler than baking polygons when gameplay is already grid-locked.

## Layers

Navigation has its own **navigation_layers** bitmasks (separate from physics layers). Regions
and agents can filter which maps/regions they use.

## Why it works

Navmeshes describe *where the feet can be*, not every blocked pixel. Agents query the server
for the next corner and your CharacterBody still handles the actual movement/collision
([[godot-physics-bodies]]).

## The catch

- Baking too tight to walls causes stuck path followers — add margin.
- Expecting NavigationObstacle alone to open a hole in the mesh will fail.
- Mixing grid logic and free navmesh without a clear design creates two competing path systems.

## Related

- [[godot-physics-bodies]] · [[godot-nodes-and-scenes]] · [[godot-gdscript-scripting]]
