---
title: Monado / Envision on Linux — Troubleshooting Guide
type: concept
status: active
created: 2026-07-13
updated: 2026-07-13
verified: 2026-07-13
paths: []
sources: []
tags: [vr, linux, vrchat, monado, troubleshooting]
---

# Monado / Envision on Linux — Troubleshooting Guide

The FOSS Linux PC-VR stack, and how to debug it when it breaks. Compiled 2026-07-13 from
the Linux VR Adventures wiki (canonical community doc — note it **moved from
`lvra.gitlab.io` to `wiki.vronlinux.org`**, old links 308-redirect), Monado's official
docs, and the Envision/WiVRn/xrizer issue trackers. All claims are cited; anything not
confirmed against a primary source is marked `⚠️ unverified`.

## 1. What each piece is (get the mental model right first)

Most "VR is broken" reports on this stack are really "I'm debugging the wrong layer."
The stack, bottom to top:

| Layer | Component | Job |
|---|---|---|
| OpenXR runtime | **Monado** | Talks to the HMD, tracks, composites, presents. The thing that *is* VR. |
| Streaming runtime | **WiVRn** | A Monado-based fork that streams to standalone headsets (Quest, Pico) over Wi-Fi/USB. Replaces Monado when your headset is standalone. |
| Orchestrator | **Envision** | GTK GUI that *builds Monado from source* per "profile," sets the active runtime, and launches it. For **wired PC-VR headsets only** — since ~2025 it no longer builds WiVRn profiles; install WiVRn separately (Flatpak `io.github.wivrn.wivrn` or distro package). |
| OpenVR shim | **xrizer** (current) / OpenComposite (legacy) | Reimplements Valve's OpenVR API on top of OpenXR so SteamVR-era games (VRChat, Beat Saber…) run without SteamVR. OpenComposite is unmaintained since 2024; xrizer is the recommended layer. |
| Sandbox | Steam **pressure-vessel** | Proton games run inside a container that *cannot see* the runtime's socket or manifest unless you punch holes (see §6). |

Two config files decide who answers the phone:

- `~/.config/openxr/1/active_runtime.json` — which **OpenXR** runtime apps get.
  Envision writes it; WiVRn rewrites it while a headset is connected. `XR_RUNTIME_JSON=<path>`
  overrides it per-process. A stale one silently hands apps the wrong runtime.
- `~/.config/openvr/openvrpaths.vrpath` — which **OpenVR** implementation SteamVR-era
  games get (xrizer vs real SteamVR). Envision manages it; `VR_OVERRIDE=<path>` overrides.

## 2. The universal diagnosis order

Debug bottom-up. "Game launches flat" or "SteamVR opens instead" is almost never a
runtime bug — it's shim/Steam wiring (§6).

1. **Does the runtime itself see the headset?** Start Monado/WiVRn from Envision or a
   terminal, watch the log. `monado-cli probe` lists detected devices. HMD screens
   powering on but staying **black is normal** — nothing renders until an XR app connects.
2. **Does a bare OpenXR app render?** Run `hello_xr` or `xrgears` (package
   `libopenxr-utils` or the OpenXR-SDK). If this works, Monado is fine; stop blaming it.
   (⚠️ unverified: a standalone `openxr_runtime_list` tool — could not confirm it exists.)
3. **Does an OpenVR app find xrizer?** Only now debug `openvrpaths.vrpath` / `VR_OVERRIDE`.
4. **Does it survive pressure-vessel?** Only now debug Steam launch options (§6).

Debug env vars (verified names — Monado logging is per-subsystem, there is no single
`U_LOGGING` knob):

| Variable | Effect |
|---|---|
| `XRT_LOG=debug` / `trace` | General Monado verbosity; `trace` for IPC/connection issues |
| `XRT_COMPOSITOR_LOG=debug` | Compositor: GPU selection, display modes, direct-mode acquisition |
| `PROBER_LOG=debug` | USB device discovery / driver probing |
| `OXR_DEBUG_ENTRYPOINTS=1` | Trace every OpenXR call the app makes |
| `XRT_DEBUG_GUI=1` | Live debug GUI (device state, frame timing) |
| `RUST_LOG=trace` | (Envision itself) full build/launch logging — run Envision from a terminal |

