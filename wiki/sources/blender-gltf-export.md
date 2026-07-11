---
title: "Source: Blender Manual — glTF 2.0 export"
type: source
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "raw/blender-gltf-export.md"
tags: [source, blender, gltf, assets]
---

# Source: Blender Manual — glTF 2.0 export

- **Author:** Blender Foundation contributors
- **Published:** Blender Manual 3.3
- **URL:** https://docs.blender.org/manual/en/3.3/addons/import_export/scene_gltf2.html
- **Retrieved:** 2026-07-11
- **Raw:** `raw/blender-gltf-export.md` (provenance only)

## Summary

glTF is a delivery format designed around real-time graphics buffers, not a lossless copy of a
Blender scene. Export triangulates quads and n-gons, and seams in UVs, normals, or flat-shaded
edges split vertices. Runtime vertex count can therefore be substantially higher than the number
visible in Blender's mesh statistics. Curves and other non-mesh data need conversion before they
can travel through this export path.

The supported material path is metal/roughness PBR with base color, metallic, roughness, baked
ambient occlusion, tangent-space normal, and emissive inputs. glTF's ORM convention can place AO,
roughness, and metallic data in one texture's R, G, and B channels. The exporter is deliberately
strict about supported node arrangements, making it a useful validation path even when a game
uses a custom importer.

## Compiled into

- [[blender-game-asset-pipeline]] — asset validation and real-time geometry cost
- [[texture-baking-for-games]] — baked PBR maps and normal-map conventions
- [[game-performance-profiling]] — measure the exported asset, not only the `.blend`
