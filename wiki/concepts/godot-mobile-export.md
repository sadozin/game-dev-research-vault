---
title: Godot mobile export
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[godot-systems-batch-4-docs]]"
tags: [game-development, godot]
---

# Godot mobile export

Shipping to phones is a **toolchain + permissions + icons + signing** problem layered on the
same game project. Profile on device early; mobile is slower than desktop and web is slower
still ([[godot-web-export]]).

C# Android/iOS support exists from Godot 4.2 but is **experimental** with platform limits —
prefer GDScript for reliability unless you accept the constraints.

## Android

### Setup once (Editor Settings)

1. Install **OpenJDK 17** (recommended; higher may work).  
2. Install **Android SDK** via Android Studio (Platform 35, build-tools, platform-tools, cmdline-tools, NDK r28b-class, CMake as docs specify).  
3. Editor Settings → Android:  
   - **Java SDK Path** → JDK  
   - **Android SDK Path** → folder containing `platform-tools/adb`  

Do not use distro-outdated SDKs on Linux.

### Export checklist

- [ ] Export templates installed  
- [ ] Package name unique; uninstall old same-package different-key builds if install fails  
- [ ] **INTERNET** permission if multiplayer/HTTP  
- [ ] Icons: main ≥192, adaptive fg/bg ≥432, keep art in **safe zone** (center ~66dp circle)  
- [ ] Debug keystore for dev; **release** keystore for stores  

### Google Play

- New apps: **AAB** via Gradle Android build pipeline (see Gradle export docs).  
- Sign with release keystore (`keytool -genkey …`).  
- Export preset: Release path/user/password; **uncheck Export With Debug**.  

```text
keytool -v -genkey -keystore mygame.keystore -alias mygame -keyalg RSA -validity 10000
```

Keep passwords safe; avoid exotic special characters that break tools.

### Size

Compile custom export templates with unused modules disabled for smaller APKs when needed.

## iOS

### Hard requirements

- Export **from macOS with Xcode**.  
- Export templates installed.  
- Preset **App Store Team ID** (10-char code, not display name) + **Bundle Identifier**
  (reverse-DNS `com.example.game`, alphanumeric/hyphen/dot only).  

Malformed Team ID → cryptic JSON errors.

### Flow

1. Project → Export → Add iOS.  
2. Fill Application fields.  
3. Export into **empty folder**; project name without spaces.  
4. Open `.xcodeproj` in Xcode → run on device/App Store flow.  

**Simulator** supports **Compatibility** renderer only. Apple Silicon Macs can run iOS apps
natively with fewer simulator limits.

### Faster iteration (link project folder)

Export once, then in Xcode:

1. Drag Godot project folder as **Reference files in place**.  
2. Fix File Inspector location/membership.  
3. Remove exported `.pck`.  
4. Info.plist string key `godot_path` = project folder name.  

Edit in Godot, rebuild in Xcode without full re-export each time. Project folder name must
differ from Xcode target name (signing).

### xcode-select SDK path

If export looks for SDK under CommandLineTools wrongly:

```bash
sudo xcode-select -switch /Applications/Xcode.app
```

## Performance habits on mobile

```gdscript
if OS.has_feature("mobile") or OS.has_feature("android") or OS.has_feature("ios"):
    # fewer shadows, lower MSAA, simpler particles
    pass
```

Touch input, battery thermal throttling, and fill-rate matter more than on PC
([[godot-debug-and-profiler]]).

## AI builder checklist

- [ ] Desktop vertical slice works first  
- [ ] Input Map includes touch/gamepad where needed  
- [ ] Android SDK paths set before blaming Godot  
- [ ] Package name / bundle ID permanent decision  
- [ ] Permissions listed (camera, mic, internet)  
- [ ] Icons adaptive rules followed  
- [ ] Real device test (not only emulator)  
- [ ] Secrets (keystores, profiles) not in public git  

## Related

- [[godot-export-and-release]] · [[godot-web-export]] · [[godot-input-handling]] ·
  [[godot-multiplayer]] · [[godot-ai-build-playbook]]
