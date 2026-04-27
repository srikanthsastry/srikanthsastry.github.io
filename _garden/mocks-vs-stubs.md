---
title: "Mocks vs. Stubs: When to Use Which"
garden_type: note
maturity: evergreen
tags: [software-testing, unit-tests, test-doubles, mocks, stubs]
created: 2026-04-27
related_posts:
  - /mocks-stubs-andhow-to-use-them/
related_notes:
  - stubs-in-testing
  - mocks-in-testing
  - test-behavior-not-implementation
  - simplicity-over-dry-in-tests
  - testability-drives-design
excerpt_text: >
  Stubs and mocks serve fundamentally different purposes. Stubs handle inbound interactions. Mocks handle outbound interactions.
---

**[Stubs](/garden/stubs-in-testing/) and [mocks](/garden/mocks-in-testing/) serve fundamentally different purposes and should not be used interchangeably.** Stubs handle inbound interactions: they control what the SUT receives. Mocks handle outbound interactions: they verify what the SUT sends. The common mistake is using mocks everywhere because frameworks make it easy, coupling tests to implementation details that break on any refactoring.

The rule: prefer [stubs](/garden/stubs-in-testing/) for queries and reserve [mocks](/garden/mocks-in-testing/) for commands. This aligns with [testing behavior over implementation](/garden/test-behavior-not-implementation/).
