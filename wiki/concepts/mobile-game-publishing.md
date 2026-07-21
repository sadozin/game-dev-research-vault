---
title: Mobile game publishing
type: concept
status: active
created: 2026-07-20
updated: 2026-07-20
verified: 2026-07-20
sources: []
tags: [game-development, mobile, publishing, app-store, google-play, business]
---

# Mobile game publishing

Getting a game onto the App Store and Google Play is a bureaucratic, technical, and
marketing process that starts weeks before the build is ready. Store rejection, signing
errors, and poor store-page presentation are the most common reasons a finished game
never reaches players. Publishing is not the last step — it is a parallel workstream
that begins during development.

## Developer accounts

### Apple App Store

- **Apple Developer Program:** $99/year. Required to distribute on the App Store.
  Individual or organization enrollment. Organization enrollment requires a D-U-N-S
  number (free from Dun & Bradstreet, takes 1–2 weeks).
- **App Store Connect:** the web portal for app metadata, screenshots, pricing,
  TestFlight distribution, and analytics.
- **Certificates and profiles:** iOS code signing requires a Distribution Certificate
  and an App Store Provisioning Profile, created in the Apple Developer portal. Xcode
  can manage these automatically ("Automatically manage signing") or manually.
- **TestFlight:** Apple's beta distribution platform. Up to 100 internal testers
  (no review) and 10,000 external testers (light review, ~24 h). Essential for
  pre-launch testing on real devices.

### Google Play

- **Google Play Developer account:** $25 one-time fee. Required to publish on Google Play.
- **Google Play Console:** the web portal for app metadata, APK/AAB uploads, pricing,
  staged rollouts, and analytics.
- **Signing:** Google Play App Signing (recommended) — Google holds the upload key and
  re-signs the app. You keep the app signing key. If you lose the app signing key with
  legacy self-signing, you can never update the app.
- **Internal / closed / open testing tracks:** distribute builds to testers before
  production release. Internal testing (up to 100 testers) requires no review.
- **Data safety form:** mandatory declaration of data collection, sharing, and security
  practices. Must be accurate — Google audits and can remove apps for misrepresentation.

## Build and signing

### Android

- Build format: **AAB** (Android App Bundle) is required for new apps on Google Play.
  AAB lets Google generate optimized APKs per device (split APKs by ABI, density,
  language), reducing download size.
- Signing: create a keystore (`keytool`), sign the AAB, upload to Play Console.
  See [[godot-mobile-export]] for the Godot-specific keystore workflow.
- Target API level: Google Play requires targeting a recent Android API level
  (currently API 34/35). Each year the requirement increases. Check the current
  deadline in Play Console.
- 64-bit requirement: all apps must include 64-bit native libraries (arm64-v8a).
  32-bit-only apps are rejected.

### iOS

- Build format: **IPA** uploaded via Xcode or Transporter to App Store Connect.
- Signing: Distribution Certificate + App Store Provisioning Profile. Xcode handles
  this with "Automatically manage signing" or manual profiles.
- Minimum deployment target: set to the oldest iOS version you support. Each Xcode
  version drops older SDKs; Apple requires building with a recent Xcode.
- Privacy manifest: as of 2024, apps must declare privacy practices in a
  `PrivacyInfo.xcprivacy` manifest, including required-reason APIs and third-party
  SDK data collection.
- App Tracking Transparency (ATT): if the app uses IDFA (advertising identifier) or
  tracks users across apps, it must show the ATT prompt. Most games that use ad
  networks need this.

## Store listing and ASO

### App Store Optimization (ASO)

ASO is the mobile equivalent of SEO — making the store listing discoverable and
convertible. The store page is the primary conversion funnel: most installs come
from store search and browsing, not external advertising.

**Key elements:**
- **App name / title** (30 chars on App Store, 50 on Google Play) — include the
  primary keyword. "Block Blast — Puzzle Game" beats "Block Blast".
- **Subtitle / short description** (30 chars / 80 chars) — secondary keywords and
  the value proposition.
- **Keywords field** (App Store only, 100 chars) — comma-separated, no spaces,
  no duplicates of words already in the title. Research with ASO tools
  (Sensor Tower, AppTweak, Mobile Action).
- **Icon** — the single most important visual. Must be readable at 60×60 px.
  Bold, simple, high-contrast. No text smaller than the app name. Test variants
  with A/B testing (Google Play offers native icon A/B tests; App Store has
  product page optimization).
- **Screenshots and preview video** — the first 3 screenshots are visible in
  search results. Show gameplay, not menus. Use device frames, captions with
  key features, and the most exciting moment first. Preview video (15–30 s)
  autoplays muted — design for sound-off.
- **Description** — App Store: 4,000 chars, not indexed for search. Google Play:
  4,000 chars, *indexed* for search (keywords matter here). First 2–3 lines are
  visible before "read more" — put the hook there.
- **Ratings and reviews** — the highest-weighted ranking factor after downloads.
  Prompt for reviews at positive moments (level complete, not after a loss).
  Use the native review dialog (`SKStoreReviewController` on iOS,
  `ReviewManager` on Android) — it only shows when the system deems appropriate.

