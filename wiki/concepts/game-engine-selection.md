---
title: Game engine selection
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[unity-engine-architecture]]"
  - "[[unreal-blueprint-cpp]]"
tags: [game-engine, unity, unreal, decision]
---

# Game engine selection

Choose an engine from the game's technical needs, the team's implementation language and content
workflow, shipping targets, and the cost of changing an existing architecture. Do not choose from
visual quality claims or AI integration alone.

## Why it works

Unity is a C#-centric workflow over a native core; Unreal is a C++ foundation designed to work
with Blueprint extensions. Unity is a natural fit when the project benefits from C# and a
component/editor-tool workflow. Unreal is a natural fit when the team wants C++ systems with a
first-class visual scripting layer for content and when its rendering and production ecosystem fit
the game. Both require profiling and target-device validation.

## The catch

Switching engines resets more than rendering. It changes asset import, build, UI, networking,
testing, editor tooling, team skills, and every integration. A live project should change engines
only for a demonstrated blocker that the existing architecture cannot reasonably solve.

## In practice here

[[minecwaft]] is already native C# with a Vulkan client, so Unity or Unreal would be a new project
decision, not an optimisation step. [[vrchat-homeworld]] necessarily follows Unity's ecosystem.
For a new game, create a one-week vertical-slice comparison with the target art, gameplay loop,
build target, and performance budget before committing.
