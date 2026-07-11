---
title: Godot shaders basics
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[godot-shaders-docs]]"
tags: [game-development, godot, rendering]
---

# Godot shaders basics

A **shader** is a small program that runs on the **GPU**. Godot draws almost everything
through shaders. You write them when built-in materials are not enough: outlines, dissolve,
water distortion, custom lighting, stylized 2D effects.

Shaders think differently from GDScript: work happens **in parallel per vertex or per pixel**,
with little shared state and **no storing data between frames** inside the shader the way a
script stores variables on a node.

## GDScript loop vs shader

GDScript mental model: "for every pixel, set color."  
Shader mental model: "I *am* one pixel (or vertex); set *my* outputs."

```gdscript
# CPU style (concept only — do not do this for full-screen art)
for x in width:
    for y in height:
        set_color(x, y, c)
```

```glsl
// GPU style
void fragment() {
    COLOR = vec4(1.0, 0.0, 0.0, 1.0);
}
```

## First line: shader type

```glsl
shader_type spatial; // 3D
// or: canvas_item, particles, sky, fog, texture_blit
```

| Type | Used for |
|---|---|
| `spatial` | 3D meshes / materials |
| `canvas_item` | 2D sprites, UI-like canvas draw |
| `particles` | GPU particles |
| `sky` | Sky / radiance |
| `fog` | Volumetric fog volumes |

Wrong type → wrong builtins and broken expectations.

## Processor functions

| Function | Runs | Typical job |
|---|---|---|
| `vertex()` | Per mesh vertex | Move/warp positions; pass data |
| `fragment()` | Per covered pixel | Albedo, roughness, normal, alpha |
| `light()` | Per pixel **per light** | Custom lighting response |

Optional render modes (after the type):

```glsl
shader_type spatial;
render_mode unshaded, cull_disabled;
```

`unshaded` skips standard lighting. Cull modes control backfaces.

## Minimal 2D example (concept)

```glsl
shader_type canvas_item;

uniform vec4 tint : source_color = vec4(1.0, 0.5, 0.5, 1.0);

void fragment() {
    vec4 tex = texture(TEXTURE, UV);
    COLOR = tex * tint;
}
```

Assign a `ShaderMaterial` (or Shader on CanvasItem material) that uses this shader. Expose
`uniform`s to the Inspector for designers.

## Workflow for learning

1. Prefer **StandardMaterial3D** / sprite modulate until you need a true custom effect.
2. Start with `canvas_item` toys (tint, wave UV, flash).
3. Move to `spatial` with `unshaded` experiments, then proper PBR outputs.
4. Read the official shading language reference for types, builtins (`UV`, `NORMAL`, `TIME`).
5. Profile — complex fragment work multiplies by screen coverage ([[game-performance-profiling]]).

## Why it works

Godot hides GPU boilerplate and gives high-level material slots (`ALBEDO`, `ROUGHNESS`, …).
Unused outputs get stripped, so simple shaders stay cheap.

## The catch

- Debugging shaders is harder than GDScript (limited print-style feedback).
- Per-pixel lights × `light()` can explode cost.
- Mobile may force vertex shading paths where `light()` behaves differently.
- Copy-pasting GLSL from the web often fails — Godot's language is close to GLSL but not
  identical.

## Related

- [[godot-3d-rendering-basics]] · [[godot-ui-controls]] · [[real-time-lighting-budget]] ·
  [[texture-baking-for-games]]
