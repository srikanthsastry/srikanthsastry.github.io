---
title: "Unit Test Attribute Tradeoffs"
garden_type: note
maturity: evergreen
tags: [software-testing, unit-tests, test-design]
created: 2026-04-27
related_posts:
  - /unit-test-attributes-and-their-trade-offs/
related_notes:
  - coverage-metrics-are-misleading
  - detroit-vs-london-testing
  - test-behavior-not-implementation
excerpt_text: >
  Unit test suites have three primary attributes in tension with each other:
---

Unit test suites have three primary attributes in tension with each other:

1. **Accuracy** — If a test fails, how likely is it that there's a real bug? Low accuracy means brittle tests that cry wolf, eroding trust in the suite.
2. **Completeness** — If there's a bug, how likely is it that a test will catch it? Coverage metrics attempt to proxy this but are often misleading.
3. **Speed** — How quickly does the suite run? Slow suites discourage frequent testing and increase iteration time.

You cannot maximize all three simultaneously. Maximizing any two minimizes the third:
- High accuracy + high completeness → huge, slow suite
- High accuracy + fast → incomplete (only common paths tested)
- High completeness + fast → over-mocked, brittle (low accuracy)

The practical priority: **never sacrifice accuracy**. Accurate tests are the bedrock of a trustworthy suite. Once accuracy is maximized, trade off between completeness and speed based on your tolerance for production failures. The quality of a test suite is determined by its weakest attribute.
