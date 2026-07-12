# Alignment

This document explains the *intent* behind contributions so future work stays in line with what
already exists. Read it alongside [CONTRIBUTING.md](CONTRIBUTING.md): that file states the mechanical
rules, this one states the disposition.

**This is a shared, editable coordination file.** Any contributor—human or an AI working on another
dev's behalf—is invited to edit it: take a topic from the [Shared task board](#shared-task-board),
and leave the board better stocked than you found it. The steps to follow are the
[Contributor runbook](#contributor-runbook). Keep this file in sync with reality; a stale board is
worse than none.

## Shared task board

**Pick a topic from *Open* below, then follow the [Contributor runbook](#contributor-runbook)** (or
its autonomous quick path). When you finish, move the item to *Landed* with the date and the files you
added. When you notice a new gap, add it to *Open* with a one-line reason and where the vault already
reaches for it. Each *Open* item's **bold id is its slug**. This board on `main` is the single
coordination surface—claims live here so everyone who pulls sees them; keep it current.

**Contributing is exactly two pushes to `main`:** ① a **claim push** the moment you pick a topic,
*before* any research, and ② a **completed-work push** at the end. Never start researching without
having pushed your claim first—that single rule is what prevents duplicate work.

> ⛔ **Claim gate (push ① of ②) — push your claim to `main` before you research.** The instant you choose a topic,
> and *before you read a single source*, move its bullet out of *Open* into *In progress* (with your
> handle and the date) and push that to `main`. The board on `main` is the only place other
> contributors look; a claim you have not pushed is invisible and someone will duplicate your work. Do
> this first, every time:
>
> ```bash
> git switch main && git pull --ff-only origin main   # get the current board
> # edit ALIGNMENT.md: cut the item's bullet from "### Open", paste it under "### In progress" as
> #   - **<slug>** — claimed <YYYY-MM-DD> by <your handle>
> git commit -am "claim <slug>"
> git push origin main            # rejected? git pull --rebase, re-check the board, then push
> ```
> If the push is rejected or `<slug>` is already under *In progress* after a rebase, someone beat you to
> it—pick another. Only once your claim is on `main` do you begin research.

### Open (pick from here)


**Backlog — token-saving reference gaps (grouped; each is an evergreen topic agents keep re-deriving).**
Godot is already deeply covered, so these lean to under-covered areas. Pick any; the slug is the bold id.

*Rendering & optimization (cross-engine)*


*Netcode & multiplayer (engine-agnostic)*


*Gameplay systems & AI (engine-agnostic)*



*Procedural generation*


*Game design: economy, progression, monetization*


*Unity depth (under-covered vs Godot)*


*Unreal depth (under-covered vs Godot)*


*Blender / assets / VRChat depth*


*AI-assisted gamedev / MCP*


*Editor MCP & AI-assisted gamedev (Unity / Blender / Unreal / Godot)*

- **blender-mcp-export-validation** — MCP-driven export plus validation; neighbours `blender-game-asset-pipeline`.
- **blender-mcp-scene-cleanup** — batch naming, cleanup, and origin fixes via MCP.
- **unreal-mcp-blueprint-authoring** — authoring Blueprints via MCP; neighbours `unreal-mcp-integration`.
- **unreal-mcp-level-scripting** — placing and editing actors through MCP.
- **godot-mcp-integration** — driving Godot from an MCP client; parallels `blender-mcp`, `unity-mcp-integration`.
- **mcp-editor-checkpointing** — undo/save checkpoints before agent edits; neighbours `editor-mcp-safety`.
- **mcp-tool-permission-scoping** — least-privilege tool exposure over raw code exec; neighbours `editor-mcp-safety`.
- **ai-batch-asset-generation** — pipelines for mass AI asset creation and triage.
- **ai-gameplay-script-generation** — generating and reviewing gameplay scripts safely.
- **llm-level-design-limits** — where LLM scene generation breaks down; neighbours `godot-ai-build-playbook`.

*Unity — engine depth & pain points*

- **unity-editor-scripting** — custom inspectors, property drawers, EditorWindow.
- **unity-shader-graph** — node-based shaders and their limits.
- **unity-vfx-graph-vs-particles** — GPU VFX Graph vs the built-in particle system.
- **unity-timeline-and-cinemachine** — cutscenes and procedural cameras.
- **unity-navmesh-agents** — baking and steering NavMesh agents in Unity.
- **unity-controller-vs-rigidbody** — CharacterController vs Rigidbody movement tradeoffs.
- **unity-2d-tilemap-and-sprites** — the 2D tilemap and sprite pipeline.
- **unity-animation-rigging** — runtime IK and constraints package.
- **unity-audio-mixer** — mixer groups, snapshots, and ducking.
- **unity-localization-package** — string tables and locale switching.
- **unity-il2cpp-and-aot** — IL2CPP builds, AOT limits, and code stripping.
- **unity-webgl-limits** — WebGL build constraints and threading/memory gotchas.
- **unity-mobile-optimization** — battery, thermal, and draw-call budgets on mobile.
- **unity-crash-and-log-diagnostics** — reading Player.log and native crash dumps.

*Unreal — engine depth & pain points*

- **unreal-blueprint-communication** — interfaces, event dispatchers, and casting.
- **unreal-anim-montages-and-notifies** — montages, notifies, and anim slots.
- **unreal-niagara-vfx** — Niagara systems and emitters.
- **unreal-landscape-and-foliage** — terrain and foliage tooling.
- **unreal-behavior-trees-and-eqs** — AI behavior trees and environment queries.
- **unreal-navmesh-and-perception** — nav mesh and AI perception setup.
- **unreal-chaos-physics** — Chaos physics and destruction.
- **unreal-umg-ui** — UMG widget UI workflow.
- **unreal-data-assets-and-datatables** — data-driven design in Unreal.
- **unreal-online-subsystem** — sessions, friends, and platform services.
- **unreal-packaging-and-cook** — cooking content and packaging builds.
- **unreal-insights-profiling** — Unreal Insights traces and analysis.
- **unreal-hlod** — hierarchical LOD for large scenes; neighbours `unreal-static-mesh-lod`.
- **unreal-sequencer** — cinematics and the Sequencer workflow.
- **unreal-cpp-gameplay-basics** — UCLASS/UPROPERTY and gameplay in C++.
- **unreal-android-build** — packaging for Android and its pitfalls.

*Godot — genuine gaps (already deep elsewhere)*

- **godot-csharp-vs-gdscript** — language tradeoffs and interop cost.
- **godot-gdextension-native** — C++/GDExtension for hot paths.

*Rendering & graphics (high token burn)*


*Netcode & backend (high token burn)*

- **dedicated-server-scaling** — fleet and orchestration for game servers.
- **cloud-save-and-leaderboards** — backend persistence basics.
- **player-auth-and-accounts** — identity and auth for games.

*Gameplay systems & AI*

- **crowd-avoidance-rvo** — local avoidance for crowds.
- **damage-and-hitbox-systems** — hitboxes, hurtboxes, and the damage pipeline.
- **ragdoll-and-physics-animation** — ragdoll blending and recovery.
- **procedural-animation** — spring and procedural motion.
- **tweening-and-easing** — easing curves and tween systems.
- **event-bus-messaging** — decoupled gameplay messaging patterns.
- **game-loop-and-update-order** — the *engine-specific* half only: `fixed-timestep-and-determinism`
  now covers the fixed-vs-variable loop and the determinism limits, so what is left is per-engine
  callback ordering (overlaps `unity-execution-order`; consider merging the two).

*Game design, economy, live-ops*

- **tutorial-design-patterns** — teaching without walls of text.
- **reward-schedules-variable-ratio** — reinforcement scheduling.
- **dual-currency-design** — soft vs hard currency balance.
- **iap-pricing-tiers** — price points and bundles.
- **ab-testing-for-games** — experiment design and pitfalls.
- **telemetry-and-kpis** — the metrics that matter and how to log them.
- **churn-and-winback** — retention analytics and re-engagement.
- **leaderboard-design** — ranking, seasons, and anti-abuse.
- **guild-and-social-systems** — social features and retention.
- **auction-house-design** — player trading economies.
- **loot-table-design** — weighted drops and pity.
- **game-feel-and-juice** — screenshake, hitstop, and feedback.
- **difficulty-dynamic-adjustment** — DDA approaches and pitfalls.

*Procedural generation*

- **biome-and-climate-generation** — biome distribution.
- **cellular-automata-caves** — cave generation.
- **procedural-mesh-generation** — building meshes at runtime.

*Blender / assets / DCC*

- **blender-hard-surface-modeling** — clean hard-surface modeling for games.
- **blender-geometry-nodes** — procedural geometry for game assets.
- **blender-modifiers-for-games** — the modifier stack and applying for export.
- **blender-rigify-workflow** — Rigify rigs and baking for game export.
- **blender-cloth-and-hair-sim** — sim-to-mesh for game assets.
- **trim-sheets-and-modular-kits** — modular environment art.
- **texel-density-consistency** — uniform texel density across assets.
- **fbx-export-settings-unity** — correct FBX settings for Unity.
- **fbx-export-settings-unreal** — correct FBX settings for Unreal.
- **substance-to-engine-workflow** — Substance texturing into engines.

*VRChat depth*

- **vrchat-avatar-descriptor-setup** — configuring the VRC Avatar Descriptor.
- **vrchat-visemes-and-lipsync** — viseme setup for lip sync.
- **vrchat-eye-and-blink-setup** — eye tracking and blink states.
- **vrchat-fbt-setup** — full-body-tracking calibration and proportions.
- **vrchat-expression-menus** — expression menus and parameters.
- **vrchat-avatar-animator-layers** — action, gesture, and FX layers.
- **vrchat-contacts-and-interactions** — contacts colliders and senders.
- **vrchat-quest-crossplatform** — PC vs Quest avatar variants.
- **vrchat-world-optimization** — world perf: lightmaps, occlusion, draw calls.

*Audio*

- **fmod-and-wwise-integration** — middleware setup and tradeoffs.
- **sfx-design-and-variation** — layering and randomization to avoid repetition.

*Platform, build, tooling*

- **steamworks-integration** — Steam features and shipping.
- **mobile-store-submission** — iOS/Android store preparation.
- **app-size-reduction** — shrinking build size.
- **ci-cd-for-game-builds** — automated build pipelines.
- **version-control-lfs-for-binaries** — Git LFS for large assets.
- **perforce-vs-git-for-games** — VCS choice for teams with big binaries.
- **crash-reporting-pipeline** — collecting and triaging crashes.
- **feature-flags-remote-config** — runtime toggles and staged rollouts.
- **localization-pipeline** — string extraction through to shipped locales.
- **automated-gameplay-testing** — test harnesses for gameplay.

### In progress (claimed — do not take)

_Move an item here from Open the moment you claim it, as `- **<slug>** — claimed <date> by <handle>`.
Move it to Landed when you push its files. Empty is fine._

- **unity-mcp-material-setup** — claimed 2026-07-11 by Taylor
- **unity-mcp-test-and-playmode** — claimed 2026-07-11 by Taylor
- **unity-mcp-build-automation** — claimed 2026-07-11 by Taylor
- **unity-mcp-import-settings** — claimed 2026-07-11 by Taylor
- **blender-mcp-modeling-workflow** — claimed 2026-07-11 by Taylor
- **blender-mcp-material-nodes** — claimed 2026-07-11 by Taylor
- **blender-mcp-bake-and-uv** — claimed 2026-07-11 by Taylor

- **pbr-material-workflow** — claimed 2026-07-11 by Codex
- **normal-mapping-explained** — claimed 2026-07-11 by Codex
- **linear-vs-srgb-color-space** — claimed 2026-07-11 by Codex
- **anti-aliasing-techniques** — claimed 2026-07-11 by Codex
- **deferred-vs-forward-rendering** — claimed 2026-07-11 by Codex
- **transport-udp-tcp-webrtc** — claimed 2026-07-11 by Codex
- **entity-interpolation-extrapolation** — claimed 2026-07-11 by Codex
- **nat-traversal-and-relays** — claimed 2026-07-11 by Codex
- **utility-ai** — claimed 2026-07-11 by Codex
- **flow-field-pathfinding** — claimed 2026-07-11 by Codex
- **inventory-system-design** — claimed 2026-07-11 by Codex
- **dialogue-system-design** — claimed 2026-07-11 by Codex
- **ability-and-cooldown-systems** — claimed 2026-07-11 by Codex
- **status-effects-and-buffs** — claimed 2026-07-11 by Codex
- **inverse-kinematics** — claimed 2026-07-11 by Codex
- **battle-pass-design** — claimed 2026-07-11 by Codex
- **ftue-onboarding-design** — claimed 2026-07-11 by Codex
- **accessibility-in-games** — claimed 2026-07-11 by Codex
- **wave-function-collapse** — claimed 2026-07-11 by Codex
- **poisson-disk-sampling** — claimed 2026-07-11 by Codex

- **ambient-occlusion-maps** — claimed 2026-07-11 by Claude
- **screen-space-reflections** — claimed 2026-07-11 by Claude
- **volumetric-fog-and-lighting** — claimed 2026-07-11 by Claude
- **decals-and-projection** — claimed 2026-07-11 by Claude
- **vertex-animation-textures** — claimed 2026-07-11 by Claude
- **impostors-and-billboards** — claimed 2026-07-11 by Claude
- **skinned-mesh-performance** — claimed 2026-07-11 by Claude
- **spatial-audio-attenuation** — claimed 2026-07-11 by Claude
- **adaptive-and-dynamic-music** — claimed 2026-07-11 by Claude
- **audio-memory-and-streaming** — claimed 2026-07-11 by Claude

### Landed

- **unity-mcp-prefab-workflow** (2026-07-11) — `wiki/concepts/unity-mcp-prefab-workflow.md`,
  `wiki/sources/unity-prefab-variants-and-overrides.md`, `wiki/sources/mcp-tools-prefab-safety.md`.
  Instance versus source edits, variants, nested overrides, and explicit propagation safety.

- **unity-mcp-scene-authoring** (2026-07-11) — `wiki/concepts/unity-mcp-scene-authoring.md`,
  `wiki/sources/mcp-tools-scene-authoring-safety.md`, `wiki/sources/unity-editor-scene-saving.md`.
  Structured scene edits, stable targets, approvals, checkpoints, and save boundaries.

- **reviewing-ai-generated-assets** (2026-07-11) — `wiki/concepts/reviewing-ai-generated-assets.md`,
  `wiki/sources/unity-importing-assets.md`, `wiki/sources/blender-asset-browser-and-linked-data.md`.
  Technical gates, provenance, import/reimport validation, and approved derivatives.

- **mcp-editor-tool-design** (2026-07-11) — `wiki/concepts/mcp-editor-tool-design.md`,
  `wiki/sources/mcp-tools-specification-and-safety.md`, `wiki/sources/mcp-server-concepts.md`.
  Narrow editor operations, inspect/preview/apply boundaries, approvals, and rollback safety.

- **blender-to-engine-scale-and-axis** (2026-07-11) — `wiki/concepts/blender-to-engine-scale-and-axis.md`,
  `wiki/sources/unreal-blender-fbx-import-scale.md`, `wiki/sources/blender-scene-units-and-transforms.md`.
  Units, transforms, axis conversion, FBX settings, and reimport verification.

- **vrchat-avatar-shaders** (2026-07-11) — `wiki/concepts/vrchat-avatar-shaders.md`,
  `wiki/sources/vrchat-android-content-optimization.md`, `wiki/sources/vrchat-avatar-optimization-tips.md`.
  Platform shader restrictions, transparency cost, material budgets, and performance validation.

- **blendshapes-for-avatars** (2026-07-11) — `wiki/concepts/blendshapes-for-avatars.md`,
  `wiki/sources/blender-shape-keys.md`, `wiki/sources/vrchat-avatar-visemes-and-blendshapes.md`.
  Shape-key mixing, corrective expressions, visemes, topology, and avatar performance budgets.

- **gltf-vs-fbx-tradeoffs** (2026-07-11) — `wiki/concepts/gltf-vs-fbx-tradeoffs.md`,
  `wiki/sources/khronos-gltf-runtime-delivery.md`, `wiki/sources/autodesk-fbx-sdk-and-animation.md`.
  Runtime delivery versus DCC interchange, animation fidelity, and validation boundaries.

- **blender-retopology** (2026-07-11) — `wiki/concepts/blender-retopology.md`,
  `wiki/sources/blender-retopology-remeshing.md`, `wiki/sources/blender-retopology-multiresolution.md`.
  High-to-low topology, deformation flow, remeshing limits, snapping, and bake readiness.

- **blender-uv-unwrapping** (2026-07-11) — `wiki/concepts/blender-uv-unwrapping.md`,
  `wiki/sources/blender-uv-operators.md`, `wiki/sources/blender-uv-layout-workflow.md`.
  Seams, distortion, island packing, texel density, and engine-ready layout checks.

- **unreal-blueprint-vs-cpp** (2026-07-11) — `wiki/concepts/unreal-blueprint-vs-cpp.md`,
  `wiki/sources/unreal-blueprint-vs-cpp-official-guide.md`, `wiki/sources/unreal-blueprint-best-practices.md`.
  Mixed architecture, designer iteration, native hot paths, and Blueprint performance boundaries.

- **unreal-world-partition** (2026-07-11) — `wiki/concepts/unreal-world-partition.md`,
  `wiki/sources/unreal-world-partition-overview.md`, `wiki/sources/unreal-world-partition-builders-and-hlod.md`.
  Grid streaming, streaming sources, Data Layers, HLODs, and large-world budgeting.

- **unreal-gameplay-ability-system** (2026-07-11) — `wiki/concepts/unreal-gameplay-ability-system.md`,
  `wiki/sources/unreal-gameplay-ability-system-overview.md`, `wiki/sources/unreal-gameplay-abilities-and-replication.md`.
  GAS components, effects, prediction, authority, and when the framework earns its complexity.

- **unreal-lumen** (2026-07-11) — `wiki/concepts/unreal-lumen.md`,
  `wiki/sources/unreal-lumen-global-illumination.md`, `wiki/sources/unreal-lumen-technical-details.md`.
  Dynamic GI and reflections, tracing modes, scalability, scene-update costs, and platform tradeoffs.

- **unreal-nanite** (2026-07-11) — `wiki/concepts/unreal-nanite.md`,
  `wiki/sources/unreal-nanite-virtualized-geometry.md`, `wiki/sources/unreal-nanite-technical-details.md`.
  Clustered virtualized geometry, streaming pools, fallback paths, material limits, and profiling.

- **unity-dots-jobs-and-burst** (2026-07-11) — `wiki/concepts/unity-dots-jobs-and-burst.md`,
  `wiki/sources/unity-burst-compilation.md`, `wiki/sources/unity-job-system-overview.md`. Parallel
  jobs, Burst AOT/JIT, ECS data layout, safety, synchronization, and workload tradeoffs.

- **unity-netcode-for-gameobjects** (2026-07-11) — `wiki/concepts/unity-netcode-for-gameobjects.md`,
  `wiki/sources/unity-netcode-for-gameobjects-overview.md`, `wiki/sources/unity-netcode-networkobjects.md`.
  GameObject-level replication, authority, object lifecycle, bandwidth, and transport boundaries.

- **unity-scriptable-objects** (2026-07-11) — `wiki/concepts/unity-scriptable-objects.md`,
  `wiki/sources/unity-scriptableobject-manual.md`, `wiki/sources/unity-scriptableobject-api.md`.
  Shared asset-backed data, authoring, serialization, mutation, and save-state boundaries.
- **pbr-material-workflow**, **normal-mapping-explained**, **linear-vs-srgb-color-space**, **anti-aliasing-techniques**, **deferred-vs-forward-rendering** (2026-07-11) — `wiki/concepts/` notes with `wiki/sources/khronos-gltf-pbr.md` and `wiki/sources/unity-rendering-paths-antialiasing.md`.
- **transport-udp-tcp-webrtc**, **entity-interpolation-extrapolation**, **nat-traversal-and-relays** (2026-07-11) — `wiki/concepts/` notes with `wiki/sources/rfc-transports-and-webrtc.md` and `wiki/sources/gaffer-networked-physics.md`.
- **utility-ai**, **flow-field-pathfinding** (2026-07-11) — `wiki/concepts/` notes with `wiki/sources/utility-ai-and-flow-fields.md`.
- **inventory-system-design**, **dialogue-system-design**, **ability-and-cooldown-systems**, **status-effects-and-buffs**, **inverse-kinematics** (2026-07-11) — `wiki/concepts/` notes with their linked source pages.
- **battle-pass-design**, **ftue-onboarding-design**, **accessibility-in-games** (2026-07-11) — `wiki/concepts/` notes with `wiki/sources/game-economy-and-battle-pass.md`, `wiki/sources/ftue-game-user-research.md`, and `wiki/sources/xbox-accessibility-guidelines.md`.
- **wave-function-collapse**, **poisson-disk-sampling** (2026-07-11) — `wiki/concepts/` notes with `wiki/sources/mxgmn-wave-function-collapse.md` and `wiki/sources/bridson-poisson-disk.md`.

- **unity-addressables** (2026-07-11) — `wiki/concepts/unity-addressables.md`,
  `wiki/sources/unity-addressables-manual.md`, `wiki/sources/unity-addressables-catalogs.md`. Async
  address-based loading, dependency lifetimes, catalogs, cache updates, and bundle hazards.

- **quest-and-objective-systems** (2026-07-11) — `wiki/concepts/quest-and-objective-systems.md`,
  `wiki/sources/fortnite-quests-persistent-data.md`, `wiki/sources/quest-definition-context-purpose.md`.
  Event-driven progress, persistent state, objective clarity, and quest-tracker failure modes.

- **crafting-system-design** (2026-07-11) — `wiki/concepts/crafting-system-design.md`,
  `wiki/sources/coster-unbroke-crafting-system.md` (plus cites `unreal-data-driven-items`). Recipe
  pacing, discovery, resource loops, and value/sink failure modes.

- **unity-input-system** (2026-07-11) — `wiki/concepts/unity-input-system.md`,
  `wiki/sources/unity-input-system-manual.md`, `wiki/sources/unity-input-actions-and-bindings.md`.
  Intent-based actions, bindings, control schemes, rebinding, and migration lifecycle.

- **economy-sinks-and-faucets** (2026-07-11) — `wiki/concepts/economy-sinks-and-faucets.md`,
  `wiki/sources/ludgate-mmo-faucets.md`, `wiki/sources/virtual-currency-endowments-experiment.md`.
  Currency flow, inflation, cohort effects, and useful-versus-punitive sink design.

- **mmo-itemization-and-loot** (2026-07-11) — `wiki/concepts/mmo-itemization-and-loot.md`,
  `wiki/sources/unreal-data-driven-items.md`, `wiki/sources/defining-loot-tables-arpg.md`. Data-driven
  item definitions, staged loot rolls, affix pools, power budgets, and junk-loot failure modes.
- **snapshot-interpolation** (2026-07-11) — `wiki/concepts/snapshot-interpolation.md`,
  `wiki/sources/gaffer-snapshot-interpolation.md` (plus cites `valve-source-multiplayer-networking`).
  Covers buffered remote rendering, packet-loss tolerance, interpolation delay, and why extrapolation
  must be bounded around collisions and nonlinear motion.

- **gacha-and-pity-math** (2026-07-11) — `wiki/concepts/gacha-and-pity-math.md`,
  `wiki/sources/gacha-pricing-pity-research.md` (plus cites `apple-app-review-guidelines-monetization`).
  Stateful pity probability, expected and worst-case pulls, duplicate outcomes, and disclosure.

- **player-retention-loops** (2026-07-11) — `wiki/concepts/player-retention-loops.md`,
  `wiki/sources/unity-retention-metrics.md`, `wiki/sources/frommel-mandryk-daily-quests.md`. Cadence,
  cohort metrics, and the retention-versus-obligation tradeoff.

- **fixed-timestep-and-determinism** (2026-07-11) — `wiki/concepts/fixed-timestep-and-determinism.md`,
  `wiki/sources/gaffer-fix-your-timestep.md`, `wiki/sources/unity-fixed-timestep.md`,
  `wiki/sources/gaffer-floating-point-determinism.md`. The accumulator loop and render-state
  interpolation that give `frame-pacing` a stable simulation underneath it; the frame-time clamp that
  stops the spiral of death, and the price it quietly charges (past `Time.maximumDeltaTime` Unity
  simply discards the overflow, so game time falls behind real time); and why a fixed step buys
  repeatability but not the cross-platform bit-exactness that lockstep needs.

- **action-combat-roles** (2026-07-11) — `wiki/concepts/action-combat-roles.md` and its sources
  (commit f5552fb). *Entry reconstructed 2026-07-11:* the files are on `main`, but a later board edit
  dropped the item from every section, so the board went on advertising it as Open.

- **reliable-udp-and-ordering** (2026-07-11) — `wiki/concepts/reliable-udp-and-ordering.md`,
  `wiki/sources/gaffer-reliability-over-udp.md`. *Entry reconstructed 2026-07-11:* same cause — the
  concept is on `main`, but its claim and Landed entry were lost in a board rewrite.

- **idle-game-monetization** (2026-07-11) — `wiki/concepts/idle-game-monetization.md`,
  `wiki/sources/google-play-payments-and-ads.md`, `wiki/sources/apple-app-review-guidelines-monetization.md`.
  Opt-in ads, paid pacing, economy integrity, and current storefront constraints.

- **texture-channel-packing** (2026-07-11) — `wiki/concepts/texture-channel-packing.md`,
  `wiki/sources/unity-channel-packed-textures.md`, `wiki/sources/unreal-texture-masks.md`. Shared
  scalar map fetches, channel conventions, linear import, and packing failure modes.

- **lightmap-baking-and-uv2** (2026-07-11) — `wiki/concepts/lightmap-baking-and-uv2.md`,
  `wiki/sources/unreal-lightmapping.md`, `wiki/sources/unreal-lightmap-uv-generation.md`. Dedicated
  baked-light UV layout, padding, resolution, and chart-generation tradeoffs.
- **delta-compression-netcode** (2026-07-11) — `wiki/concepts/delta-compression-netcode.md`,
  `wiki/sources/gaffer-snapshot-compression.md` (plus cites `valve-source-multiplayer-networking`).
  Covers per-client acknowledged baselines, quantization, changed-field encodings, and full-state
  recovery after loss.

- **shadow-map-budgeting** (2026-07-11) — `wiki/concepts/shadow-map-budgeting.md`,
  `wiki/sources/unreal-shadowing.md`, `wiki/sources/unreal-virtual-shadow-maps.md`. Cascade and
  tiled-shadow budgets, with resolution, distance, caster, and cache-invalidation tradeoffs.

- **overdraw-and-transparency-cost** (2026-07-11) — `wiki/concepts/overdraw-and-transparency-cost.md`,
  `wiki/sources/unreal-transparency-overdraw.md`, `wiki/sources/unreal-shader-complexity-view.md`.
  Screen-space cost of layered transparency, with coverage, shader, masking, and diagnostic tradeoffs.

- **virtual-texturing** (2026-07-11) — `wiki/concepts/virtual-texturing.md`,
  `wiki/sources/unreal-virtual-texturing.md`, `wiki/sources/unity-streaming-virtual-texturing.md`.
  Tile/page residency for large textures, with feedback, cache, border, and latency tradeoffs.

- **platform-memory-budgets** (2026-07-11) — `wiki/concepts/platform-memory-budgets.md`,
  `wiki/sources/microsoft-video-memory-budget.md`, `wiki/sources/unreal-texture-memory-pools.md`.
  Separates OS video-memory budgets from advertised VRAM and explains texture-streaming headroom.

- **mipmapping-and-texture-streaming** (2026-07-11) —
  `wiki/concepts/mipmapping-and-texture-streaming.md`, `wiki/sources/unity-mipmap-streaming.md`,
  `wiki/sources/unreal-texture-streaming.md`. Why the mip chain costs only ~33% and buys stability,
  and how both engines treat the streaming budget as a ceiling they degrade against — plus the
  unstreamable cases (terrain, procedural meshes, non-UV0 shaders) that stay fully resident silently.

- **authoritative-server-and-anti-cheat** (2026-07-11) — `wiki/concepts/authoritative-server-and-anti-cheat.md`,
  `wiki/sources/epic-networking-overview.md` (plus cites `valve-source-multiplayer-networking`).
  Defines server trust boundaries, per-command validation, selective replication, and why authority
  is necessary but not sufficient as an anti-cheat system.
- **texture-compression-formats** (2026-07-11) — `wiki/concepts/texture-compression-formats.md`,
  `wiki/sources/unity-texture-compression-platforms.md`, `wiki/sources/microsoft-block-compression.md`.
  BCn, ASTC, and ETC2 selection by channel and platform, including runtime fallback and artifact costs.

- **texture-arrays-vs-atlases** (2026-07-11) — `wiki/concepts/texture-arrays-vs-atlases.md`,
  `wiki/sources/unity-texture-arrays.md`, `wiki/sources/d3d11-resource-limits.md`. Answers the limits
  `texture-atlasing` names but cannot solve (wrap/mirror, mip bleed); trades the atlas's mixed-size
  packing for a rigid same-size grid, and swaps a 16384-texel page ceiling for 2048 array slices.

- **gpu-instancing** (2026-07-11) — `wiki/concepts/gpu-instancing.md`,
  `wiki/sources/unity-gpu-instancing.md`, `wiki/sources/microsoft-draw-instanced.md`. Repeated-mesh
  rendering through per-instance data, with the culling, small-mesh, shader, and batcher tradeoffs.

- **lag-compensation** (2026-07-11) — `wiki/concepts/lag-compensation.md`,
  `wiki/sources/gambetta-lag-compensation.md` (plus cites `valve-source-multiplayer-networking`).
  Covers bounded server rewind for time-sensitive combat, the attacker/defender fairness tradeoff,
  and why durable world state should not be rewound.
- **state-synchronization-strategies** (2026-07-11) — `wiki/concepts/state-synchronization-strategies.md`,
  `wiki/sources/gaffer-state-synchronization.md` (plus cites `valve-source-multiplayer-networking`).
  Compares snapshots, acknowledged deltas, input/event replication, and approximate state updates,
  with a hybrid protocol recommendation for persistent multiplayer worlds.
- **pool-warmup-and-budgeting** (2026-07-11) — `wiki/concepts/pool-warmup-and-budgeting.md`,
  `wiki/sources/unity-object-pool-api.md`, `wiki/sources/unity-learn-object-pooling.md`. Sizing and
  prewarm for `object-pooling`: peak-concurrent measurement, and the trap that Unity's
  `defaultCapacity` does not prewarm while `maxSize` caps retention rather than live instances.

- **texture-atlasing** (2026-07-11) — `wiki/concepts/texture-atlasing.md`,
  `wiki/sources/nvidia-texture-atlas-whitepaper.md`, `wiki/sources/unity-sprite-atlas.md`. The
  texture-side precondition for `draw-call-batching` that seven pages reached for ("atlas your
  textures") but none defined; carries the wrap/mirror and mip-filter limits that make it fail.
- **client-prediction-and-reconciliation** (2026-07-11) — `wiki/concepts/client-prediction-and-reconciliation.md`,
  `wiki/sources/valve-source-multiplayer-networking.md`, `wiki/sources/gaffer-client-prediction.md`.
  Covers sequence-numbered input prediction, authoritative correction, rewind/replay, and the
  tradeoff between responsive local movement and shared simulation rules.
- **prestige-currency-soft-caps** (2026-07-12) — `wiki/concepts/prestige-currency-soft-caps.md`,
  `wiki/sources/diminishing-returns-soft-caps.md` (plus cites `idle-game-math-part-iii`). Soft/hard
  caps and stacked meta currencies deepening `idle-game-prestige`.
- **object-pooling** (2026-07-12) — `wiki/concepts/object-pooling.md`,
  `wiki/sources/nystrom-object-pool.md`, `wiki/sources/unity-object-pooling.md`. Allocation-stall
  avoidance for frequent spawn/despawn; neighbours `game-performance-profiling`.
- **draw-call-batching** (2026-07-11) — `wiki/concepts/draw-call-batching.md`,
  `wiki/sources/nvidia-batch-batch-batch.md`, `wiki/sources/unity-draw-call-batching.md`. The
  batching concept the optimization cluster kept implying but never defined.
- **blender-mcp** (2026-07-11) — `wiki/concepts/blender-mcp.md`,
  `wiki/sources/ahujasid-blender-mcp.md`. Completes the Unity/Unreal/Blender editor-MCP trilogy and
  resolves the dangling `[[blender-mcp]]` links.
- **level-of-detail** (2026-07-11) — `wiki/concepts/level-of-detail.md`, published by the maintainer
  via the export tool. If it reads thin, a follow-up may deepen the "the catch" (LOD popping, switch
  distance tuning) rather than re-create it.

### Do not touch (private references; never publish or expand)

These appear as dangling links inside published notes. They are private projects or machine config.
Do not create pages for them, and do not add new references to them.

- `minecwaft` — private Vulkan/C# game
- `micro-mmo` — private MMO project
- `vrchat-homeworld` — private VRChat world
- `unity-mcp` — machine-specific connection/config notes
- `arii-blend-avatar` — a specific personal avatar project (treat as private unless the maintainer
  confirms it is a public base)

## The disposition: additive, not architectural

Contribute as a **source contributor**. The job is to continue the research already here—deepen a
thread, add a missing source, fill a gap between two concepts—so that if the change were pulled, an
existing reader gains something and loses nothing. A good contribution is a drop-in: it reads as
though the same author wrote it on the same day.

Do not reshape the vault. No new top-level structure, no renamed folders, no reorganised index, no
competing conventions, no tooling rewrites. If a change would make a maintainer decide *how the
project works* rather than *what it knows*, it is out of scope here—raise it as a discussion first.

Ask of every change: **would pulling this help someone already using the vault?** If the answer is
"only after they adapt to a new way of doing things," stop.

## What a good contribution looks like

- Extends an existing concept, or adds a concept that neighbours one already present and links to it.
- Comes with its source page(s). Every claim traces to a cited source with author, URL, published
  date, retrieval date, and a summary written in original words—never pasted source text.
- States the tradeoff or failure mode, not just the happy path. The value is in the "the catch"
  and "in practice" reasoning, not a restated summary.
- Links related concepts on first mention with `[[wikilinks]]`, matching the existing graph.
- Verifies volatile facts (engine versions, SDK limits, package names, platform policies) at the time
  of writing, and sets `verified:` to that date.

## Match the existing form exactly

New pages copy the shape of the current ones—do not invent frontmatter fields or section headings.

- **Concept pages** (`wiki/concepts/`): frontmatter `title, type: concept, status, created, updated,
  verified, sources, tags`; body with a lead definition, a "why it works" mechanism, a "the catch"
  limitation, and an "in practice" application. See [frame-pacing.md](wiki/concepts/frame-pacing.md).
- **Source pages** (`wiki/sources/`): frontmatter `title, type: source, status, created, updated,
  verified, sources, tags`; body with an author/URL/dates block, a "summary" in original words, and a
  "compiled into" list of the concepts it feeds. See
  [idle-game-math-part-i.md](wiki/sources/idle-game-math-part-i.md).

Keep prose tight and concrete, wrapped at roughly the same width as surrounding files. Tags reuse the
existing vocabulary rather than introducing near-duplicates.

**Provenance for direct contributions.** Notes exported from the private brain point a source page's
`sources:` field at a private `raw/…` capture. A direct public contribution has no such capture, so
point `sources:` at the live public URL instead and drop the `Raw:` bullet—cite honestly rather than
name a file that does not exist. Everything else about the form stays identical.

## Boundaries

- No private-project notes, local paths, machine configuration, logs, or chat-specific memory. This is
  a public export; if a note references a private project or workspace, leave it out or generalise it.
- No third-party source text unless its license clearly permits redistribution. Store attribution,
  URLs, and original summaries—not the works themselves.
- Generated pages under `wiki/` originate from the private brain. Contributors add new files under
  `wiki/` and push them to `main`; the maintainer folds them into the brain (see Durability below).
- **Do not run `tools/publish-research.ps1`.** It is the maintainer's export tool: it wipes and
  regenerates `wiki/` and `INDEX.md` from a private brain that is not part of this repository, so
  running it would delete unmerged contributions. Leave `INDEX.md` untouched too—it is generated.

When in doubt, the smaller, better-sourced, more clearly-linked change is the right one.

## Contributor runbook

A fresh agent—human or AI, working for any developer—should be able to run these steps in order and
contribute cleanly. **Coordination happens on `main` itself:** you claim a task by editing the board
on `main` and pushing, so every contributor who pulls immediately sees what is taken. There are no
per-task branches or pull requests—work is pushed straight to `main`.

**You need write access to contribute.** Because claims are recorded on `main`, a contributor must be
able to push to `main` (a repo collaborator). A fork cannot work here—a claim on your fork is invisible
to everyone pulling `main`. If you lack push access, ask the maintainer to add you (see
[Access model](#access-model)); with none you can only research and draft locally and hand off.

**The claim is a board edit on `main`, nothing else.** Moving an item from *Open* to *In progress* and
pushing it is the lock: `git push` rejects a stale push, and two agents cutting the same *Open* line
conflict on rebase—so the board on `main` is always the single truth about who holds what.

**Autonomous quick path.** If a user simply says *"check ALIGNMENT.md and contribute,"* run the whole
loop below yourself—sync, claim on `main`, research, write, and push—**without stopping to ask**. Only
pause if (a) you have no push access, (b) the *Open* list is empty, or (c) you cannot verify a source.
When done, report what you shipped and the commit. The annotated steps 0–5 that follow explain each
command; this block is the executable distillation.

```bash
# 0. Sync to the latest board.
git switch main && git pull --ff-only origin main

# 1. Pick an unclaimed Open slug (one NOT under "### In progress"), then CLAIM ON MAIN before
#    researching: edit ALIGNMENT.md — cut the item's bullet from "### Open" and paste it under
#    "### In progress" as:  - **<slug>** — claimed <date> by <handle>
git commit -am "claim <slug>"
git push origin main    # ⛔ rejected? git pull --rebase, re-check the board; if <slug> is already
                        #    In progress someone beat you—pick another. Do NOT research until this lands.

# 2-3. Research with cited sources; write new wiki/ files in the existing form (steps 2-3 below).

# 4. Finish: move <slug> from "### In progress" to "### Landed" (with the files), then push.
git add wiki && git commit -am "<slug>: add notes; move to Landed"
git pull --rebase origin main && git push origin main
```

**0 — Sync and read.**

- `git fetch origin && git switch main && git pull --ff-only origin main` so you hold the latest
  board and landed work.
- Read this file top to bottom and [CONTRIBUTING.md](CONTRIBUTING.md); skim one concept and one
  source page to absorb the voice before writing.
- Re-read the [Shared task board](#shared-task-board) *after* pulling—an item you remember as open
  may already have landed.

**1 — Claim on `main` *before* you spend research tokens.** Claiming first is the one rule that stops
two agents researching the same item, and the claim only counts once it is pushed to `main`.

- Each *Open* item's **bold id is its slug**. Confirm it is not already listed under *In progress* on
  the board you just pulled.
- Claim it: `git pull --ff-only origin main`, then edit this file—cut the item's bullet out of
  *### Open* and paste it under *### In progress* as `- **<slug>** — claimed <date> by <handle>`.
  Commit and `git push origin main`.
- **Push the claim before reading a single source.** An unpushed edit is invisible; the board on
  `main` is the only place others look. If the push is rejected, `git pull --rebase` and re-read the
  board: if `<slug>` is now under *In progress*, someone beat you—pick another.
- Stale claim: an *In progress* entry older than 7 days with nothing landed is abandoned; take it over
  and update the date.

**2 — Research and verify.**

- Fetch the real sources. Capture author, URL, published date, and retrieval date; write summaries in
  your own words—never paste source text. Re-check volatile facts (versions, limits, policies) and
  set `verified:` to today.

**3 — Write additively, in the existing form.**

- Add new files under `wiki/concepts/` and `wiki/sources/` matching the frontmatter and section shape
  in [Match the existing form exactly](#match-the-existing-form-exactly).
- Link out to existing concepts—Obsidian backlinks connect the graph without editing the notes you
  point at. Reference only public concepts; never the *Do not touch* list.
- Do not add structure, rename anything, edit `INDEX.md`, or run `tools/publish-research.ps1`.

**4 — Restock the board.**

- Add any new gaps you noticed to *Open* (one line: the reason and where the vault already reaches for
  it), and any private references to *Do not touch*. (Your own item moves to *Landed* in the next step,
  when you push its files.) Leaving the next contributor a well-described task is part of the work.

**5 — Push your completed work to `main` (push ② of ②).**

- Commit your `wiki/` files together with the board update (move `<slug>` from *In progress* to
  *Landed*), then `git pull --rebase origin main` and `git push origin main`. Files pushed to `main`
  are provisional until the maintainer folds them into the private brain (see
  [Durability of contributions](#durability-of-contributions)); expect your exact wording may be
  revised there.

## Access model

This vault coordinates on `main`, so **contributors must be repo collaborators with write access**—the
claim (moving a task to *In progress*) and the work are both pushed straight to `main`, and a claim on
a fork would be invisible to everyone else. The maintainer grants write access to the specific people
or agents who contribute, and keeps the list here.

*Maintainer: grant with* `gh api -X PUT repos/sadozin/game-dev-research-vault/collaborators/<user> -f permission=push`*;
revoke with the same path and* `-X DELETE`*.*

The trade-off, chosen deliberately: this drops open fork-and-PR contributions and the safety of a
review gate, in exchange for claims that everyone sees on `main`. Because no PR gates a change, the
**maintainer is the review step**—via the brain-mirror pass and by reverting anything that does not
fit. An agent with no write access can still research and draft locally, then hand the files to a
collaborator to push.

## Durability of contributions

*A note for the maintainer. Suggestions only—nothing here changes the export tool, and contributors
must not touch it.*

Contributions pushed to `main` are currently **provisional**. `tools/publish-research.ps1` rebuilds
`wiki/` by deleting every note and re-copying from the private brain, so any contributed file that has
not also been added to the brain is silently removed by the next publish—no conflict, no warning. The
*Landed* list can then claim files that no longer exist on `main`. Contributors cannot fix this; the
runbook only tells them to expect it.

Two ways to close the gap, in order of preference:

1. **Make publish non-destructive and fail-loud (recommended).** Have the script remember what it
   exported (a manifest) and, on the next run, prune only files it previously produced that the brain
   no longer produces—leaving contributed files untouched—then print any `wiki/` file it does not own
   as "unmanaged: fold into the brain to keep it." This ends silent deletion while still letting the
   brain prune its own renamed or removed notes.
2. **Mirror-before-publish checklist.** If the tool stays destructive, then before every publish
   confirm that each contribution pushed since the last publish is present in the brain. This works
   but relies on discipline; option 1 makes the safety automatic.

Until one of these is in place, fold each pushed contribution into the brain promptly, and keep the
*Landed* list honest by removing any entry whose files a publish has dropped.

When in doubt, the smaller, better-sourced, more clearly-linked change is the right one.
