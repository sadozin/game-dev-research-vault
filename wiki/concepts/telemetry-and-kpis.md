---
title: Telemetry and KPIs
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources: ["[[unity-analytics-dashboards]]"]
tags: [game-development, design, analytics, live-ops]
---

# Telemetry and KPIs

Game telemetry is the event and state data needed to understand player behavior; KPIs are the small set
of decisions those data support. Useful telemetry connects an action to a cohort, version, context, and
outcome instead of collecting every possible event without a question.

## Why it works

Funnels, retention cohorts, economy flows, and revenue dashboards turn raw events into comparable
signals. A stable event schema lets teams detect regressions, evaluate experiments, and relate product
changes to player outcomes.

## The catch

Metrics can be delayed, sampled, biased by instrumentation, or mistaken for causes. A rising session
length can reflect friction; a revenue lift can hide churn or refunds. Collecting sensitive data without
purpose also creates privacy and governance risk.

## In practice here

Define the decision and primary metric first, version event schemas, log exposure and cohort identity,
and pair growth metrics with guardrails such as crashes, churn, refunds, and support complaints.
