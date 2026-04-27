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
  Stubs and mocks serve fundamentally different purposes and should not be used interchangeably.
---

**Stubs and mocks serve fundamentally different purposes and should not be used interchangeably.** Stubs provide canned responses: they replace a dependency's *output* so the test controls what the SUT sees. Mocks verify interactions: they assert the SUT communicated correctly with its collaborators. The common mistake is using mocks everywhere because frameworks make it easy, creating brittle tests coupled to implementation details that break on any refactoring.

Prefer stubs for queries (methods that return data) and reserve mocks for commands (methods that produce side effects you need to verify). This aligns with [testing behavior over implementation](/garden/test-behavior-not-implementation/).
