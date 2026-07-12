---
title: Churn and Winback
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources: ["[[unity-retention-and-churn-metrics]]"]
tags: [game-development, design, analytics, retention, live-ops]
---

# Churn and Winback

Churn is the loss of active players over a defined window; winback is the attempt to re-engage players
who stopped. The useful unit is a cohort and a time horizon, not a single global percentage.

## Why it works

Retention cohorts reveal when players leave and which earlier behaviors predict return. Winback can then
address a diagnosed cause—unfinished onboarding, missing social connection, or stale content—rather
than sending identical incentives to everyone.

## The catch

Definitions vary, reinstallation can look like a new player, and a notification may raise sessions
without restoring healthy engagement. Discounts can train players to wait for offers or annoy players
who never wanted contact.

## In practice here

Define inactivity windows, segment by acquisition and lifecycle, identify the last meaningful action,
and test helpful content or reminders against holdouts with opt-out and frequency controls.
