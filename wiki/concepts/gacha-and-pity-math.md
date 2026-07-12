---
title: Gacha and pity math
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[gacha-pricing-pity-research]]"
  - "[[apple-app-review-guidelines-monetization]]"
tags: [game-development, game-design, economy, monetization, probability]
---

# Gacha and pity math

Gacha is a randomized reward system whose fairness depends on the full distribution, not only the
headline rate. A pity system changes that distribution by guaranteeing or increasing the chance of a
target after failed pulls. Hard pity creates a maximum cost; soft pity changes the probability mass
before the maximum. The design must expose what carries over, what resets, and whether a rarity
guarantee is also a featured-item guarantee.

## Why it works

For an independent pull with success probability `p`, the chance of at least one success in `n` pulls
is `1 - (1-p)^n`. A hard pity at `N` truncates the tail: no player can fail beyond pull N, but the
expected cost still depends on the base rate and any featured-item split. A 50/50 or failed rate-up
guarantee creates another state in the model, so expected pulls must be calculated over the pity state
machine rather than by dividing one by the displayed rate.

## The catch

Average pulls conceal variance and worst-case spend. Soft pity is easy to misunderstand if the per-pull
schedule is not shown, and a rarity guarantee can still deliver an off-banner item. Duplicate systems,
currency conversion, pity carry-over, and multiple banners further change the expected value. Randomized
paid items also have storefront disclosure obligations; a mathematically valid system can still be
misleading if its odds and guarantees are not presented in the purchase flow.

## In practice here

Publish the base rates, each pity threshold, state transition, carry-over rule, and featured-item
guarantee. Compute the probability mass function, expected pulls, median, high-percentile cost, and
duplicate outcomes before setting prices. Simulate the system independently from the production code,
test banner resets and reconnects, and show cumulative odds in plain language. Treat the pity counter
as part of [[economy-sinks-and-faucets]] and audit the result against current platform disclosure rules.
