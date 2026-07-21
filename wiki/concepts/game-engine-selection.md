---
title: Game engine selection
type: concept
status: active
created: 2026-07-11
updated: 2026-07-20
verified: 2026-07-20
sources:
  - "[[unity-engine-architecture]]"
  - "[[unreal-blueprint-cpp]]"
  - "[[godot-design-philosophy]]"
tags: [game-engine, unity, unreal, godot, decision, game-development, mobile]
---

# Game engine selection

Choose an engine from the game's technical needs, the team's implementation language and content
workflow, shipping targets, and the cost of changing an existing architecture. Do not choose from
visual quality claims or AI integration alone.

## Why it works

Unity is a C#-centric workflow over a native core; Unreal is a C++ foundation designed to work
with Blueprint extensions; Godot is a MIT-licensed scene-composition engine with first-class
GDScript and separate 2D/3D renderers ([[godot-engine-workflow]]). Unity fits teams that want C#
and a large store/ecosystem. Unreal fits teams that want C++ systems with Blueprint content tools
and a high-end production renderer. Godot fits teams that want open-source licensing, lightweight
tooling, scene nesting as the main reuse model, and a gentle scripting path. All three require
profiling and target-device validation.

## Mobile-specific guidance

When the primary target is iOS/Android, the engine choice carries extra weight because mobile
amplifies the differences. See [[mobile-game-development]] for the full landscape.

**Unity** has the largest mobile market share and the most mature mobile ecosystem: URP is the
mobile-first renderer, IL2CPP compiles to native C++, and the plugin ecosystem covers every ad
network, analytics SDK, and store integration. The runtime fee revision (2024) moved to a
per-seat model, removing the per-install controversy. Best default for F2P mobile games that
need ad mediation, IAP, and LiveOps tooling out of the box.

**Godot** is the lightweight choice: small binary (~30–50 MB vs Unity's 80–150 MB), no
licensing fees, fast iteration, and the Compatibility renderer targets low-end devices via
OpenGL ES 3.0. C# support on mobile is experimental — GDScript is the reliable path. The
plugin ecosystem is smaller, so ad/analytics integrations may need manual work. Best for
2D, casual, hyper-casual, and indie mobile games where binary size and iteration speed
matter more than SDK breadth. See [[godot-mobile-export]] for the full export workflow.

**Unreal** targets high-fidelity mobile (PUBG Mobile, Fortnite Mobile). The heaviest binary
(150+ MB), highest memory footprint, and longest build times of the three. Forward renderer
with Vulkan/Metal. Best when visual quality is the differentiator and the target is
mid-to-high-end devices only. 5% royalty after $1M revenue. Overkill for 2D or casual games.

**Decision shortcut for mobile:**

| Game type | Recommended engine |
|---|---|
| 2D casual / puzzle / hyper-casual | Godot (lightweight) or Unity (ecosystem) |
| 2D mid-core / RPG / strategy | Unity (URP, plugin ecosystem) |
| 3D stylized / mid-fidelity | Unity (URP) or Godot (Mobile renderer) |
| 3D high-fidelity / open world | Unreal or Unity (HDRP with caveats) |
| Multiplayer competitive | Unity (netcode, matchmaking SDKs) |
| Prototype / game jam | Godot (fastest iteration, zero setup) |

## The catch

Switching engines resets more than rendering. It changes asset import, build, UI, networking,
testing, editor tooling, team skills, and every integration. A live project should change engines
only for a demonstrated blocker that the existing architecture cannot reasonably solve.

## Related

- [[unity-engine-workflow]] · [[unreal-engine-workflow]] · [[godot-engine-workflow]]
- [[mobile-game-development]] · [[godot-mobile-export]]
