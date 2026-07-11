---
title: Godot TileMaps
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[godot-nodes-and-scenes]]"
tags: [game-development, godot, assets, 2d]
---

# Godot TileMaps

A **TileMap** paints a grid of tiles for levels. In Godot 4.x the modern unit is
**TileMapLayer** nodes using a shared **TileSet** resource. Benefits: fast painting, huge maps,
per-tile collision/occlusion/navigation data.

## Pipeline

1. Build or import a **TileSet** (atlas of tiles + physics/nav polygons per tile).
2. Save TileSet as **external** `.tres` for reuse across levels.
3. Add one or more **TileMapLayer** nodes; assign TileSet.
4. Paint with TileMap editor (paint, line, rect, bucket, terrains, patterns).

## Multiple layers

Use separate TileMapLayer nodes for:

- Background décor  
- Ground / collision  
- Foreground overlay  
- Hazard tiles  

One cell per layer at a coordinate; stack layers for overlap. Reorder via scene tree.

## Painting tools (efficiency)

| Tool | Shortcut habit |
|---|---|
| Paint | LMB place, RMB erase |
| Line | Shift+drag |
| Rectangle | Ctrl+Shift+drag |
| Bucket | Flood fill (contiguous option) |
| Picker | Ctrl+click existing tile |
| Patterns | Copy selection to Patterns tab; stamp multi-tile props |
| Terrains | Autotile-like connections (Connect vs Path modes) |
| Scattering | Random pick + optional empty chance for detail |

## Physics on tiles

Enable collision on the layer; define collision shapes **in the TileSet** per tile. Prefer
tile collision for terrain; use StaticBody scenes for unique props.

Do not fight the grid with dozens of manual StaticBody walls for every floor tile.

## Navigation note

TileMap navigation is convenient but **not** the best pathfinding quality/performance for
complex games. Prefer baking a **NavigationRegion2D** mesh from the level design and disabling
tile navigation for agents ([[godot-navigation]]). Do not stack multiple navmeshes on one map.

## Scene tiles

TileSet can place **scene tiles** (particles, lights, interactive props) as cells — powerful for
decorating, heavier than pure atlas tiles.

## Missing tiles

If TileSet IDs go missing, placeholders show in editor; data remains so re-adding IDs restores
art. Safe for refactors if IDs stable.

## AI builder checklist for 2D levels

- [ ] External TileSet resource shared by levels  
- [ ] Collision layer vs décor layer split  
- [ ] Physics layers match player mask  
- [ ] Terrains configured for ground/auto walls if using autotile art  
- [ ] Camera limits set to map bounds  
- [ ] Navigation approach chosen (grid A* vs baked region)  

## Related

- [[godot-asset-placement]] · [[godot-physics-bodies]] · [[godot-navigation]] ·
  [[godot-ai-build-playbook]]
