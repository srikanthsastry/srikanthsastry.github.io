---
title: "Detroit vs. London Schools of Unit Testing"
garden_type: note
maturity: evergreen
tags: [software-testing, unit-tests, test-design, detroit-school, london-school]
created: 2026-04-27
related_posts:
  - /defining-unit-tests-two-schools-of-thought/
  - /in-unit-tests-i-favor-detroit-over-london/
related_notes:
  - mocks-vs-stubs
  - test-behavior-not-implementation
excerpt_text: >
  The Detroit and London schools define "unit test" differently, driving fundamentally different testing strategies.
---

**The Detroit and London schools define "unit test" differently, driving fundamentally different strategies.** Detroit treats a unit as a *unit of behavior*: one or more classes collaborating to produce an observable result, using real collaborators wherever practical and only stubbing external dependencies. London treats a unit as a *single class*, replacing all collaborators with [mocks](/garden/mocks-vs-stubs/) and verifying interaction patterns.

Detroit produces more resilient tests that survive refactoring because they test outcomes rather than interactions. London provides faster fault localization but creates brittle tests that break when you reorganize code without changing behavior. For most codebases, refactoring resilience wins. You refactor far more often than you need pinpoint localization.
