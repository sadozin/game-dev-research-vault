---
title: Godot UI controls
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[godot-ui-docs]]"
tags: [game-development, godot, ui]
---

# Godot UI controls

All Godot UI is built from **Control** nodes. You place content controls (what the player
sees and clicks) inside layout controls (how things resize on different screens).

If something is a HUD, menu, inventory, or dialog, it should live under a `Control` tree —
not as free-floating `Node2D` labels in world space (unless you deliberately want world UI).

## Two groups of controls

### Content (what)

| Node | Role |
|---|---|
| `Label` | Static or dynamic text |
| `RichTextLabel` | BBCode / fancy text |
| `Button` | Click / focus action |
| `LineEdit` / `TextEdit` | Text input |
| `TextureRect` | Image in UI space |
| `ProgressBar` / `TextureProgressBar` | Bars and meters |
| `ItemList`, `Tree`, etc. | Complex lists |

### Layout (how)

| Node | Role |
|---|---|
| `MarginContainer` | Padding around children |
| `HBoxContainer` / `VBoxContainer` | Row / column |
| `GridContainer` | Grid of cells |
| `CenterContainer` | Center children at min size |
| `ScrollContainer` | Scroll one large child |
| `TabContainer` | Tabs of pages |
| `PanelContainer` | Background + fill children |
| `HSplitContainer` / `VSplitContainer` | Draggable split |
| `AspectRatioContainer` | Keep proportions |
| `HFlowContainer` / `VFlowContainer` | Wrapping flow |

## Anchors vs containers

### Anchors + offsets (simple layouts)

Every Control has **anchors** (0.0–1.0 on parent edges) and **offsets** (pixels from those
anchors).

- Anchors at top-left `(0,0)`: classic fixed placement.
- Anchors at bottom-right `(1,1)`: stick to corner.
- Anchors at center `(0.5,0.5)`: center with half-size offsets.

Use the editor **Anchor presets** toolbar instead of typing numbers at first.

### Containers (complex layouts)

When a parent is a **Container**, it **owns** child positions. Manual dragging is reset when
the container sorts. That is a feature: nested boxes rebuild responsive menus like a desktop
app. The Godot editor UI itself is container-based.

**Child sizing flags** (per axis):

| Flag | Meaning |
|---|---|
| Fill | Occupy the area the container assigned |
| Expand | Fight for extra free space |
| Shrink Begin/Center/End | Align inside expanded area |
| Stretch Ratio | Relative share of space (2 takes twice 1) |

**Practical recipe for a pause menu:**

```
Control (full rect anchors)
└── CenterContainer
    └── PanelContainer
        └── VBoxContainer
            ├── Label (title)
            ├── Button (Resume)
            └── Button (Quit)
```

## Theming

Use **Theme** resources to set fonts, colors, and StyleBoxes project-wide. Prefer themes over
per-button one-off colors once the UI has more than a few screens.

## Input and focus

UI navigation (keyboard/gamepad) depends on focus. Buttons and LineEdits participate in focus
by default. Design menus so focus neighbors make sense for controllers.

Connect `Button.pressed` with signals ([[godot-signals]]) rather than polling.

## Why it works

Control trees separate **content** from **layout policy**. Anchors solve "stick this HUD
corner." Containers solve "this inventory must reflow on every resolution." Themes keep look
consistent.

## The catch

- Mixing manual anchors inside containers fights the layout system — pick one approach per
  subtree.
- Drawing world-space damage numbers is not the same problem as screen UI; use `Label3D` /
  sprites in world or a screen-space layer intentionally.
- Very deep container nests are hard to debug — name nodes and use the remote scene tree while
  running.

## Deep recipes for builders

### Full-screen HUD pattern

```
CanvasLayer (layer=10)
└── Control (anchors full rect, mouse_filter=IGNORE)
    └── MarginContainer
        └── HBoxContainer
            ├── Label (score)
            └── TextureProgressBar (health)
```

`CanvasLayer` keeps HUD on top of world. `mouse_filter=IGNORE` on root Control lets clicks pass
to the game when not on widgets.

### Pause menu

```
CanvasLayer
└── Control full rect (mouse_filter=STOP when visible)
    └── ColorRect dim
    └── CenterContainer → VBox → Resume/Quit buttons
```

```gdscript
func open_pause() -> void:
    visible = true
    get_tree().paused = true
    $VBox/Resume.grab_focus()
    process_mode = Node.PROCESS_MODE_ALWAYS
```

### Theme once

Create `res://resources/ui_theme.tres`, assign on root GUI. Override only special widgets.

### Safe dynamic text

```gdscript
score_label.text = "Score: %d" % score
# Prefer % or string format; avoid per-frame string work in huge UIs if profiling says so
```

### Connect buttons in code for spawned UI

```gdscript
button.pressed.connect(_on_button_pressed)
```

### Resolution

Use Project Settings → Display → Window stretch mode (`canvas_items` common for 2D) and aspect
(`expand` / `keep`) deliberately; test multiple sizes early.

## Related

- [[godot-nodes-and-scenes]] · [[godot-signals]] · [[godot-engine-workflow]] ·
  [[godot-input-handling]] · [[godot-ai-build-playbook]]