## 3. Envision problems

**Where things live:** builds, prefixes and patches under `~/.local/share/envision/`
(Flatpak: `~/.var/app/org.gabmus.envision/`). Logs: run from a terminal.

- **Build fails with missing dependencies** — distro packaging drift. Install the dep list
  from the repo's `PKGBUILD` / `.gitlab-ci.yml`. Ubuntu specifically also needs the
  `xr-hardware` package or Monado builds fine but can't open devices (Envision issue #233).
- **Weird build breakage after changing CMake flags or patches** — stale incremental
  build. Use **"Clean build"** from the burger menu.
- **Dependency checker wrongly blocks launch** — `--skip-dependency-check`.
- **AppImage: `execv error: No such file or directory`** — AppImageLauncher mangling it.
  Run the AppImage directly or install from AUR (`envision-xr-git`).
- **Flatpak Envision can't see Steam / games** — sandbox. Grant paths with
  `flatpak override --filesystem=...` (Steam library, `xdg-config/openxr`,
  `xdg-config/openvr:ro`).
- **NOSUID warning under systemd-homed** — homed mounts home nosuid;
  `homectl update <user> --nosuid=false`.
- **It offers a WiVRn profile / old guides say to build WiVRn in Envision** — deprecated.
  Install WiVRn separately.

## 4. Monado runtime problems

**Drivers for Lighthouse headsets (Vive/Index):** two paths. `survive` (libsurvive, fully
FOSS, weaker tracking) and `steamvr_lh` (loads SteamVR's own driver blobs — current best
practice for tracking quality; enable with `STEAMVR_LH_ENABLE=true`, run SteamVR Room Setup
once first for floor height). Monado probes `survive → vive → OpenHMD` in order, so disable
earlier drivers to force a later one. Index gotcha: an HMD plugged in before boot can wedge
into a state where the DRM lease fails — replug its power.

**"Failed to connect to service" / IPC errors:** the compositor service and apps meet at
`$XDG_RUNTIME_DIR/monado_comp_ipc`. Causes, in order: service not running; crashed instance
left bad state (restart `monado-service`; it clears stale sockets itself); or the app is
inside Steam's sandbox and the socket isn't mapped in (§6).

**Permissions:** install the `xr-hardware` udev rules
(gitlab.freedesktop.org/monado/utilities/xr-hardware) so HMD USB/hidraw nodes are
user-accessible. Give the compositor scheduling priority:
`sudo setcap CAP_SYS_NICE=eip <monado-service binary>` — on AMD this is required for
reprojection to be scheduled ahead of game work.

**Direct mode / "my HMD shows up as a desktop monitor":** Monado normally takes the HMD
panel exclusively via a **DRM lease**. If the display server won't lease it (output not
marked `non-desktop`, compositor lacks `wp_drm_lease_device_v1` — KWin and Sway have it;
XWayland needs ≥ 22.1), Monado falls back to a desktop window at the *desktop's* vsync.
A crashed previous session can also leave the lease held — restart XWayland or the whole
session. Force paths with `XRT_COMPOSITOR_FORCE_WAYLAND=1` /
`XRT_COMPOSITOR_FORCE_WAYLAND_DIRECT=1` / `XRT_COMPOSITOR_FORCE_RANDR=1`.

## 5. WiVRn problems (standalone headsets)

Server and client APK **must be the same version**. Discovery is Avahi/mDNS; pairing by PIN.

- **Headset never lists the PC:** `systemctl enable --now avahi-daemon`; open **5353/UDP**.
- **Sees PC, won't connect/stream:** open **9757 TCP + UDP**.
- **Wi-Fi hopeless → wired:** `adb reverse tcp:9757 tcp:9757` then
  `adb shell am start -a android.intent.action.VIEW -d "wivrn+tcp://localhost" org.meumeu.wivrn`.
