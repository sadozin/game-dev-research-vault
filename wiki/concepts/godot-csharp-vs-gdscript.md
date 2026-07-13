---
title: Godot C# versus GDScript
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[godot-languages-and-native-extensions]]"
tags: [game-development, godot, programming]
---

# Godot C# versus GDScript

GDScript is Godot’s tightly integrated scripting language; C# brings .NET language, tooling, and library
experience with different deployment and interop costs.

## Why it works

GDScript offers fast engine-oriented iteration and concise scene code, while C# can suit teams with
existing .NET practices, stronger static tooling, or shared libraries.

## The catch

Language choice affects editor integration, build/export targets, garbage collection behavior, interop,
and examples available in the ecosystem. Mixing languages can add boundary friction.

## In practice

Choose per project and hot path, prototype the actual export target early, and keep cross-language APIs
small and data-oriented.

