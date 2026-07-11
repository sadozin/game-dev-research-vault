---
title: Godot audio
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[godot-systems-batch-2-docs]]"
tags: [game-development, godot]
---

# Godot audio

Godot routes sound through **buses** measured in **decibels**, played by **AudioStreamPlayer**
nodes loading **AudioStream** resources. Design like a tiny DAW: SFX, music, UI, and voice on
separate buses feeding Master.

## Decibels (quick rules)

- **0 dB** = digital full scale (clipping above this on Master is bad).
- Every **−6 dB** ≈ half amplitude.
- Practical silence ~ **−60 to −80 dB**.
- Keep Master peaks under 0 dB.

## Buses

Editor bottom panel **Audio**:

- Leftmost = **Master** (to speakers).
- Other buses process effects then send **leftward** to a chosen bus (no loops).
- Silent buses auto-disable after a few seconds (saves CPU).
- Players reference buses **by name** — renaming breaks routing; reordering is safer.
- Default layout: `res://default_bus_layout.tres`.

### Recommended starter layout

```
Master
├── Music   (compressor optional, send → Master)
├── SFX     (send → Master)
├── UI      (send → Master)
└── Voice   (send → Master)
```

Mute/solo Music independently of SFX. Duck Music when Voice plays via sidechain if needed
(effects chain).

## Players

| Node | Use |
|---|---|
| `AudioStreamPlayer` | Non-positional (UI, music, 2D HUD beeps) |
| `AudioStreamPlayer2D` | Stereo pan by 2D position |
| `AudioStreamPlayer3D` | 3D spatial; stereo/5.1/7.1 |

```gdscript
$HitSFX.stream = preload("res://assets/audio/sfx/hit.ogg")
$HitSFX.bus = "SFX"
$HitSFX.play()
```

### Variation

`AudioStreamRandomizer` picks among clips and can randomize pitch/volume — use for footsteps
and repeated hits so they do not sound robotic.

## Area routing

- **Area2D / Area3D** can divert contained stream players to special buses (cave reverb, underwater LP filter).
- 3D Areas support **Reverb Bus** dry/wet split + uniformity for warehouse-like spaces.
- Put **Reverb** effects on those buses.

## Doppler (3D)

Enable velocity tracking on AudioStreamPlayer3D and Camera (`Idle` vs `Physics` matching how
you move objects). Web **Sample** playback mode may not support reverb/doppler the same way —
check web export audio docs.

## Music patterns

```gdscript
# Simple crossfade
func crossfade_to(next: AudioStream, duration := 1.0) -> void:
    var a := $MusicA
    var b := $MusicB
    b.stream = next
    b.volume_db = -80
    b.play()
    var tw := create_tween().set_parallel()
    tw.tween_property(a, "volume_db", -80.0, duration)
    tw.tween_property(b, "volume_db", 0.0, duration)
    await tw.finished
    a.stop()
    # swap roles next time
```

Sync gameplay to music via audio position APIs when needed (beat games).

## Autoload Audio service (optional)

```gdscript
# Audio.gd Autoload
func play_sfx(stream: AudioStream, bus := "SFX") -> void:
    var p := AudioStreamPlayer.new()
    add_child(p)
    p.bus = bus
    p.stream = stream
    p.play()
    p.finished.connect(p.queue_free)
```

For positional SFX, prefer players parented to the emitter node instead.

## AI builder checklist

- [ ] Separate Music / SFX / UI buses  
- [ ] All SFX on SFX bus; volume slider sets bus volume_db  
- [ ] Import settings correct (loop for music, not for one-shots)  
- [ ] Randomizer for spammy SFX  
- [ ] Master never clips in loud scenes  
- [ ] Pause: lower Music bus or pause stream players via process_mode  

## Related

- [[godot-autoloads]] · [[godot-resources-and-data]] · [[godot-ai-build-playbook]]
