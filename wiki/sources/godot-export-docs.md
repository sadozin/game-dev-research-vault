---
title: "Source: Godot — exporting projects"
type: source
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "raw/godot-exporting-projects.md"
tags: [source, godot, game-development]
---

# Source: Godot — exporting projects

- **Author:** Godot Engine documentation contributors
- **Published:** Godot 4.x stable documentation
- **URL:** https://docs.godotengine.org/en/stable/tutorials/export/exporting_projects.html
- **Retrieved:** 2026-07-11
- **Raw:** `raw/godot-exporting-projects.md` (provenance only)

## Summary

Export needs **presets** + **export templates**. Project → Export. Templates via Editor →
Manage Export Templates. Resource modes filter what packs into the build. Config:
`export_presets.cfg` (safe to commit) vs `.godot/export_credentials.cfg` (secrets — do not
commit). CLI: `godot --export-release "Preset Name" out.exe`. PCK (fast, opaque) vs ZIP
(smaller, mod-friendly). Dot-prefixed files never export.

## Compiled into

- [[godot-export-and-release]]
