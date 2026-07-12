---
title: Player authentication and accounts
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[backend-services-and-dedicated-servers]]"
tags: [game-development, backend, security]
---

# Player authentication and accounts

Player authentication establishes identity and session credentials; accounts connect that identity to
progress, entitlements, social data, and platform identities.

## Why it works

An account boundary lets services authorize actions and recover progress across devices while keeping
anonymous or guest onboarding possible.

## The catch

Account linking, token expiry, recovery, privacy, platform ownership, and shared-device behavior are
security and usability problems, not just login UI.

## In practice

Keep tokens short-lived, separate authentication from authorization, support explicit link/unlink flows,
and design account recovery before launch.

