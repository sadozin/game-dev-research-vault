---
title: 'Source: OWASP bot management and anti-automation'
type: source
status: active
created: 2026-07-14
updated: 2026-07-14
verified: 2026-07-14
sources:
  - raw/owasp-bot-management.md
tags: [source, security, abuse, bots, game]
---

# Source: OWASP bot management and anti-automation

- **Author:** OWASP Cheat Sheet Series
- **URL:** https://cheatsheetseries.owasp.org/cheatsheets/Bot_Management_and_Anti-Automation_Cheat_Sheet.html
- **Raw:** raw/owasp-bot-management.md (provenance only)

## Summary

OWASP treats automation as a family of abuses rather than a single denial-of-service problem:
credential stuffing, fake-account creation, scraping, inventory hoarding, cash-out, and analytics
pollution need different signals and layered controls. Rate limits should model both the protected
resource and the source; one combined IP-and-user bucket can leave a distributed attack path open.

In an online game, the corresponding protected resources include accounts, chat, market searches,
trades, limited offers, matchmaking, character creation, and reward claims. The goal is to raise the
cost of abusive automation without assuming every automated client is identical or that one CAPTCHA
solves the threat model.

## Compiled into

- [[mmo-live-service-operations]]
- [[mmo-common-pitfalls]]
- [[mmo-production-scope]]
