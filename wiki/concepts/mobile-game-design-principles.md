---
title: Mobile game design principles
type: concept
status: active
created: 2026-07-20
updated: 2026-07-20
verified: 2026-07-20
sources: []
tags: [game-design, mobile, ux, touch-input, game-development]
---

# Mobile game design principles

Designing for mobile means designing for thumbs, interruptions, and small screens. The
phone is not a shrunken monitor — it is a different interaction surface with its own
ergonomics, attention patterns, and failure modes. Games that treat mobile as "desktop
minus resolution" fail on feel, retention, and readability.

## Touch input design

### The thumb zone

Players hold phones one-handed (portrait) or two-handed (landscape). In portrait, the
thumb reaches a fan from the bottom corners — the top-center of the screen is the hardest
zone. In landscape, thumbs cover the left and right thirds; the center-top is dead space.
Place primary actions (attack, jump, confirm) in the thumb zone. Place infrequent actions
(settings, pause) in the hard-to-reach areas.

### Touch target sizing

Apple's Human Interface Guidelines specify 44×44 points minimum; Android's Material Design
specifies 48×48 dp. In practice, fast-action games need 60–80 dp targets with generous
spacing. A button that works on a 6.7-inch phone may be unusable on a 5.4-inch one. Test
on the smallest target screen.

### No hover, no right-click

Touch has no hover state — every interaction is press → release. Design feedback around
press-down (scale, color shift, haptic) and release (action fires). There is no tooltip
on long-press by convention; long-press is a secondary action at best. Right-click does
not exist. Any desktop interaction that depends on hover, right-click, or scroll-wheel
needs a touch-native replacement.

### Gesture vocabulary

Standard gestures: tap (select/confirm), swipe/drag (move/camera), pinch (zoom),
two-finger drag (pan), long-press (context menu or secondary action). Players expect
these to behave consistently across apps. Custom gestures (three-finger swipe, double-tap-
and-hold) are discoverable only with explicit tutorials and should be reserved for
advanced actions.

### Virtual controls

Virtual joysticks and buttons work but are imprecise — the player's thumb occludes the
control and there is no tactile feedback. Mitigations: make the joystick follow the
thumb (floating joystick), enlarge the hit area beyond the visible art, add haptic
feedback on press, and prefer auto-aim or simplified input schemes over twin-stick
precision. Many successful mobile action games (Brawl Stars, Genshin Impact) use
floating joysticks with large invisible hit zones.

## Session design

### The 2-minute rule

A mobile player may have 2 minutes (bus stop, queue, elevator). The game must deliver
a satisfying unit of play in that window: one match, one puzzle, one collection cycle.
If the minimum meaningful session is 15 minutes, the game fights the platform.

### Interruption handling

Phone calls, notifications, low-battery warnings, and app-switching will interrupt play.
The game must pause gracefully (or auto-save) on `applicationWillResignActive` /
`onPause` and resume without losing progress. A game that crashes or loses state on
interruption gets uninstalled.

### Session hooks

Retention on mobile is driven by short-loop hooks: daily login rewards, energy/timer
systems, collection completion, leaderboard resets, and limited-time events. The hook
must give the player a reason to open the app tomorrow, not just to keep playing now.
This is the core of [[mobile-game-monetization]] LiveOps.

### Progress pacing

Mobile players expect visible progress every session — a new item, a level completed,
a stat increased. Stagnation (no visible progress for 2+ sessions) is the primary
churn driver. Design progression curves with frequent small rewards and occasional
large milestones, not long flat grinds.

## UI and readability

### Screen real estate

A 6.1-inch phone at 1170×2532 pixels sounds like a lot, but the usable area after
notch/dynamic-island, rounded corners, and system gesture zones is smaller. HUD elements
must be large enough to read at arm's length (30–40 cm) and sparse enough not to occlude
gameplay. Maximum 4–6 persistent HUD elements; everything else goes in menus.

### Safe areas

iOS notch/Dynamic Island and Android punch-hole cameras eat into the top of the screen.
Android gesture navigation eats the bottom. Use the engine's safe-area insets
(`View.safeAreaInsets` on iOS, `WindowInsets` on Android; Godot exposes
`DisplayServer.get_display_safe_area()`) and keep critical UI inside the safe rect.

### Font sizes

Minimum 12 sp (Android) / 11 pt (iOS) for body text, 14+ for interactive labels.
Anything smaller is unreadable without squinting. Test with the device at natural
holding distance, not on a monitor at 60 cm.

### Orientation

Portrait is one-handed, casual, and compatible with public-transport play. Landscape
is two-handed, immersive, and better for action/strategy. The choice is a design
decision, not a technical one — pick one and commit. Supporting both doubles UI layout
work and testing.

## Accessibility on mobile

- **Colorblind modes** — 8% of males; do not encode critical info in color alone.
- **Text scaling** — respect system font-size settings where feasible.
- **One-handed mode** — offer a control layout that works with one thumb.
- **Haptics as feedback** — use vibration for confirmations, not just explosions.
- **Reduce motion** — some players disable parallax/camera shake; offer a toggle.

## Genre fit for mobile

Some genres translate naturally; others fight the platform:

| Genre | Mobile fit | Why |
|---|---|---|
| Puzzle / match-3 | Excellent | Short sessions, one-hand, simple input |
| Idle / clicker | Excellent | Designed around absence, notification hooks |
| Card / strategy | Excellent | Turn-based, no precision input needed |
| Endless runner | Excellent | One-input, instant restart, short loops |
| Tower defense | Good | Touch placement, paused-time planning ([[tower-defense-core-loop-and-player-decisions]]) |
| RPG / gacha | Good | Progress-driven, auto-battle options |
| MOBA / battle royale | Moderate | Adapted with auto-aim, simplified controls |
| FPS / twin-stick | Hard | Precision aiming on glass is fundamentally limited |
| RTS | Hard | Multi-unit selection and micro on a small screen |
| Fighting | Hard | Complex input sequences on virtual buttons |

"Hard" does not mean impossible — PUBG Mobile and Call of Duty Mobile prove it — but
the input scheme must be redesigned from scratch, not ported.

## Related

- [[mobile-game-development]] · [[mobile-game-performance]] ·
  [[mobile-game-monetization]] · [[mobile-game-publishing]]
- [[godot-input-handling]] · [[godot-ui-controls]]
- [[tower-defense-readability-and-onboarding]] · [[clicker-game-economy]] ·
  [[idle-game-prestige]]
