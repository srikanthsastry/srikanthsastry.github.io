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
  Coupled tests are tests whose outcomes depend on other tests — through shared mutable state, execution ordering, or shared test infrastructure.
---

Coupled tests are tests whose outcomes depend on other tests — through shared mutable state, execution ordering, or shared test infrastructure. They are one of the most corrosive anti-patterns in a test suite.

Symptoms:
- Tests pass in isolation but fail together (or vice versa)
- Test results change with execution order
- Modifying one test causes unrelated tests to fail
- Shared setup/teardown accumulates complexity that obscures each test's actual preconditions

Two subtle but pervasive sources of coupling:
1. **Precondition bloat in test fixtures** — setUp methods accumulate state for multiple tests, creating hidden dependencies between tests that share the fixture.
2. **Heterogeneous parameterized tests** — cramming different assertion types into one parameterized test couples all parameters through shared test infrastructure.

The fix: each test should own its preconditions. Use setUp for dependency instantiation only; move precondition setting into each test's arrange step. Accept the duplication — independent tests are worth the repetition.
