---
title: "Stubs in Testing"
garden_type: note
maturity: evergreen
tags: [software-testing, unit-tests, test-doubles, stubs]
created: 2026-04-27
related_posts:
  - /mocks-stubs-andhow-to-use-them/
related_notes:
  - mocks-in-testing
  - mocks-vs-stubs
  - test-behavior-not-implementation
excerpt_text: >
  Stubs replace inbound interactions from dependencies to the SUT. They provide canned responses so the test controls what the SUT sees.
---

**Stubs replace inbound interactions from dependencies to the SUT.** They provide canned responses so the test controls what the SUT sees. The critical rule: do not assert on outbound calls to a stub. That call is an implementation detail. If a refactor caches a previously fetched value, asserting on the stub call causes test failures with no behavior change. This is over-specification.

When using a stub, consider whether a fake is better. A fake implements the same API with a lightweight backing store (a Dict instead of a database, for example). Fakes are more robust to refactoring and more extensible than stubs with preconfigured return values, because they don't require resetting or ordered canned responses for different user journeys.
