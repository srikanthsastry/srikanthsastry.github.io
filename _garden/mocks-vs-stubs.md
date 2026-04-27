---
title: "Mocks vs. Stubs: When to Use Which"
garden_type: note
maturity: evergreen
tags: [software-testing, unit-tests, test-doubles, mocks, stubs]
created: 2026-04-27
related_posts:
  - /mocks-stubs-andhow-to-use-them/
related_notes:
  - simplicity-over-dry-in-tests
  - testability-drives-design
excerpt_text: >
  Test doubles isolate the System Under Test (SUT) from external dependencies.
---

Test doubles isolate the System Under Test (SUT) from external dependencies. The two primary types — stubs and mocks — serve fundamentally different purposes and should not be used interchangeably.

**Stubs** provide canned responses to the SUT. They replace a dependency's *output* so the test can control what the SUT sees. Use stubs when verifying what the SUT *does* with the data it receives.

**Mocks** verify that the SUT called a dependency in a specific way. They replace a dependency's *input* and assert on interactions. Use mocks when verifying that the SUT *communicates correctly* with its collaborators.

The common mistake: using mocks everywhere (because mocking frameworks make it easy) when stubs would suffice. Over-mocking creates brittle tests coupled to implementation details — if you refactor internals without changing behavior, mock-heavy tests break. Stub-based tests survive refactoring because they verify outcomes, not interactions.

Rule of thumb: prefer stubs for queries (methods that return data) and reserve mocks for commands (methods that produce side effects you need to verify).
