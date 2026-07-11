---
title: Godot spatial shaders
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[godot-systems-batch-4-docs]]"
  - "[[godot-shaders-docs]]"
tags: [game-development, godot, rendering]
---

# Godot spatial shaders

`shader_type spatial` is Godot's 3D material language. Prefer writing **material parameters**
and letting Godot light them (PBR), not reinventing a full light model—unless you need
`render_mode unshaded` or a custom `light()`.

Builds on [[godot-shaders-basics]].

## Where materials attach

| Place | Effect |
|---|---|
| Mesh surface material | Shared by all MeshInstance3Ds using that mesh |
| MeshInstance3D override / `material_override` | Per-instance look, same mesh |

Convert StandardMaterial3D → ShaderMaterial (right-click) to learn generated code.

## Minimal structure

```glsl
shader_type spatial;
// render_mode unshaded, cull_disabled; // optional

uniform float height_scale = 0.5;
uniform sampler2D noise : source_color;

varying vec2 tex_position;

void vertex() {
    tex_position = VERTEX.xz * 0.5 + 0.5;
    float h = texture(noise, tex_position).r;
    VERTEX.y += h * height_scale;
}

void fragment() {
    ALBEDO = vec3(0.2, 0.5, 0.2);
    ROUGHNESS = 0.9;
    // NORMAL_MAP = texture(normalmap, tex_position).rgb;
}
```

```gdscript
mesh.material.set_shader_parameter("height_scale", 0.8)
```

Uniform names must match exactly.

## Processor roles (3D)

| Function | Job |
|---|---|
| `vertex()` | Move `VERTEX`, write `NORMAL`, pass `varying`s, particles `INSTANCE_CUSTOM` |
| `fragment()` | `ALBEDO`, `ROUGHNESS`, `METALLIC`, `EMISSION`, `ALPHA`, `NORMAL_MAP`, … |
| `light()` | Optional custom per-light response (skipped if unshaded / vertex lighting) |

**If you displace vertices**, original mesh normals are wrong → recompute `NORMAL` in vertex
or sample `NORMAL_MAP` in fragment (as in official heightmap tutorial).

## Important fragment outs (set only what you need)

Godot strips unused lighting features. Common writes:

- `ALBEDO`, `ALPHA`  
- `ROUGHNESS`, `METALLIC`, `SPECULAR`  
- `EMISSION`  
- `NORMAL` / `NORMAL_MAP`  
- `AO`, rim, clearcoat, subsurface (when using those pipelines)  

## Useful render modes

| Mode | Why |
|---|---|
| `unshaded` | Fast; albedo only |
| `cull_disabled` | Double-sided foliage |
| `blend_add` | Fire/magic; often `fog_disabled` |
| `depth_draw_opaque` / prepass alpha | Transparency sorting help |
| `world_vertex_coords` | Vertex data in world space |
| `skip_vertex_transform` | Manual MVP (advanced) |
| `vertex_lighting` | Cheaper mobile-style lighting |
| `shadows_disabled` | Receive no shadows (still may cast) |

## Varyings

Pass vertex → fragment:

```glsl
varying vec3 world_pos;
void vertex() {
    world_pos = (MODEL_MATRIX * vec4(VERTEX, 1.0)).xyz;
}
```

## TIME and animation

`TIME` is global seconds (time_scale affected; not pause). For pause-independent time, drive a
global uniform from GDScript.

## Performance instincts

- Prefer StandardMaterial until custom is required.  
- Heavy `texture()` noise in vertex on dense meshes costs.  
- Transparent spatial materials sort poorly — design opaque when possible.  
- Profile on target GPU ([[godot-debug-and-profiler]]).  

## AI builder ladder

1. Tint/flash with StandardMaterial.  
2. Simple `canvas_item` effects for 2D.  
3. Spatial `ALBEDO` + uniforms.  
4. Vertex displacement + normal fix.  
5. Custom `light()` / advanced render modes last.  

## Related

- [[godot-shaders-basics]] · [[godot-3d-rendering-basics]] · [[godot-particles]] ·
  [[texture-baking-for-games]]
