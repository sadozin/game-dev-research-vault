---
title: Godot high-level multiplayer
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[godot-systems-batch-2-docs]]"
tags: [game-development, godot]
---

# Godot high-level multiplayer

Godot's **high-level multiplayer** sits on SceneTree: peers connect, nodes share paths, and
functions marked `@rpc` run on remote machines. It trades raw socket control for faster game
sync. Prefer this over hand-rolled TCP/UDP for most games.

**Do not start multiplayer before a solid single-player slice** ([[godot-ai-build-playbook]]).
Networking multiplies every architecture bug.

## Mental model

| Piece | Role |
|---|---|
| `MultiplayerPeer` | Transport (ENet, WebRTC, WebSocket, …) |
| `MultiplayerAPI` | Per-tree API; default on every node as `multiplayer` |
| Peer ID | Server is always **1**; clients get positive random IDs |
| `@rpc` function | Callable remotely if signatures match on all peers |
| Multiplayer authority | Which peer may call `authority` RPCs on a node |

```gdscript
# Host
var peer := ENetMultiplayerPeer.new()
peer.create_server(PORT, MAX_CLIENTS)
multiplayer.multiplayer_peer = peer

# Client
var peer := ENetMultiplayerPeer.new()
peer.create_client(ADDRESS, PORT)
multiplayer.multiplayer_peer = peer

# Offline again
multiplayer.multiplayer_peer = OfflineMultiplayerPeer.new()
```

Android exports need the **INTERNET** permission. LAN uses private IPs; internet needs UDP port
forward + public IP. ENet path is UDP-based.

## Connection signals

```gdscript
multiplayer.peer_connected.connect(_on_peer_connected)
multiplayer.peer_disconnected.connect(_on_peer_disconnected)
# clients only:
multiplayer.connected_to_server.connect(_on_connected)
multiplayer.connection_failed.connect(_on_fail)
multiplayer.server_disconnected.connect(_on_server_gone)
```

## RPCs (core skill)

```gdscript
@rpc("any_peer", "call_local", "reliable")
func transfer_input(dir: Vector2) -> void:
    var sender := multiplayer.get_remote_sender_id()
    # server validates and applies
```

Call with:

```gdscript
transfer_input.rpc(dir)           # all peers (per mode)
transfer_input.rpc_id(1, dir)     # server only
```

### `@rpc` parameters

| Param | Options | Meaning |
|---|---|---|
| mode | `authority` (default), `any_peer` | Who may invoke remotely |
| sync | `call_remote` (default), `call_local` | Also run on caller? |
| transfer | `reliable`, `unreliable`, `unreliable_ordered` | Delivery guarantee |
| channel | int (last arg) | Separate streams so chat ≠ gameplay stall |

Defaults equal: `@rpc("authority", "call_remote", "reliable", 0)`.

### Hard RPC rules (break these → mysterious errors)

1. RPC methods must live on **Node** scripts, not bare Resources.
2. **Same NodePath** on every peer for that node (same names in tree).
3. When `add_child` nodes that use RPCs, use `force_readable_name = true` if needed for stable names.
4. **Every** `@rpc` on client scripts must exist on server scripts with matching signature
   checksum (declare unused RPCs too if the other side has them).
5. Objects and Callables do **not** serialize in RPCs — send primitives, dictionaries, arrays of
   basic types, peer IDs.

## Authority

```gdscript
# Server owns this node by default (authority 1)
$Enemy.set_multiplayer_authority(1)
# Player's input-owned puppet might be:
player.set_multiplayer_authority(peer_id)
```

`authority` RPCs only succeed from the authority peer.

## Secure design (non-optional for public games)

| Trust | Do not trust clients for |
|---|---|
| Server decides | Hit results, inventory, scores, match end |
| Client may send | Input intent, UI choices (still validate) |

```gdscript
@rpc("any_peer", "reliable")
func request_shoot(aim: Vector2) -> void:
    var id := multiplayer.get_remote_sender_id()
    if not _rate_ok(id):
        return
    if not _aim_sane(aim):
        return
    _server_spawn_bullet(id, aim)
```

Prefer: **client input → server simulation → replicate state**, not client-authoritative
positions for competitive play.

## Channels

Use separate channels so large reliable chat does not delay small reliable combat packets.
`unreliable_ordered` on mixed packet sizes can drop lagging packets — homogeneous streams help.

## Lobby skeleton (what to implement)

1. Autoload `Lobby` holds `players: Dictionary` peer_id → info.
2. On connect, exchange `player_info` via RPC.
3. Host starts: `load_game.rpc(path)` with `call_local`.
4. Each peer `player_loaded.rpc_id(1)` when scene ready.
5. Server counts loads, then `start_game()`.

See official high-level multiplayer doc lobby sample for full code structure.

## Dedicated servers

Export **dedicated server** preset strips visuals. Server should not always be a "player"; first
joiner or matchmaker starts the match. Modify lobby samples accordingly
([[godot-export-and-release]]).

## Authentication hook

`SceneMultiplayer` supports `auth_callback` / `send_auth` / `complete_auth` before
`peer_connected` fires — use for password or token checks online.

## AI builder checklist

- [ ] Single-player works offline first  
- [ ] Scene trees and node names match across peers  
- [ ] All `@rpc` declared on both sides  
- [ ] Gameplay-critical state is server-authoritative  
- [ ] Input RPCs rate-limited and validated  
- [ ] Test 2 clients + host on LAN before internet  
- [ ] Android INTERNET permission if shipping mobile  

## Related

- [[godot-scene-architecture]] · [[godot-autoloads]] · [[godot-export-and-release]] ·
  [[godot-ai-build-playbook]]
