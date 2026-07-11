---
title: Godot web export
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[godot-systems-batch-3-docs]]"
tags: [game-development, godot]
---

# Godot web export

HTML5/WebAssembly export runs Godot in the browser with **WebGL 2.0**. It is the most
constrained ship target: fewer graphics APIs, browser security rules, and weaker performance
than native.

## Hard limits (Godot 4)

| Topic | Reality |
|---|---|
| Renderer | **Compatibility** / WebGL2 only — not Forward+ or Mobile |
| C# | **Not supported** on Godot 4 web (use GDScript or Godot 3) |
| Threads | Optional; need cross-origin isolation headers or PWA workaround |
| Default threads | **Single-thread export preferred/default** (4.3+) — better host compatibility |
| Low-level sockets | No raw TCP/UDP — use HTTP, WebSocket, WebRTC |
| Background tab | `_process` / physics pause when tab hidden — net games may disconnect |

## Export hygiene

- Prefer export filename **`index.html`** (and do not rename sibling wasm/pck/js unpredictably).
- Each project regenerates its HTML; customize via **Custom HTML shell**, not hand-editing.
- Enable **VRAM Texture Compression** for desktop/mobile as needed (both = larger, more compatible).
- GDExtension needs **Extension Support** + web-built extensions + often isolation headers.

## Audio on web (major gotcha)

Since 4.3 default is **Sample** mode (Web Audio API) for low latency without threads:

**Sample mode cannot:** AudioEffects on buses, reverb/doppler areas, procedural audio the same way.

To use full Godot audio graph: set playback type to **Stream** (project setting
`Audio > General > Default Playback Type.web` or per-player). Cost: more latency especially
without threads.

**Autoplay:** browsers block sound until a user gesture — show "Click to start" first.

See also [[godot-audio]].

## Persistence

- `user://` uses IndexedDB/cookies — users must allow storage; private mode may fail.
- `OS.is_userfs_persistent()` can false-positive.
- Saves in iframes need third-party cookie permissions.

## Input quirks

- Fullscreen and mouse capture only from a **real input event callback** (`_input` /
  `_unhandled_input` with active event) — not from random `_ready` or polled checks.
- Gamepads often appear only after a button press; mappings can be wrong.

## Serving files

| File | Notes |
|---|---|
| `.html` | Shell / index |
| `.wasm` | Engine — MIME `application/wasm` |
| `.pck` | Game data |
| `.js` | Bootstrap |

Compress wasm/pck (gzip/brotli). For **threads**, send:

```
Cross-Origin-Opener-Policy: same-origin
Cross-Origin-Embedder-Policy: require-corp
```

Or enable **PWA** export option to inject isolation via service worker. Without headers/PWA,
threaded builds will not run.

Local test: Godot's `serve.py` for the web platform is fine for dev, not production.

## Feature tags for low-end web

```gdscript
if OS.has_feature("web"):
    # reduce shadows, particles, resolution scale
    pass
```

## AI builder checklist

- [ ] No C# dependency for web target  
- [ ] Single-thread export unless you control COOP/COEP  
- [ ] Click-to-start for audio  
- [ ] Sample vs Stream decision documented  
- [ ] Mouse capture only on click  
- [ ] Networking via WebSocket/WebRTC if multiplayer  
- [ ] Test on mobile browser early  
- [ ] Service worker cache bust when testing multiple projects  

## Related

- [[godot-export-and-release]] · [[godot-audio]] · [[godot-multiplayer]] · [[godot-ai-build-playbook]]
