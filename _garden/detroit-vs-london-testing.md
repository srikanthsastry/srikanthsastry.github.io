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
  Two schools define "unit test" differently, and the difference drives fundamentally different testing strategies:
---

Two schools define "unit test" differently, and the difference drives fundamentally different testing strategies:

**Detroit (Classical) school:** A unit is a *unit of behavior* — one or more classes collaborating to produce an observable result. Tests use real collaborators wherever practical; only external dependencies (databases, APIs) get test doubles. Tests are coupled to behavior, not structure.

**London (Mockist) school:** A unit is a *single class*. All collaborators are replaced with mocks. Tests verify interactions between the class and its collaborators. Tests are coupled to the class's internal communication patterns.

The Detroit approach produces more resilient tests that survive refactoring, because they test outcomes rather than interactions. The London approach provides faster fault localization (a failing test points to exactly one class) but creates brittle tests that break when you reorganize code without changing behavior.

The trade-off is between refactoring resilience (Detroit) and fault localization precision (London). For most codebases, refactoring resilience is more valuable — you refactor far more often than you need pinpoint fault localization.
