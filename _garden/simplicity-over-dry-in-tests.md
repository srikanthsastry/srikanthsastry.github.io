---
title: "Simplicity Over DRY in Tests"
garden_type: note
maturity: evergreen
tags: [software-testing, unit-tests, DRY, test-design]
created: 2026-04-27
related_posts:
  - /dry-unit-tests-are-bad/
related_notes:
  - coverage-metrics-are-misleading
  - tests-as-executable-documentation
excerpt_text: >
  DRY is a near-universal principle in production code, but applying it dogmatically to test code causes more problems than it solves.
---

DRY is a near-universal principle in production code, but applying it dogmatically to test code causes more problems than it solves. Test code has fundamentally different properties that make simplicity more valuable than reuse.

Five ways test code differs from production code:

1. **Tests don't yield to common abstractions** — each test verifies a specific scenario; the "common" parts are coincidental, not essential similarity.
2. **Shared test infrastructure becomes a maintenance bottleneck** — changes to shared helpers cascade across unrelated tests.
3. **DRY tests obscure intent** — when setup is abstracted away, readers must trace through helper layers to understand what's actually being tested.
4. **Test independence matters more than code reuse** — each test should be modifiable in isolation without ripple effects.
5. **Test failures should be immediately interpretable** — complex shared infrastructure makes failures harder to diagnose.

The alternative: DAMP (Descriptive And Meaningful Phrases) tests. Accept repetition in test code in exchange for each test being self-contained, readable, and independently modifiable. The cost of repetition is low (test code changes less frequently than production code); the cost of tangled test infrastructure is high (every shared helper change risks breaking unrelated tests).

Simplicity should be the core property of unit tests: easy to read, understand, and modify in isolation.