- **No audio in headset:** WiVRn creates a virtual PipeWire sink/source on connect but does
  **not** make them default — switch manually (pavucontrol etc.).

**Encoders** (config `~/.config/wivrn/config.json`): auto-selection is nvenc → vaapi → x264.
On AMD you want `vaapi`; verify `vainfo` shows *encode* entrypoints (missing
`mesa-va-drivers`/libva, or a distro shipping codec-stripped Mesa — Fedora — is the usual
"no encoder found" cause). Known issues: `vulkan` encoder is experimental and has shipped
broken (no video, issue #213); vaapi ignores runtime bitrate changes (#690); old Polaris
GPUs have broken HEVC vaapi (#183 — use h264 or x264). Multi-GPU: pin `device` to the right
`/dev/dri/renderD*`. Useful keys: `encoder`, `codec` (h264/h265/av1), `bitrate`, `tcp-only`,
`application` (auto-launch on connect), `use-steamvr-lh`, `debug-gui`.

## 6. Steam / Proton / game wiring

Proton games run inside pressure-vessel, which hides the runtime. Three things must
survive the sandbox: the runtime manifest, the shim, and the IPC socket.

Per-game launch options, Monado + xrizer:

```
XR_RUNTIME_JSON=/usr/share/openxr/1/openxr_monado.json VR_OVERRIDE=/path/to/xrizer PRESSURE_VESSEL_FILESYSTEMS_RW=$XDG_RUNTIME_DIR/monado_comp_ipc %command%
```

WiVRn: the socket is `$XDG_RUNTIME_DIR/wivrn/comp_ipc` instead, and **WiVRn's dashboard
shows you the exact launch-option string to copy** — use that rather than hand-building it.
Flatpak Steam users can apply it globally:

```
flatpak override --user --env=PRESSURE_VESSEL_IMPORT_OPENXR_1_RUNTIMES=1 --env=PRESSURE_VESSEL_FILESYSTEMS_RW=/var/lib/flatpak/app/io.github.wivrn.wivrn com.valvesoftware.Steam
```

Proton **9+** is required for Windows VR games on WiVRn.

- **"Game launches flat on the monitor" / "SteamVR starts instead":** the OpenVR side is
  mis-wired — `openvrpaths.vrpath` still points at SteamVR, or `VR_OVERRIDE` didn't survive
  into the container. This is §6 wiring, not a Monado bug.
- **VRChat:** works well on WiVRn + xrizer (EAC is fine under Proton). EAC failure prompt →
  just retry; EAC from an HDD can fail on I/O speed. Use Proton-GE-RTSP for in-world video
  players.
- **Half-Life: Alyx:** counterintuitively, skip the native Linux build (crashes/slow);
  the **Proton build with D3D renderer** works well on Monado + xrizer.
- **xrizer extras:** `XRIZER_TRACKER_SERIALS` (use controllers as trackers),
  `XRIZER_CUSTOM_BINDINGS_DIR` or an `xrizer/` dir next to the game exe for binding JSON.

## 7. Frame rate capped at exactly half the refresh rate

The most-reported "mystery" symptom. Six documented causes, ranked. Work top to bottom.

**First, understand the design fact that explains most cases:** Monado has **no
asynchronous reprojection / motion smoothing** (no SteamVR-style "Force 45 FPS + interpolation",
no Oculus ASW). When an app misses vsync it must wait for the next one, so a game that
can't quite hold 90 fps settles into a rock-stable 45 — it *looks* like a deliberate cap
because there is no smoothing layer hiding the miss. The stable half-rate is the pacing
math, not a configured limit.

1. **GPU stuck in a low power state (AMD, most common).** AMD's driver downclocks between
   VR frames; clocks never ramp, every frame misses, pacing locks to half.
   *Confirm:* watch `cat /sys/class/drm/card*/device/pp_dpm_sclk` (or LACT/CoreCtrl)
   during a session — high reported load but near-idle clocks.
   *Fix:* `echo manual | sudo tee /sys/class/drm/card*/device/power_dpm_force_performance_level`
   and select the **VR power profile** in LACT/CoreCtrl (or `high` as a blunt instrument).
2. **Not actually in direct mode.** HMD being composited as a desktop window at the
   desktop's (often 60 Hz) vsync. *Confirm:* Monado startup log shows whether the DRM
   lease was acquired; the HMD appearing as a usable desktop monitor is the giveaway.
   *Fix:* §4 direct-mode section.
3. **Compositor on the wrong GPU queue.** The reprojection shader on the GRAPHICS queue
   gets stuck behind game work; anything below max refresh then misses every other vblank.
   *Fix:* `XRT_COMPOSITOR_COMPUTE=1`, and on AMD make sure `CAP_SYS_NICE` is set on
   monado-service (§4).
4. **Frame-pacing budget too tight at high GPU load.** Monado reserves a fixed timewarp
   slice; if real overhead exceeds it at ~100% GPU, frames land late every other vblank.
   *Fix:* raise `U_PACING_COMP_MIN_TIME_MS` (default 4) to 8+;
   `U_PACING_COMP_TIME_FRACTION_PERCENT=90` also documented. On NVIDIA add
   `XRT_COMPOSITOR_USE_PRESENT_WAIT=1`.
   (⚠️ unverified: `U_PACING_APP_USE_MIN_FRAME_PERIOD` — name not found in docs/source.)
5. **WiVRn reconnect negotiates the wrong rate.** Known bug pattern (issue #273: Pico 4
   fine at 90 Hz on first connect, stuck at 72 after reconnect). *Fix:* fully restart the
   WiVRn server instead of reconnecting; keep the server current.
6. **The game genuinely can't hit rate.** With clocks healthy, direct mode confirmed, and
   pacing tuned, a stable half-rate means the app's frame time is simply > 1/refresh.
   There is no reprojection crutch: lower render resolution/settings until it holds
   native rate. (Switching to SteamVR Linux doesn't help — its async reprojection is
   reported broken there too.)

Decision tree: direct mode confirmed? → clocks ramping? → `XRT_COMPOSITOR_COMPUTE=1` +
CAP_SYS_NICE? → pacing vars? → (WiVRn) fresh server start? → it's real perf; cut settings.

## 8. AMD-specific notes

- **RADV (Mesa) is the only path.** AMDVLK is discontinued by AMD and could never lease
  displays (no direct mode). Do not install AMDVLK for VR.
- Reprojection on AMD needs `CAP_SYS_NICE` on monado-service (§4).
- ⚠️ unverified: some users report enabling `enableLinuxVulkanAsync` in Monado config for
  async behavior — not confirmed against Monado source.
- WiVRn encoding on AMD = vaapi through Mesa; see §5 for the codec-stripped-Mesa trap.

## Sources

- Linux VR Adventures wiki (canonical): https://wiki.vronlinux.org/ — pages: monado,
  envision, wivrn, xrizer, opencomposite, vrchat, performance, hardware, steamvr/quick-start
- Monado docs: https://monado.freedesktop.org/getting-started.html, /direct-mode.html,
  /multi-gpu.html; frame pacing: https://monado.pages.freedesktop.org/monado/frame-pacing.html
- Envision: https://gitlab.com/gabmus/envision (issues #233, #50)
- WiVRn: https://github.com/WiVRn/WiVRn (docs/configuration.md, docs/steamvr.md;
  issues #183, #213, #273, #690, #872)
- xrizer: https://github.com/Supreeeme/xrizer
- Steam runtime sandbox: https://github.com/ValveSoftware/steam-runtime/issues/575
- SteamVR Linux async reprojection state: https://github.com/ValveSoftware/SteamVR-for-Linux/issues/633
- AMDVLK discontinued: https://videocardz.com/newz/amd-ends-amdvlk-driver-focuses-on-radv-for-linux-vulkan-support
