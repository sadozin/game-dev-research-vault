---
title: Unreal Android build
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[unreal-build-profiling-and-platforms]]"
tags: [game-development, unreal, android, platforms]
---

# Unreal Android build

Unreal Android builds combine engine packaging, Android SDK/NDK configuration, device profiles, texture
formats, signing, and store distribution choices.

## Why it works

Platform profiles and cooked formats let one project target a range of devices while producing installable
APK or AAB artifacts.

## The catch

GPU format support, memory, thermal limits, permissions, SDK versions, and packaging configuration vary
by device. A desktop preview cannot expose all mobile failures.

## In practice

Maintain representative device tiers, validate shipping configuration and signing, and measure startup,
memory, thermal, and texture behavior on physical hardware.

