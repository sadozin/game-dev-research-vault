---
title: Godot save and load
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[godot-systems-batch-2-docs]]"
tags: [game-development, godot]
---

# Godot save and load

Games need three different persistence problems. Do not mix them:

| Problem | Tool | Path |
|---|---|---|
| User settings (volume, keybinds) | `ConfigFile` | `user://settings.cfg` |
| Game saves (progress, world) | JSON lines / binary vars / custom | `user://save_01.dat` |
| Ship content | Resources / scenes | `res://` (read-only in export) |

Always write saves under **`user://`**, never `res://` in a shipped build.

## Identify what to persist

List **facts**, not whole node trees:

- Player stats, inventory IDs, quest flags  
- Current level id + spawn id  
- Seed / RNG state if needed  
- Unlocked upgrades  

Prefer serializing **data** (dictionaries / Resources) over reconstructing every node from disk
when possible. For many placed entities, Godot's official pattern uses a **Persist** group.

## JSON line save (official scalable pattern)

1. Mark savable instanced scenes with group `Persist`.  
2. Each implements `save() -> Dictionary` including `filename` (scene path) and `parent` path.  
3. On save: for each persist node, `JSON.stringify` → `store_line` to file.  
4. On load: free old persist nodes, read lines, `instantiate`, reparent, set properties.

```gdscript
func save() -> Dictionary:
    return {
        "filename": scene_file_path,
        "parent": str(get_parent().get_path()),
        "pos_x": global_position.x,
        "pos_y": global_position.y,
        "health": health,
    }
```

```gdscript
func save_game() -> void:
    var f := FileAccess.open("user://savegame.save", FileAccess.WRITE)
    for node in get_tree().get_nodes_in_group("Persist"):
        if node.scene_file_path.is_empty():
            continue
        if not node.has_method("save"):
            continue
        f.store_line(JSON.stringify(node.call("save")))
```

### Load caveats

- Reset world before load or you duplicate entities.  
- Nested Persist parent/child: load parents first or avoid nesting Persist.  
- JSON lacks Vector2/Color — split components or use binary.  
- Property names set via `set()` must match script properties.

## Binary serialization

```gdscript
f.store_var(data_dict)
var data = f.get_var()
```

Handles more Godot types; smaller files; less human-readable. Only properties with storage usage
serialize for Objects — know `PROPERTY_USAGE_STORAGE`.

## ConfigFile for settings

```gdscript
var cfg := ConfigFile.new()
cfg.set_value("audio", "music_db", -6.0)
cfg.save("user://settings.cfg")
cfg.load("user://settings.cfg")
var db: float = cfg.get_value("audio", "music_db", 0.0)
```

## Versioning

Always store a `save_version` integer. On load, migrate old formats:

```gdscript
if data.get("save_version", 1) < 2:
    data = _migrate_v1_to_v2(data)
```

## Security and cheating

Single-player: plain JSON is fine for most indie games.  
Competitive / online economy: do not trust client saves; server is source of truth
([[godot-multiplayer]]).

Optional: checksum or encryption for mild tamper resistance — not real security.

## Autoload Save service sketch

```gdscript
# Save.gd
const PATH := "user://save_slot_%d.json"

func write_slot(slot: int, data: Dictionary) -> void:
    data["save_version"] = 1
    data["timestamp"] = Time.get_unix_time_from_system()
    var f := FileAccess.open(PATH % slot, FileAccess.WRITE)
    f.store_string(JSON.stringify(data))

func read_slot(slot: int) -> Dictionary:
    var path := PATH % slot
    if not FileAccess.file_exists(path):
        return {}
    var txt := FileAccess.get_file_as_string(path)
    var json := JSON.new()
    if json.parse(txt) != OK:
        return {}
    return json.data
```

For many games, **one blob** (run state Resource duplicated to dict) is simpler than Persist
nodes until you need many dynamic entities.

## AI builder checklist

- [ ] `user://` only for writable data  
- [ ] Settings ≠ save game files  
- [ ] Version field present  
- [ ] Load tested after scene change and after cold start  
- [ ] Failures handled (missing file, parse error)  
- [ ] No secrets in saves committed to git  

## Related

- [[godot-resources-and-data]] · [[godot-autoloads]] · [[godot-multiplayer]] ·
  [[godot-ai-build-playbook]]
