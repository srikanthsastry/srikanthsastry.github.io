---
title: "Coverage Metrics Are Misleading"
garden_type: note
maturity: evergreen
tags: [software-testing, unit-tests, metrics, test-coverage]
created: 2026-04-27
related_posts:
  - /do-not-index-in-test-coverage/
related_notes:
  - testability-drives-design
  - tests-as-executable-documentation
excerpt_text: >
  Coverage tells you which code was executed during tests, not which behavior was verified.
---

**Coverage tells you which code was *executed* during tests, not which behavior was *verified*.** A test that runs every line without asserting anything achieves 100% coverage while testing nothing. When coverage becomes the target, Goodhart's Law kicks in: developers write tests to satisfy the metric rather than to verify behavior, high numbers create false confidence that discourages deeper thinking, and time gets spent chasing percentages instead of understanding which paths actually matter.

Coverage is useful as a floor detector — very low coverage signals undertesting — but useless as a ceiling indicator. Treat it as a necessary but wildly insufficient condition.
