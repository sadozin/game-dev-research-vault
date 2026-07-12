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

- **idle-game-math-part-ii** — Parts I and III are cited sources; the middle of Pecorella's public
  series is missing. Add the source page and thread it into `clicker-game-economy` and
  `idle-game-prestige`. (Note: threading requires touching those two concept pages' `sources:`.)
- **action-combat-roles** — `mmo-combat-roles` sets up the holy trinity but not action-combat role
  design (aggro without a taunt, telegraphs, sustain vs. burst); a natural neighbour concept.

**Backlog — token-saving reference gaps (grouped; each is an evergreen topic agents keep re-deriving).**
Godot is already deeply covered, so these lean to under-covered areas. Pick any; the slug is the bold id.

*Rendering & optimization (cross-engine)*

- **texture-compression-formats** — BCn/ASTC/ETC2 choice per platform; neighbours `texture-baking-for-games` and VRChat texture-memory limits.
- **mipmapping-and-texture-streaming** — sampling quality and memory; neighbours `game-performance-profiling`.
- **platform-memory-budgets** — the hard per-platform RAM/VRAM ceiling that pools, textures, and
  streaming all draw from; `pool-warmup-and-budgeting` and `vrchat-avatar-optimization` both warn
  about busting it, but no page states how the budget is set or apportioned.
- **overdraw-and-transparency-cost** — why layered/transparent fills wreck fill-rate; neighbours `frame-pacing`, `vrchat-avatar-optimization`.
- **shadow-map-budgeting** — cascade count, resolution, and cost; neighbours `real-time-lighting-budget`.
- **lightmap-baking-and-uv2** — baked GI workflow and the second UV set; neighbours `real-time-lighting-budget`, `texture-baking-for-games`.
- **texture-channel-packing** — ORM/mask packing to cut samplers and memory; neighbours `texture-baking-for-games`.
- **fixed-timestep-and-determinism** — decoupling simulation from render for stable physics; neighbours `frame-pacing`.

*Netcode & multiplayer (engine-agnostic)*

- **rollback-netcode** — deterministic action/fighting netplay; distinct from lockstep.
- **authoritative-server-and-anti-cheat** — trust boundaries and server validation; neighbours `godot-dedicated-servers`.
- **matchmaking-and-mmr** — Elo/Glicko, queues, and fairness; a recurring design question.

*Gameplay systems & AI (engine-agnostic)*

- **entity-component-systems** — data-oriented gameplay architecture; neighbours `game-performance-profiling`.
- **behavior-trees-for-ai** — the standard game-AI control structure; no concept yet.
- **gameplay-state-machines** — FSM/HSM for characters and UI flow; neighbours `character-animation-graphs`.
- **pathfinding-fundamentals** — A*/JPS and grid-vs-navmesh tradeoffs; neighbours `godot-navigation`.
- **input-buffering-and-coyote-time** — the mechanics behind good game feel; no concept yet.
- **third-person-camera-systems** — spring-arm, collision, and framing; neighbours `godot-3d-transforms`.
- **save-data-versioning-and-migration** — evolving save schemas without breaking old saves; neighbours `godot-save-and-load`.

*Procedural generation*

- **procedural-noise-functions** — Perlin/Simplex/value noise and their uses; costly to re-derive each time.
- **procedural-dungeon-generation** — room/BSP/graph approaches and their tradeoffs.

*Game design: economy, progression, monetization*

- **progression-curve-design** — XP/leveling curves and pacing; neighbours `clicker-game-economy`, `mmo-skill-loadouts`.
- **idle-game-monetization** — ads, IAP, and time-skip design; neighbours `clicker-game-economy`.
- **player-retention-loops** — daily rewards, streaks, session shaping; neighbours `idle-game-prestige`.
- **gacha-and-pity-math** — drop-rate design and pity systems; probability-heavy.
- **mmo-itemization-and-loot** — rarity tiers, affixes, power budget; neighbours `mmo-class-economics`.
- **economy-sinks-and-faucets** — controlling virtual-economy inflation; neighbours `mmo-class-economics`.
- **crafting-system-design** — recipes, gates, and material loops; neighbours the MMO cluster.
- **quest-and-objective-systems** — data-driven quests and tracking; neighbours the MMO cluster.

*Unity depth (under-covered vs Godot)*

- **unity-input-system** — the new Input System package vs legacy input; no Unity input concept yet.
- **unity-addressables** — async asset loading and memory control; no concept yet.
- **unity-scriptable-objects** — data-as-asset architecture pattern; no concept yet.
- **unity-netcode-for-gameobjects** — first-party multiplayer stack; no Unity netcode concept.
- **unity-dots-jobs-and-burst** — the data-oriented performance path; neighbours `entity-component-systems`.

*Unreal depth (under-covered vs Godot)*

- **unreal-nanite** — virtualized geometry and its limits; high interest, no concept.
- **unreal-lumen** — dynamic GI/reflections and their cost; no concept.
- **unreal-gameplay-ability-system** — GAS structure and when to use it; no concept.
- **unreal-replication** — properties, RPCs, and roles for multiplayer; no concept.
- **unreal-world-partition** — large-world streaming; no concept.
- **unreal-blueprint-vs-cpp** — performance and architecture tradeoffs; compiles the existing `unreal-blueprint-cpp` source.

*Blender / assets / VRChat depth*

- **blender-uv-unwrapping** — seams, packing, and texel density for games; neighbours `blender-game-asset-pipeline`.
- **blender-retopology** — high-to-low-poly for game meshes; neighbours `texture-baking-for-games`.
- **gltf-vs-fbx-tradeoffs** — choosing an interchange format; neighbours `blender-gltf-export`.
- **blendshapes-for-avatars** — shape keys for faces and visemes; neighbours `vrchat-humanoid-rigging`.
- **vrchat-avatar-shaders** — lilToon/Poiyomi cost and setup; neighbours `vrchat-avatar-optimization`.
- **blender-to-engine-scale-and-axis** — unit and axis gotchas on import; neighbours `blender-game-asset-pipeline`.

*AI-assisted gamedev / MCP*

- **mcp-editor-tool-design** — safe, high-level tools over raw code execution; neighbours `editor-mcp-safety`.
- **reviewing-ai-generated-assets** — validating AI-made meshes/materials before commit; neighbours `editor-mcp-safety`, `blender-game-asset-pipeline`.

*Editor MCP & AI-assisted gamedev (Unity / Blender / Unreal / Godot)*

- **unity-mcp-scene-authoring** — building scenes and hierarchies through MCP; neighbours `unity-mcp-integration`.
- **unity-mcp-prefab-workflow** — creating and editing prefabs via an agent without corrupting variants.
- **unity-mcp-material-setup** — assigning materials/shaders and property blocks through MCP.
- **unity-mcp-test-and-playmode** — running edit/play-mode tests from an agent; neighbours `editor-mcp-safety`.
- **unity-mcp-build-automation** — triggering builds safely via MCP.
- **unity-mcp-import-settings** — automating texture/model import presets through MCP.
- **blender-mcp-modeling-workflow** — primitive and mesh ops via BlenderMCP; neighbours `blender-mcp`.
- **blender-mcp-material-nodes** — building shader-node graphs through MCP.
- **blender-mcp-bake-and-uv** — automating UV and bake steps via MCP; neighbours `texture-baking-for-games`.
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

- **unity-execution-order** — Awake/OnEnable/Start/Update/FixedUpdate ordering and gotchas.
- **unity-coroutines-and-async** — coroutines vs async/await vs UniTask; recurring confusion.
- **unity-serialization-rules** — what serializes, references, and ScriptableObject data pitfalls.
- **unity-editor-scripting** — custom inspectors, property drawers, EditorWindow.
- **unity-assembly-definitions** — asmdef boundaries and compile speed.
- **unity-render-pipelines-urp-hdrp** — choosing and converting Built-in vs URP vs HDRP.
- **unity-shader-graph** — node-based shaders and their limits.
- **unity-vfx-graph-vs-particles** — GPU VFX Graph vs the built-in particle system.
- **unity-timeline-and-cinemachine** — cutscenes and procedural cameras.
- **unity-navmesh-agents** — baking and steering NavMesh agents in Unity.
- **unity-controller-vs-rigidbody** — CharacterController vs Rigidbody movement tradeoffs.
- **unity-2d-tilemap-and-sprites** — the 2D tilemap and sprite pipeline.
- **unity-animation-rigging** — runtime IK and constraints package.
- **unity-audio-mixer** — mixer groups, snapshots, and ducking.
- **unity-localization-package** — string tables and locale switching.
- **unity-memory-profiler** — capturing and reading memory snapshots.
- **unity-il2cpp-and-aot** — IL2CPP builds, AOT limits, and code stripping.
- **unity-webgl-limits** — WebGL build constraints and threading/memory gotchas.
- **unity-mobile-optimization** — battery, thermal, and draw-call budgets on mobile.
- **unity-crash-and-log-diagnostics** — reading Player.log and native crash dumps.

*Unreal — engine depth & pain points*

- **unreal-gameplay-framework** — GameMode/GameState/PlayerController/Pawn/Character roles.
- **unreal-actors-and-components** — the actor/component model and lifecycle.
- **unreal-blueprint-communication** — interfaces, event dispatchers, and casting.
- **unreal-enhanced-input** — setting up the Enhanced Input system.
- **unreal-anim-montages-and-notifies** — montages, notifies, and anim slots.
- **unreal-material-instances** — parameterized materials and MID performance.
- **unreal-niagara-vfx** — Niagara systems and emitters.
- **unreal-landscape-and-foliage** — terrain and foliage tooling.
- **unreal-behavior-trees-and-eqs** — AI behavior trees and environment queries.
- **unreal-navmesh-and-perception** — nav mesh and AI perception setup.
- **unreal-chaos-physics** — Chaos physics and destruction.
- **unreal-umg-ui** — UMG widget UI workflow.
- **unreal-data-assets-and-datatables** — data-driven design in Unreal.
- **unreal-save-game** — SaveGame objects and serialization.
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

- **pbr-material-workflow** — the metallic/roughness PBR contract across engines.
- **normal-mapping-explained** — tangent-space normals and common artifacts.
- **specular-vs-metallic-workflow** — the two PBR conventions and conversions.
- **ambient-occlusion-maps** — AO baking and how engines consume it.
- **linear-vs-srgb-color-space** — color-space correctness; a constant source of bugs.
- **hdr-and-tonemapping** — the HDR pipeline and tonemappers.
- **anti-aliasing-techniques** — MSAA/TAA/FXAA/SMAA tradeoffs.
- **deferred-vs-forward-rendering** — rendering-path tradeoffs.
- **screen-space-reflections** — SSR cost and artifacts.
- **volumetric-fog-and-lighting** — volumetrics cost vs quality.
- **decals-and-projection** — decal systems and their performance.
- **post-processing-stack** — bloom/tonemap/vignette pipeline and cost.
- **vertex-animation-textures** — baking animation into textures for perf.
- **impostors-and-billboards** — far-LOD impostor techniques.
- **skinned-mesh-performance** — GPU skinning cost and bone limits.

*Netcode & backend (high token burn)*

- **transport-udp-tcp-webrtc** — choosing a transport; a recurring decision.
- **reliable-udp-and-ordering** — reliability layers over UDP.
- **delta-compression-netcode** — sending diffs instead of full state.
- **snapshot-interpolation** — buffering and interpolating remote state.
- **entity-interpolation-extrapolation** — smoothing remote entities.
- **nat-traversal-and-relays** — connectivity behind NATs.
- **lobby-and-session-management** — creating and joining sessions.
- **dedicated-server-scaling** — fleet and orchestration for game servers.
- **cloud-save-and-leaderboards** — backend persistence basics.
- **player-auth-and-accounts** — identity and auth for games.

*Gameplay systems & AI*

- **utility-ai** — scoring-based decision making.
- **goap-planning** — goal-oriented action planning.
- **flow-field-pathfinding** — many-agent pathing.
- **crowd-avoidance-rvo** — local avoidance for crowds.
- **inventory-system-design** — grids, stacks, weight, and UI binding.
- **dialogue-system-design** — data-driven dialogue and branching.
- **ability-and-cooldown-systems** — skills, cooldowns, and resources.
- **status-effects-and-buffs** — stacking, duration, and ticks.
- **damage-and-hitbox-systems** — hitboxes, hurtboxes, and the damage pipeline.
- **inverse-kinematics** — IK for feet, hands, and aim.
- **ragdoll-and-physics-animation** — ragdoll blending and recovery.
- **procedural-animation** — spring and procedural motion.
- **root-motion-vs-inplace** — animation-driven vs code-driven movement.
- **tweening-and-easing** — easing curves and tween systems.
- **event-bus-messaging** — decoupled gameplay messaging patterns.
- **game-loop-and-update-order** — fixed vs variable update and determinism.
- **replay-and-recording-systems** — deterministic replays and recordings.

*Game design, economy, live-ops*

- **battle-pass-design** — track, tier, and reward structure.
- **season-and-liveops-cadence** — content cadence and events.
- **ftue-onboarding-design** — first-time user experience.
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
- **accessibility-in-games** — colorblind, remap, and subtitle standards.
- **difficulty-dynamic-adjustment** — DDA approaches and pitfalls.

*Procedural generation*

- **wave-function-collapse** — constraint-based tile/level generation.
- **terrain-heightmap-generation** — heightmaps and erosion.
- **biome-and-climate-generation** — biome distribution.
- **cellular-automata-caves** — cave generation.
- **poisson-disk-sampling** — even random placement.
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
- **adaptive-and-dynamic-music** — interactive music systems.
- **spatial-audio-attenuation** — 3D audio falloff and occlusion.
- **sfx-design-and-variation** — layering and randomization to avoid repetition.
- **audio-memory-and-streaming** — audio compression and streaming budgets.

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

- **texture-arrays-vs-atlases** — claimed 2026-07-11 by sadozin (Claude)

### Landed

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
