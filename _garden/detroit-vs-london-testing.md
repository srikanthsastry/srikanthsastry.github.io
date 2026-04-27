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
  - detroit-school-testing
  - london-school-testing
  - mocks-vs-stubs
  - test-behavior-not-implementation
excerpt_text: >
  The Detroit and London schools define "unit test" differently, driving fundamentally different testing strategies.
---

**The [Detroit](/garden/detroit-school-testing/) and [London](/garden/london-school-testing/) schools define "unit test" differently, driving fundamentally different strategies.** Detroit treats a unit as a *unit of behavior*: one or more classes collaborating, using real collaborators wherever practical. London treats a unit as a *single class*, replacing all collaborators with [mocks](/garden/mocks-in-testing/) and verifying interaction patterns.

Detroit produces more resilient tests that survive refactoring because they test outcomes. London provides faster fault localization but creates brittle tests that break when you reorganize code without changing behavior. For most codebases, refactoring resilience wins. You refactor far more often than you need pinpoint localization.
