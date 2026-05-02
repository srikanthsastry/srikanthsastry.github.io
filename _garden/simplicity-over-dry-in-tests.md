---
title: "Simplicity Over DRY in Tests"
garden_type: note
maturity: evergreen
tags: [software-testing, unit-tests, DRY, test-design]
created: 2026-04-27
related_posts:
  - /dry-unit-tests-are-bad/
  - dry-unit-tests-are-bad
related_notes:
  - coverage-metrics-are-misleading
  - tests-as-executable-documentation
excerpt_text: >
  DRY is near-universal in production code, but applying it dogmatically to test code causes more problems than it solves.
---

**DRY is near-universal in production code, but applying it dogmatically to test code causes more problems than it solves.** Each test verifies a specific scenario where the "common" parts are coincidental, not essential; shared infrastructure becomes a maintenance bottleneck; abstracted setup obscures intent; and complex shared helpers make failures harder to diagnose. Test code has different properties than production code, and simplicity matters more than reuse.

The alternative is DAMP (Descriptive And Meaningful Phrases): accept repetition in exchange for each test being self-contained, readable, and independently modifiable. The cost of repetition is low. Test code changes less frequently. The cost of tangled test infrastructure is high.
