---
title: Unity NavMesh agents
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[unity-navigation-agents]]"
tags: [game-development, unity, ai, navigation]
---

# Unity NavMesh agents

NavMesh agents query baked traversable surfaces and steer an agent toward a destination.

## Why it works

The baked mesh turns expensive world geometry into a compact navigation representation, while agent
settings express radius, height, speed, stopping, and avoidance behavior.

## The catch

An agent can have a valid path but still fail to move, avoid crowds, fit a door, or react to a changed
world. Destination updates and dynamic links also have update and ownership costs.

## In practice

Validate agent dimensions against the bake, separate path planning from local steering, and test
dynamic obstacles and off-mesh transitions on target scenes.

