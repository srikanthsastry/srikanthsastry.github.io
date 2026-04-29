---
title: "Coupled Tests"
garden_type: note
maturity: evergreen
tags: [software-testing, unit-tests, test-design, anti-patterns]
created: 2026-04-27
related_posts:
  - /tests-should-be-isolated-not-coupled/
related_notes:
  - simplicity-over-dry-in-tests
  - unit-test-attribute-tradeoffs
excerpt_text: >
  Coupled tests (tests whose outcomes depend on other tests) are one of the most corrosive anti-patterns in a test suite.
---

**Coupled tests (tests whose outcomes depend on other tests through shared mutable state, execution ordering, or shared infrastructure) are one of the most corrosive anti-patterns in a test suite.** Tests that pass in isolation but fail together, that change results with execution order, or that break in cascades when one test is modified all signal coupling. The two most pervasive sources are precondition bloat in test fixtures (setUp accumulates state for multiple tests) and heterogeneous parameterized tests (cramming different assertion types into shared infrastructure).

The fix: each test owns its preconditions. Use setUp for dependency instantiation only; move precondition-setting into each test's arrange step. Accept the [duplication](/garden/simplicity-over-dry-in-tests/). Independent tests are worth the repetition.
n.
