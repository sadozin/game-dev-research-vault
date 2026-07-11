---
title: Godot TileSets
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[godot-systems-batch-4-docs]]"
tags: [game-development, godot, assets, 2d]
---

# Godot TileSets

A **TileSet** is the catalog of paintable tiles. A **TileMapLayer** places those tiles in a
level ([[godot-tilemaps]]). Author the TileSet carefully once; many levels reuse it as an
**external** `.tres`.

## Create from a tilesheet

1. Add TileMapLayer → new TileSet resource.  
2. Set **tile size** (and shape: square/iso/hex) **before** atlas creation.  
3. Open TileSet panel → drag image → **create tiles automatically**.  
4. Erase unwanted auto tiles; set atlas margins/separation if the sheet has padding.  
5. Leave **Use Texture Padding** on to reduce bleed when filtering.  

Fully transparent regions are skipped by auto-create.

Multiple sheets → multiple **atlases** in one TileSet. Merge atlases later with the merging tool
(tile proxies map old IDs).

## Scene tiles

**Scenes Collection**: place full scenes (particles, shops, AudioStreamPlayer2D) as cells.

**Cost:** each placement instances a scene — heavier than atlas tiles. Use sparingly; prefer
atlases for pure sprites.

## Physics / navigation / occlusion layers

On the TileSet resource (via TileMapLayer inspector):

1. Add **Physics Layer** (collision).  
2. Optionally **Navigation Layer**, **Occlusion Layer**.  
3. Select mode → edit polygons per tile (F = default rect).  

Polygon tools: add/remove points, flip/rotate via menu. **Paint** the same collision poly across
many tiles with property painting — do not hand-draw every solid block.

Nav on tiles is convenient but often inferior to baked regions ([[godot-navmesh-baking]]).

## Custom data layers

Game-specific per-tile metadata (damage/sec, destructible, footstep id):

1. Add custom data layers on TileSet (typed properties).  
2. Set values on tiles / paint them.  
3. At runtime read via TileMapLayer tile data APIs.  

All instances of that tile share data; variants need **alternative tiles**.

## Terrains (autotile replacement)

Terrains auto-pick edge/corner variants:

1. Create **terrain set** + one or more **terrains**.  
2. Assign tiles terrain set/id.  
3. Configure **peering bits** (which neighbors must match; `-1` = empty).  
4. Paint in TileMap **Terrain** mode (Connect vs Path — see [[godot-tilemaps]]).  

Modes: Match Corners and Sides / Corners / Sides (Godot 3 bitmask-like).

## Alternative tiles

Right-click atlas tile → **Create Alternative Tile** for modulate, materials, z-index, y-sort
origin, flips (note: placement rotation tools in TileMap often cover simple flip/rotate now).

Base properties are **not** inherited — reconfigure what you need.

## Bulk editing

| Method | When |
|---|---|
| Multi-select + inspector | Change several properties on many tiles |
| Property painting | Stamp one property (esp. collision) |

## AI builder checklist

- [ ] External TileSet saved for reuse  
- [ ] Tile size set before atlas  
- [ ] Physics layer + painted collisions on solids  
- [ ] Custom data for hazards/gameplay tags  
- [ ] Terrains for auto edges if art supports it  
- [ ] Scene tiles only for special props  
- [ ] Player collision masks match tile physics layer  

## Related

- [[godot-tilemaps]] · [[godot-physics-bodies]] · [[godot-navmesh-baking]] ·
  [[godot-genre-build-checklists]]
