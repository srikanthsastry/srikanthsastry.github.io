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
  Test coverage metrics (line coverage, branch coverage, path coverage) are seductive because they're quantitative, but indexing on them as quality indicators is actively harmful.
---

Test coverage metrics (line coverage, branch coverage, path coverage) are seductive because they're quantitative, but indexing on them as quality indicators is actively harmful.

Coverage tells you which code was *executed* during tests, not which behavior was *verified*. A test that runs every line without asserting anything achieves 100% coverage while testing nothing. Conversely, rigorous tests of the critical paths may show modest coverage numbers because they don't exercise error-handling boilerplate.

The pathologies of coverage-driven testing:

1. **Goodhart's Law** — When coverage becomes the target, developers write tests to satisfy the metric rather than to verify behavior. Tests become coverage-padding exercises.
2. **False confidence** — High coverage numbers create the illusion that the code is well-tested, discouraging the deeper thinking needed for meaningful test design.
3. **Wrong optimization target** — Time spent chasing coverage percentages is time not spent understanding which code paths actually matter and how they can fail.

Coverage is useful as a *floor detector* (very low coverage signals undertesting) but useless as a *ceiling indicator* (high coverage signals nothing about test quality). Treat it as a necessary but wildly insufficient condition.
