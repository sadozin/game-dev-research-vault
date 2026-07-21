---
title: Mobile game monetization
type: concept
status: active
created: 2026-07-20
updated: 2026-07-20
verified: 2026-07-20
sources: []
tags: [game-design, mobile, monetization, business, liveops, game-development]
---

# Mobile game monetization

The monetization model is not a post-launch addition — it shapes the core loop, progression
curve, UI layout, and retention systems from day one. Choosing the model before designing
the loop prevents the most common mobile failure: a fun prototype that has no sustainable
revenue structure and cannot be retrofitted with one.

## The models

### Premium (paid upfront)

Player pays once ($0.99–$9.99 typical, up to $19.99 for premium ports). No further
monetization. Works for: ports of successful PC/console games (Stardew Valley, Dead Cells,
Slay the Spire), puzzle/narrative games with a defined endpoint (Monument Valley,
The Room), and niche strategy games with a dedicated audience.

**Strengths:** clean design, no retention engineering needed, positive player sentiment,
press/award friendly.
**Weaknesses:** tiny addressable market on mobile (most players will not pay upfront for
an unknown game), no recurring revenue, discovery is hard without marketing budget.

### Free-to-play (F2P) with in-app purchases (IAP)

The dominant mobile model. The game is free; revenue comes from selling virtual goods,
currency, progression accelerators, cosmetics, or content. The design must create
*desire* to spend without making non-payers feel punished.

**Currency layers:** most F2P games use 2–3 currencies (soft currency earned by playing,
hard currency bought with money, sometimes a third for specific systems). This obscures
real-money cost and lets designers tune earn rates independently of price points.

**Common IAP types:**
- **Consumables** — gems, coins, energy, lives. Spent and re-purchased. The revenue
  workhorse.
- **Cosmetics** — skins, emotes, visual effects. No gameplay advantage. The primary
  model in competitive games (Fortnite, Brawl Stars) because it does not create
  pay-to-win perception.
- **Battle pass / season pass** — a tiered reward track ($5–$15 per season, ~6–10 weeks).
  Free track + paid track. Drives engagement (play to unlock tiers) and recurring revenue.
  Now standard in most live-service mobile games.
- **Starter packs / bundles** — discounted one-time offers for new or returning players.
  High conversion because the value proposition is clear.
- **Gacha / loot boxes** — randomized rewards for currency. Extremely high revenue but
  legally restricted in some regions (Belgium bans, China requires probability disclosure,
  Japan restricts "complete gacha"). Ethically contentious.
- **Subscriptions** — monthly VIP ($5–$15/month) with daily rewards, exclusive content,
  or convenience features. Growing model; Apple and Google both support subscription APIs.

### Advertising

Revenue from showing ads. Works for hyper-casual and casual games where IAP conversion
is low (<1%) but daily active users are high.

**Ad formats:**
- **Rewarded video** (15–30 s) — player *chooses* to watch for a reward (extra life,
  currency, speed-up). Highest eCPM ($10–$30), best player sentiment because it is
  opt-in. The workhorse of ad monetization.
- **Interstitial** (full-screen, 5–15 s) — shown at natural break points (level complete,
  game over). Moderate eCPM ($5–$15). Annoying if too frequent; 60–90 s minimum between
  interstitials is the convention.
- **Banner** (persistent strip) — low eCPM ($0.50–$2), always visible. Declining in use
  because it eats screen space and revenue is low.
- **Playable ads** (interactive mini-demo) — used for cross-promotion. High engagement
  but expensive to produce.

**Ad mediation:** most games use a mediation platform (Google AdMob Mediation, MAX by
AppLovin, Unity LevelPlay, ironSource) that auctions ad slots across multiple networks
to maximize eCPM.

### Hybrid (IAP + ads)

The most common model for casual and mid-core games. IAP for whales and dolphins
(players who spend $10+/month), rewarded ads for everyone else. The design must ensure
that ad rewards do not cannibalize IAP — typically, ad rewards give small amounts of
soft currency or one-time bonuses, while IAP sells hard currency, cosmetics, and
progression.

