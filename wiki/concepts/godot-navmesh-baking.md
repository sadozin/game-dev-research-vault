---
title: Godot navigation mesh baking
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[godot-systems-batch-3-docs]]"
tags: [game-development, godot]
---

# Godot navigation mesh baking

A **navigation mesh** is the walkable surface for an agent's **center point**. Physics meshes
and visuals are ignored unless you **bake** them into the navmesh. Agents clip walls when the
mesh is too close — shrink with **`agent_radius`**.

Builds on [[godot-navigation]].

## Core truth

> Pathfinding only knows what you baked. A rock collision shape is invisible to navigation
> until it becomes an obstruction in the navmesh.

## Bake with NavigationRegion (easiest)

### 2D

1. `NavigationRegion2D` + `NavigationPolygon` resource.  
2. Draw traversable outline **or** parse geometry from scene.  
3. Set `agent_radius` margin.  
4. Editor **Bake** (or `bake_navigation_polygon(on_thread)`).  

Parse controls on the polygon resource: `parsed_geometry_type`, `collision_mask`,
`source_geometry_mode`, `source_geometry_group_name`, `cell_size`.

### 3D

1. `NavigationRegion3D` + `NavigationMesh` resource.  
2. Geometry under region (or group-filtered).  
3. Bake with `agent_radius`, `agent_height`, `agent_max_climb`, `agent_max_slope`,
   `cell_size` / `cell_height`.  

**Warning:** tiny cell sizes explode voxel count → freezes/crashes.

```gdscript
# Runtime re-bake (3D example)
$NavigationRegion3D.bake_navigation_mesh(true)  # on_thread
```

## Parse vs bake cost

| Step | Threading | Cost |
|---|---|---|
| Parse SceneTree geometry | **Main thread only** | High if TileMaps/meshes (GPU readback) |
| Bake from source data | Can be async/background | Usually OK |

**Runtime tip:** prefer parsing **physics shapes** over fancy visual meshes. Or cache
`NavigationMeshSourceGeometryData*` and rebake without re-parse.

## NavigationServer pipeline (advanced)

1. `parse_source_geometry_data(...)` → fill source geometry resource.  
2. `bake_from_source_geometry_data_async(...)` → navmesh.  
3. `region_set_navigation_mesh` / polygon on a region RID.  

Reuse one source geometry for **multiple agent radii** (different bakes).

## Large worlds: chunks

For open worlds, bake **chunks** with:

- **Baking bound** (Rect2 / AABB) — limit source geometry  
- **border_size** — trim outer band after radius offsets so chunk edges **align**

Without border_size, agent_radius creates **gaps** between chunks. Bounds must overlap neighbor
geometry enough for clean borders. 3D border is mainly XZ.

## Common failures

| Symptom | Cause / fix |
|---|---|
| Agent stuck on walls | Increase agent_radius margin; leave gap to collision |
| Paths through props | Bake static colliders; obstacles set to affect bake |
| 2D flipped holes | Nested same-type outlines — avoid body-in-body nesting |
| 3D mesh inside solid | Voxel "occupied" issue — fill interior or use bake obstacles |
| FPS hit on rebake | Parse TileMap every frame — cache source geometry |
| Empty first-frame paths | Wait physics frame after map sync ([[godot-navigation]]) |

## Debug

Debug menu → **Visible Navigation** / **Visible Avoidance** while running.

## AI builder recipe

1. Prototype with hand-drawn NavigationPolygon.  
2. Switch to collision-based bake for production levels.  
3. Match `agent_radius` to CharacterBody collision size.  
4. Disable TileMap built-in nav when using baked regions.  
5. Chunk only when single mesh is too large.  

## Related

- [[godot-navigation]] · [[godot-tilemaps]] · [[godot-physics-bodies]] · [[godot-debug-and-profiler]]
