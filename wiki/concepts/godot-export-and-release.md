---
title: Godot export and release
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[godot-export-docs]]"
tags: [game-development, godot]
---

# Godot export and release

**Export** turns an editor project into a player-facing build: platform executable + packed
game data (or a store package). Running the game inside the editor is not the same as a
release build.

## What you need

1. **Export preset** — Project → Export → Add… → pick platform (Windows, Linux, macOS, Android,
   Web, …).
2. **Export templates** — Editor → Manage Export Templates… → install templates matching your
   Godot version.
3. Platform **SDK** tools when required (Android SDK, etc.). The export dialog lists missing
   pieces until fixed.

Without templates, export is blocked.

## What gets packed

Resource export modes include:

- All resources
- Selected scenes / resources + dependencies
- All except listed excludes
- Dedicated server (strips most visuals to placeholders)

Filters can include non-resources (`.json`, `.csv`) or exclude types (e.g. all `.png` if you
ship elsewhere).

Files and folders starting with `.` are **never** exported (keeps `.git` out of packs).

## Config files (version control)

| File | Commit? | Contents |
|---|---|---|
| `export_presets.cfg` | Yes (usually) | Preset settings, non-secret |
| `.godot/export_credentials.cfg` | **No** | Passwords, keys, secrets |

Clone on a new machine → copy credentials carefully or re-enter secrets.

## Desktop vs mobile intuition

- **Desktop:** export produces runnable binary + data; texture compression is relatively
  standardized.
- **Mobile / consoles:** native project wrappers, platform texture formats, signing, store
  metadata — more moving parts.

## Command-line export (CI)

```text
godot --path /path/to/project --export-release "Windows Desktop" game.exe
godot --export-debug "Windows Desktop" game_debug.exe
godot --export-pack "Windows Desktop" game.pck
```

Preset **name** must match exactly (quote if it has spaces). Output path is relative to the
**project**, not necessarily the shell cwd.

## PCK vs ZIP data packs

| Format | Pros | Cons |
|---|---|---|
| **PCK** | Fast read; default | Opaque to normal OS tools |
| **ZIP** | Smaller; easy modding | Slower; needs launcher flag in some setups |

## Release checklist (practical)

1. Set main scene and project name/version.
2. Test **export debug** on target OS before release.
3. Strip debug-only content via export filters if needed.
4. Verify input works without editor shortcuts assumptions.
5. Profile on low-end target hardware ([[game-performance-profiling]]).
6. Keep secrets out of git; automate export in CI when stable.

## Why it works

Presets capture platform quirks once. Templates provide headless-engine binaries without
shipping the editor. Packs separate game data from the runtime for DLC and updates.

## The catch

- Template version must match editor version.
- "Works in editor" ≠ "works exported" (paths, feature tags, permissions).
- Forgetting credentials on a clean CI agent fails signing/export silently until configured.

## Related

- [[godot-engine-workflow]] · [[godot-nodes-and-scenes]] · [[game-performance-profiling]]