### Localization

The App Store and Google Play support localized listings. Localizing the store page
(title, description, screenshots) into the top 5–10 languages by target market
(English, Chinese, Japanese, Korean, German, French, Spanish, Portuguese, Russian,
Arabic) can increase downloads 20–50% in those markets. Localize the game itself
separately — at minimum, UI strings and tutorial text.

## Review process

### Apple App Review

- Typical review time: 24–48 hours. First submission may take longer.
- Common rejections:
  - **Guideline 4.3 (spam):** apps that are too similar to existing ones.
  - **Guideline 3.1.1 (IAP):** digital purchases not using StoreKit.
  - **Guideline 5.1.1 (privacy):** missing privacy policy, incorrect data collection
    declarations, missing ATT prompt.
  - **Guideline 2.1 (bugs):** crashes, placeholder content, "coming soon" features.
  - **Guideline 4.0 (design):** minimum functionality, web-wrapper apps.
- Appeal process: respond in App Store Connect with a fix or explanation. The
  App Review Board handles escalations.

### Google Play Review

- Typical review time: hours to 7 days (new developer accounts take longer).
- Common rejections:
  - **Data safety violations:** inaccurate data collection declarations.
  - **Policy violations:** inappropriate content, misleading ads, IAP outside
    Google Play Billing.
  - **Target API level:** not targeting the required Android API level.
  - **Permissions:** requesting permissions without justification.
- Google Play is generally faster and less strict than Apple, but enforcement
  has tightened since 2023 (especially around AI-generated content, gambling,
  and children's privacy).

## Staged rollout and updates

### Staged rollout

Both stores support releasing to a percentage of users (e.g., 10% → 50% → 100%)
over days. This catches crashes and performance regressions before they hit the
full user base. Always use staged rollout for updates; monitor crash reports
(Firebase Crashlytics, Sentry, or engine-specific tools) during the rollout.

### Update cadence

- **Bug fixes:** as needed, staged rollout.
- **Content updates:** every 4–8 weeks for live games.
- **OS compatibility:** annual updates for new iOS/Android versions (new screen
  sizes, API changes, privacy requirements).
- **Store requirement updates:** annual target API level bumps (Google Play),
  SDK version requirements (Apple).

### Hot updates

Native code changes require a store update. Script/asset changes can sometimes be
delivered without a store review:
- Unity: Asset Bundles / Addressables for asset updates; Lua or hybrid CLR for
  script hot-reload (check store policies — Apple prohibits downloading executable
  code that changes app behavior).
- Godot: PCK file updates (the game data pack) can be downloaded and swapped, but
  the binary itself must go through the store.
- Unreal: Pak file chunking for asset patches.

**Apple's rule:** apps may not download or execute code that changes the app's
features. Asset and data updates are fine; script hot-reload is a gray area that
Apple has rejected in some cases.

## Marketing and user acquisition

### Organic

- ASO (above) is the primary organic channel.
- Social media (TikTok, YouTube Shorts, Instagram Reels) — short gameplay clips.
  The algorithm favors entertaining content regardless of follower count.
- Reddit (r/AndroidGaming, r/iOSProgramming, genre-specific subs), Discord communities.
- Press / review sites (TouchArcade, Pocket Gamer, AppAdvice) — declining in influence
  but still valuable for premium games.
- Featuring: Apple and Google both feature apps on their store front pages. Pitch
  through App Store Connect ("App of the Day" nomination) and Google Play's editorial
  team. More likely for polished, innovative, or locally relevant games.

### Paid

- **Apple Search Ads:** bid on keywords in App Store search. High intent, moderate CPI.
- **Google Ads (UAC):** Universal App Campaigns across Search, Play, YouTube, Display.
- **Social ads:** Meta (Facebook/Instagram), TikTok, Snapchat. Video creative is king.
- **Cross-promotion:** partner with other game devs to show each other's games.
- **Influencer marketing:** YouTube/TikTok creators playing the game. Effective for
  visually distinctive or multiplayer games.

### Soft launch

Release in a small market (Canada, Australia, Philippines, Poland) before global launch.
Collect retention, monetization, and crash data. Tune the game based on real player
behavior. Most successful F2P games soft-launch for 1–6 months before global release.

## Analytics and crash reporting

Essential from day one, not added post-launch:

- **Firebase Analytics** (free, Google ecosystem) or **GameAnalytics** (free,
  game-specific) — events, funnels, retention, revenue.
- **Firebase Crashlytics** or **Sentry** — crash reports with stack traces, device
  info, and reproduction steps.
- **Adjust / AppsFlyer / Singular** — attribution (which ad campaign drove each install).
  Required for paid UA to measure ROI.
- **Custom events:** instrument every meaningful action (level start/complete, purchase,
  ad view, tutorial step) from the first playable build.

## Related

- [[mobile-game-development]] · [[mobile-game-monetization]] ·
  [[mobile-game-design-principles]] · [[mobile-game-performance]]
- [[godot-mobile-export]] · [[godot-export-and-release]]