## Key metrics

| Metric | What it measures | Typical range |
|---|---|---|
| **D1 / D7 / D30 retention** | % of players returning after 1/7/30 days | D1: 30–50%, D7: 10–20%, D30: 3–8% |
| **ARPDAU** | Average revenue per daily active user | $0.05 (hyper-casual) – $1.50+ (mid-core) |
| **LTV** | Lifetime value per player | Must exceed CPI for profitability |
| **CPI** | Cost per install (marketing) | $0.50 (hyper-casual) – $5+ (mid-core) |
| **Conversion rate** | % of players who spend money | 1–5% (casual), 5–15% (mid-core) |
| **ARPPU** | Average revenue per paying user | $10–$100+ depending on genre |
| **Session length / frequency** | Engagement depth | 3–8 sessions/day, 3–10 min each |

The fundamental equation: **LTV > CPI**. If it costs $2 to acquire a player and they
generate $1.50 over their lifetime, the game loses money on every install.

## LiveOps

LiveOps (live operations) is the practice of running the game as a service after launch:
regular content updates, events, offers, and tuning to sustain engagement and revenue.

### Event cadence

- **Daily:** login rewards, daily quests, energy refills.
- **Weekly:** weekly challenges, leaderboard resets, limited offers.
- **Bi-weekly / monthly:** battle pass / season rotation, new content drops.
- **Quarterly:** major content updates, new characters/levels/modes.

### A/B testing

Live games continuously A/B test: offer prices, reward amounts, difficulty curves, UI
layouts, ad frequency. Firebase Remote Config, GameAnalytics, or custom config servers
deliver different variants to player cohorts. The data decides, not the designer's
intuition.

### Segmentation

Players are not one population. Common segments:
- **Non-payers** (90–95%) — monetize with ads, retain with content.
- **Minnows** ($1–$10/month) — starter packs, battle pass.
- **Dolphins** ($10–$100/month) — bundles, subscriptions, cosmetics.
- **Whales** ($100+/month) — exclusive offers, gacha, VIP tiers.

Design the loop so non-payers have fun (they are the content for paying players in
multiplayer, and the audience for ads in single-player). Punishing non-payers destroys
the ecosystem that whales depend on.

## Platform cuts and rules

- **Apple App Store:** 30% commission (15% for small businesses under $1M/year via
  App Store Small Business Program). All digital purchases must use StoreKit (no
  external payment links for digital goods, per current rules — this is evolving
  legally in the EU with the DMA).
- **Google Play:** 30% commission (15% for the first $1M/year via Play Media Experience
  and subscriptions after year one). Must use Google Play Billing for digital goods.
- **Both:** subscription pricing, refund policies, and family sharing rules apply.
  Physical goods and services (e.g., food delivery) use external payment.

## Ethical considerations

The mobile monetization space has a reputation problem, and some of it is earned. Practices
that harm players and attract regulatory scrutiny:

- **Dark patterns** — confusing currency conversions, hidden costs, manipulative countdown
  timers, "confirm purchase" buttons styled like "play" buttons.
- **Loot boxes targeting minors** — randomized paid rewards in games with child audiences.
  Increasingly regulated (Belgium, Netherlands, China, UK under review).
- **Energy/timer walls** — making the game unplayable without paying or waiting hours.
  Short-term revenue, long-term churn.
- **Fake urgency** — "offer expires in 5:00" that resets every session.

Sustainable monetization aligns player enjoyment with revenue: cosmetics, convenience,
content, and fair progression. The games with the best long-term retention and revenue
(Genshin Impact, Brawl Stars, Pokémon GO) spend money on *more game*, not on removing
pain.

## Related

- [[mobile-game-development]] · [[mobile-game-design-principles]] ·
  [[mobile-game-publishing]]
- [[clicker-game-economy]] · [[idle-game-prestige]]
- [[tower-defense-economy-and-wave-design]]
