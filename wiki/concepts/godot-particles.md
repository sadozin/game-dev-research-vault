---
title: Godot particle systems
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[godot-systems-batch-2-docs]]"
tags: [game-development, godot, rendering]
---

# Godot particle systems

Particles simulate many short-lived sprites/meshes: sparks, smoke, magic, dust. Each particle
shares base behavior; **randomness** makes the system feel organic.

## Node choices

| | GPU particles | CPU particles |
|---|---|---|
| 2D | `GPUParticles2D` | `CPUParticles2D` |
| 3D | `GPUParticles3D` | `CPUParticles3D` |
| Best for | High counts, effects | Compatibility, low-end, GPU-bound scenes |
| Config | `ParticleProcessMaterial` (+ optional shader) | Properties on node |

**Default recommendation:** GPU particles unless you have a measured reason not to. You can
convert CPU↔GPU in the editor toolbar (GPU-only features may be lost).

## Minimum setup (2D)

1. Add `GPUParticles2D`.
2. Process Material → **New ParticleProcessMaterial**.
3. Assign **Texture** (or flipbook — see below).
4. Tune lifetime, amount, emission shape, gravity, initial velocity, color ramps.

Without a process material, the node warns and shows a lone white dot.

## Time parameters (shared concepts)

| Property | Meaning |
|---|---|
| Lifetime | Seconds each particle lives |
| One Shot | Emit then stop (explosions) |
| Preprocess | Simulate N seconds before first draw (torches already lit) |
| Speed Scale | Global time multiplier |
| Explosiveness | 0 = steady stream; 1 = all at once |
| Amount | Particle budget |

Randomness formula (docs): `initial = param + param * randomness`.

## Drawing

- **Visibility rect/AABB:** if off-screen, particles may not render — generate via editor tool.
- **Local coords:** when on, particles move with emitter; off = world-space trails when parent
  moves.
- **Draw order:** index vs lifetime.

## Flipbook textures (smoke/fire)

1. Texture = spritesheet.  
2. Node Material → `CanvasItemMaterial` with **Particle Animation**, set H/V frames.  
3. Configure animation section in process material.  
4. If background is black not alpha, use **Add** blend or fix texture alpha.

## 3D extras

- **Attractors:** box/sphere/vector field pull or push particles.  
- **Colliders:** box/sphere; SDF for indoors; heightfield for large outdoors.  
- **Sub-emitters, trails, turbulence** for advanced looks (dedicated docs pages).  
- Collision is **visual particle collision**, not CharacterBody physics.

## Performance instincts

- Cap `amount`; prefer GPU.  
- Smaller textures / atlases.  
- Disable when far (visibility ranges / manual `emitting = false`).  
- One-shot systems: set emitting, connect `finished` if available, then `queue_free` parent FX
  scene.

## FX scene pattern

```
Explosion.tscn
└── GPUParticles2D (one_shot, explosiveness high)
└── AudioStreamPlayer (SFX)
# instance, add_child, auto-free after max(lifetime, sfx)
```

## AI builder checklist

- [ ] Process material assigned  
- [ ] Visibility bounds generated  
- [ ] One-shot for bursts; looping for ambient  
- [ ] Preprocess for always-on world FX  
- [ ] Not using particles for gameplay hit detection (use Areas)  

## Related

- [[godot-3d-rendering-basics]] · [[godot-shaders-basics]] · [[godot-audio]] ·
  [[godot-ai-build-playbook]]
