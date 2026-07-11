---
title: Godot JavaScriptBridge
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[godot-systems-batch-4-docs]]"
tags: [game-development, godot]
---

# Godot JavaScriptBridge

On **web exports only**, the `JavaScriptBridge` singleton talks to browser JavaScript: SDKs,
DOM events, downloads, and host-page APIs that Godot does not expose natively.

Always gate with `OS.has_feature("web")`. On other platforms the singleton is missing/null.

## Core APIs

| Method | Use |
|---|---|
| `get_interface("name")` | Global JS object (`console`, `window`, `Notification`) |
| `create_object("Array", …)` | `new` constructor |
| `create_callback(callable)` | JS → Godot; **keep the returned ref alive** |
| `eval(code, global_ctx=false)` | Run JS string; last value → GDScript if number/bool/string/buffer |
| `download_buffer(bytes, filename)` | Prompt user download (saves) |

Primitives auto-convert; objects/arrays/functions stay as `JavaScriptObject`.

```gdscript
func _ready() -> void:
    if not OS.has_feature("web"):
        return
    var console = JavaScriptBridge.get_interface("console")
    console.log("hello from Godot")
```

## Callbacks (memory model)

JS GC vs Godot refcount: **store callback refs** on the node until freed.

```gdscript
var _unload_cb = JavaScriptBridge.create_callback(_on_before_unload)

func _ready() -> void:
    if not OS.has_feature("web"):
        return
    var window = JavaScriptBridge.get_interface("window")
    window.onbeforeunload = _unload_cb

func _on_before_unload(args: Array) -> void:
    # MUST take exactly one Array (JS arguments object)
    var ev = args[0]
    ev.preventDefault()
    ev.returnValue = ""
```

Wrong arity → callback never fires.

## External libraries

Export **Head Include** (or custom HTML shell) to inject CDN scripts, then
`get_interface("axios")` etc. Permission prompts (notifications) should follow **user gesture**,
not only `_ready`.

## Downloads / saves on web

```gdscript
func offer_save_download(path: String) -> void:
    var f := FileAccess.open(path, FileAccess.READ)
    if f == null:
        return
    JavaScriptBridge.download_buffer(f.get_buffer(f.get_length()), path.get_file())
```

Pairs with [[godot-save-and-load]] and IndexedDB `user://` limits on web ([[godot-web-export]]).

## Security notes

- Some HTML5 templates strip eval for security.  
- `eval(..., true)` pollutes global scope — avoid unless required.  
- Never trust host page JS with secret game authority (multiplayer still needs server trust).

## AI builder checklist

- [ ] All bridge use behind `web` feature tag  
- [ ] Callback refs stored as member vars  
- [ ] Callbacks take single `Array`  
- [ ] SDKs loaded via Head Include / custom shell  
- [ ] User-gesture for permissions/autoplay-adjacent APIs  

## Related

- [[godot-web-export]] · [[godot-save-and-load]] · [[godot-export-and-release]]
