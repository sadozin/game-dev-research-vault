---
title: Mobile game development
type: concept
status: active
created: 2026-07-20
updated: 2026-07-20
verified: 2026-07-20
sources: []
tags: [game-development, mobile, game-engine, unity, godot, unreal, android, ios]
---

# Mobile game development

Building games for iOS and Android phones and tablets. Mobile is the largest gaming platform
by revenue and player count, but it imposes hard constraints that desktop/console development
does not: thermal envelopes, battery life, fragmented hardware, touch-only input, short
attention windows, and app-store gatekeeping. Every design, rendering, and architecture
decision must respect these constraints from day one — retrofitting a desktop game for mobile
almost always fails.

## Platform landscape

### iOS

Apple controls the full stack: hardware (A-series and M-series chips), OS (iOS/iPadOS),
graphics API (Metal), distribution (App Store), and payment (StoreKit with 15–30% commission).
The hardware is homogeneous enough that a small set of device profiles covers the fleet.
Minimum deployment target matters: each iOS version drops older devices, and the App Store
review process enforces current SDK requirements. Swift/Objective-C for native, but engines
abstract this away.

### Android

Fragmented by design. Thousands of device models, multiple SoC vendors (Qualcomm Snapdragon,
MediaTek Dimensity, Samsung Exynos, Google Tensor), GPU families (Adreno, Mali, PowerVR,
Xclipse), screen sizes, aspect ratios, and OS versions in active use. Google Play is the
primary store but not the only one — Samsung Galaxy Store, Amazon Appstore, and regional
stores (especially in China: Huawei AppGallery, Xiaomi, OPPO, Vivo) each have their own
review and SDK requirements. Graphics APIs: Vulkan (preferred on modern devices) and
OpenGL ES 3.x (fallback). Java/Kotlin for native.

### Key differences from desktop/console

| Constraint | Desktop/Console | Mobile |
|---|---|---|
| Thermal | Active cooling, sustained load | Passive cooling, throttles in 5–15 min |
| Memory | 16–64 GB typical | 4–12 GB, shared with GPU and OS |
| GPU | Dedicated, high TDP | Integrated, power-limited, tile-based |
| Input | Keyboard/mouse/gamepad | Touch (capacitive), optional gamepad |
| Session | 30 min–hours | 2–10 min typical |
| Connectivity | Stable broadband | Intermittent cellular/Wi-Fi transitions |
| Distribution | Steam/Epic/direct | App Store / Google Play (30% cut, review) |
| Update cadence | Instant patches | Store review (hours to days) |

## Engine choice for mobile

All three major engines ship to mobile, but with different strengths:

**Unity** is the dominant mobile engine by market share. C# scripting, mature mobile
rendering pipeline (URP is the mobile-first renderer), extensive platform SDK integrations
(ad networks, analytics, push notifications), and the largest mobile asset/plugin ecosystem.
IL2CPP compiles C# to native C++ for performance. The runtime fee controversy (2023, later
revised) damaged trust but the tooling remains the most complete for mobile.

**Godot** is the lightweight open-source option. GDScript or C# (experimental on mobile).
The Compatibility renderer (OpenGL ES 3.0 / WebGL2) targets low-end devices; the Mobile
renderer (Vulkan subset) targets mid-to-high-end. No licensing fees, no revenue share.
Smaller plugin ecosystem than Unity but growing. See [[godot-mobile-export]] for the
full export workflow.

**Unreal Engine** targets high-fidelity mobile games (PUBG Mobile, Fortnite Mobile,
Genshin Impact uses a custom engine but Unreal-class rendering). C++ or Blueprints.
The heaviest binary size and memory footprint of the three. Best when visual fidelity
is the differentiator and the target is mid-to-high-end devices only. Forward renderer
with Vulkan/Metal. 5% royalty after $1M revenue.

For 2D or casual mobile games, Godot or Unity are the practical choices. For 3D
high-fidelity, Unity URP or Unreal. For hyper-casual, Godot's small binary and fast
iteration win. See [[game-engine-selection]] for the general framework.

## Development workflow

1. **Prototype on desktop** — build and iterate in the editor, test game logic fast.
2. **Deploy to device early** — the first on-device build should happen in week one,
   not week ten. Performance, input feel, and readability are all different on a phone.
3. **Profile on target hardware** — use the engine's mobile profiler (Unity Profiler,
   Godot remote debug, Unreal GPU Visualizer) on the lowest-spec target device.
4. **Automate builds** — CI/CD (Jenkins, GitHub Actions, Fastlane) for daily device
   builds. Manual export/signing is error-prone and slow.
5. **Test on real devices** — emulators lie about performance, thermal behavior, and
   touch input. Keep a small device lab: one low-end Android, one mid-range, one
   iPhone SE-class, one current iPhone.

## The mobile-specific disciplines

Mobile game development is not "desktop game development on a smaller screen." It has
its own design, performance, and business disciplines:

- **Design for touch and short sessions** — [[mobile-game-design-principles]]
- **Respect the thermal and memory envelope** — [[mobile-game-performance]]
- **Choose a monetization model before building the loop** — [[mobile-game-monetization]]
- **Navigate store requirements and discoverability** — [[mobile-game-publishing]]

## Related

- [[game-engine-selection]] · [[godot-mobile-export]] · [[unity-engine-workflow]] ·
  [[unreal-engine-workflow]] · [[godot-engine-workflow]]
- [[mobile-game-design-principles]] · [[mobile-game-performance]] ·
  [[mobile-game-monetization]] · [[mobile-game-publishing]]
- [[frame-pacing]] · [[game-performance-profiling]] · [[texture-atlasing]] ·
  [[level-of-detail]] · [[pool-warmup-and-budgeting]]
