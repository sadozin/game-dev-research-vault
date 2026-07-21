---
title: iOS development
type: concept
status: active
created: 2026-07-20
updated: 2026-07-20
verified: 2026-07-20
sources: []
tags: [game-development, mobile, platform]
---

# iOS development

Shipping software to iPhone/iPad. The defining constraint is that **Apple's build and signing
toolchain (Xcode, `xcodebuild`, `codesign`, provisioning profiles) runs only on macOS.** There
is no official Windows or Linux path to produce a signed `.ipa` or submit to the App Store.
Every viable workflow from a Windows machine routes through a Mac at the final step — owned,
rented, or in CI.

## The Mac requirement

Apple ties code signing to macOS Keychain and provisioning profiles to Xcode. Even
cross-platform engines that develop fully on Windows ([[godot-engine-workflow]],
[[unity-engine-workflow]], [[unreal-engine-workflow]]) must hand off to Xcode for the iOS
export, build, and archive steps. The simulator also requires macOS; on Apple Silicon Macs
iOS apps run natively with fewer simulator limits.

The one partial exception is **Swift Playgrounds on iPad**, which can build and submit simple
SwiftUI apps without a Mac — but it is far too limited for game or non-trivial app work.

## Cross-platform game engines

All three major engines develop on Windows and export an Xcode project for iOS:

**Godot 4** exports an iOS preset that produces an `.xcodeproj`. The simulator supports only
the Compatibility renderer. C# iOS support exists from 4.2 but is experimental — prefer
GDScript for reliability. See [[godot-mobile-export]] for the full checklist including the
faster "link project folder" iteration trick and the `xcode-select` SDK path fix.

**Unity** has the most mature iOS pipeline. iOS builds require IL2CPP (Mono is not permitted
by Apple). Export produces an Xcode project; Unity Cloud Build or a local Mac handles the rest.

**Unreal Engine 5** targets Metal on iOS. Minimum device requirements are heavier than the
other two engines. Export produces an Xcode project as well.

The shared workflow: develop and test on Windows/Android first, export the Xcode project,
build and sign on a Mac or cloud Mac, submit via Xcode Organizer or `xcrun altool`.

## Cloud Mac services

For developers without Mac hardware, renting macOS time is the practical path:

**GitHub Actions** is the best free option for CI/CD. macOS runners are included in the free
tier (2,000 minutes/month for public repos, less for private). A workflow can run Godot or
Unity headless export, `xcodebuild`, and produce an `.ipa` artifact on every push.

**MacinCloud** provides RDP access to a macOS VM for around $25/month — useful when you need
interactive Xcode debugging rather than just CI builds.

**AWS EC2 Mac instances** are dedicated Mac minis billed per-second with a 24-hour minimum
(~$25/day). Overkill for occasional builds but appropriate for sustained CI pipelines.

**Codemagic** and **MacStadium** are other options; Codemagic has a free tier targeting
mobile CI specifically.

## Web-based alternatives (no Mac at all)

If App Store distribution is not required, iOS Safari supports **Progressive Web Apps** with
offline capability, home-screen installation, and fullscreen mode. A Godot web export
([[godot-web-export]]) wrapped in a service worker is playable as an iOS PWA. The tradeoffs
are no push notifications (until iOS 16.4+), stricter memory limits in Safari, and no App
Store discoverability.

**Capacitor** (Ionic) wraps a web app in a native shell and can access native APIs. It still
needs a Mac for App Store submission, but the development loop is entirely Windows.

**React Native** and **Flutter** both develop on Windows with hot reload, but the iOS build
step still requires macOS.

## Sideloading without a Mac

**AltStore** and **SideStore** allow sideloading `.ipa` files to a physical iPhone from
Windows. They use a free Apple Developer account and re-sign every 7 days. This is the
cheapest way to test a game on a real iPhone without any Mac access.

**TrollStore** (iOS 14.0–16.6.1, specific builds) allows permanent sideloading with no
re-signing expiry. Availability depends entirely on the device's iOS version.

Neither path distributes through the App Store. They are testing and personal-use tools.

## iOS platform constraints

**No JIT compilation.** Apps cannot generate executable code at runtime. This affects VMs,
some scripting engines, and any engine path that relies on runtime code generation. Godot's
GDScript and C# AOT (via IL2CPP or Mono AOT) work within this constraint.

**Metal only.** Modern iOS supports only Apple's Metal graphics API. OpenGL ES is deprecated.
Godot's Forward+ renderer maps to Metal on iOS; the Compatibility renderer uses a GLES3-like
path. Vulkan does not exist on iOS.

**Memory limits.** iOS kills apps that exceed per-device memory budgets (roughly 1.5–2 GB
usable on recent hardware). There is no swap. Texture budgets and asset streaming
([[mipmapping-and-texture-streaming]], [[texture-atlasing]]) matter more than on desktop.

**Background execution.** Severely restricted. Games get a few seconds of background time
before suspension. No persistent background processes.

**App Store review.** Typical turnaround is 24–48 hours. Loot boxes require odds disclosure.
Privacy nutrition labels are mandatory. App Tracking Transparency (ATT) is required for any
user tracking.

**Minimum deployment target.** The App Store requires building with the latest SDK (currently
Xcode 16 / iOS 18 SDK). Most apps set a minimum deployment target of iOS 15–16 to reach a
broad audience.

## Cost of entry

Developing and testing on Android costs nothing. Physical iPhone testing via AltStore costs
nothing. App Store distribution requires the **Apple Developer Program** at $99/year plus Mac
access (owned hardware, cloud rental, or free CI runners).

## Recommended workflow from Windows

1. Develop and iterate on Windows as normal.
2. Test on Android first for immediate device feedback.
3. Use GitHub Actions macOS runners for automated iOS builds on every push.
4. Use AltStore/SideStore for quick physical iPhone testing without a Mac.
5. Rent a cloud Mac (MacinCloud or similar) only when interactive Xcode debugging or
   App Store submission is needed.

This keeps the day-to-day loop entirely on Windows and reserves Mac time for the steps that
genuinely require it.

## Related

- [[godot-mobile-export]] · [[godot-web-export]] · [[godot-export-and-release]]
- [[unity-engine-workflow]] · [[unreal-engine-workflow]] · [[game-engine-selection]]
- [[mipmapping-and-texture-streaming]] · [[texture-atlasing]] · [[game-performance-profiling]]
