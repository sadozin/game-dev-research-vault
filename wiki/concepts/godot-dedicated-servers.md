---
title: Godot dedicated servers
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[godot-systems-batch-3-docs]]"
tags: [game-development, godot]
---

# Godot dedicated servers

A **dedicated server** runs game authority without a player-facing GPU window. In Godot 4 you
use a normal export template (or editor binary) with **`--headless`** / dedicated-server export
mode — not a separate Godot 3-style server binary.

Pair with [[godot-multiplayer]] (server authority, RPCs).

## Why strip the pack

A normal client PCK includes textures, music, high meshes. Servers usually need **logic +
collision + nav**, not VRAM art. Dedicated export shrinks size and memory.

## Export as dedicated server

1. Create a **separate export preset** for the host OS.  
2. Resources tab → mode **Export as dedicated server**.  
3. This adds feature tag `dedicated_server` and forces headless-friendly behavior.  
4. Per-file/folder options:

| Option | Meaning |
|---|---|
| **Strip Visuals** | Keep resource refs; textures/materials → placeholders (size retained for layout) |
| **Keep** | Full resource (e.g. image used to generate collision) |
| **Remove** | Omit file — **breaks** scenes that still reference it |

Default strategy: **Strip Visuals** everywhere; **Keep** only data the server must read as
pixels; **Remove** pure client UI scenes only if nothing loads them.

Inspect pack structure via **Export PCK/ZIP** as `.zip`.

## Detect server at runtime

```gdscript
# Feature tag (case-sensitive)
if OS.has_feature("dedicated_server"):
    _start_server()

# Or headless display
if DisplayServer.get_name() == "headless":
    _start_server()

# Or custom CLI user arg: godot -- --server
if "--server" in OS.get_cmdline_user_args():
    _start_server()
```

Prefer at least one CLI path so you can test without re-exporting every time.

## Process model

```gdscript
func _start_server() -> void:
    var peer := ENetMultiplayerPeer.new()
    peer.create_server(PORT, MAX_CLIENTS)
    multiplayer.multiplayer_peer = peer
    # load game world, do NOT treat peer 1 as a local human if design is pure dedicated
```

Differences from listen-server host-as-player:

- Server may have **no** player avatar.  
- First client or matchmaker starts the match, not "host presses Start" on a ghost client.  
- No GPU-dependent code paths (or guard them).

## Ops tips

- **Linux systemd** service for restart-on-crash; enable
  `application/run/flush_stdout_on_print` for journald logs.  
- **Docker** for scale-out (orchestration is out of scope).  
- Use **export template** binary for production, not the editor binary.  
- Open **UDP** ports for ENet; firewall carefully.

## AI builder checklist

- [ ] Separate server export preset  
- [ ] Strip visuals validated (server still loads main scene)  
- [ ] Server is not assumed to be a player  
- [ ] CLI `--headless` / `--server` tested  
- [ ] Auth + validation on RPCs ([[godot-multiplayer]])  
- [ ] Logs + restart policy on host  

## Related

- [[godot-multiplayer]] · [[godot-export-and-release]] · [[godot-save-and-load]]
