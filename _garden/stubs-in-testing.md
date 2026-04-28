---
title: "Stubs in Testing"
garden_type: note
maturity: evergreen
tags: [software-testing, unit-tests, test-doubles, stubs]
created: 2026-04-27
related_posts:
  - /mocks-stubs-andhow-to-use-them/
related_notes:
  - fakes-over-stubs
  - mocks-in-testing
  - mocks-vs-stubs
  - test-behavior-not-implementation
excerpt_text: >
  Stubs replace inbound interactions from dependencies to the SUT by providing canned responses so the test controls what the SUT sees.
---

**Stubs replace inbound interactions from dependencies to the SUT by providing canned responses so the test controls what the SUT sees.** The critical rule: do not assert on outbound calls to a stub. That call is an implementation detail. If a refactor caches a previously fetched value, asserting on the stub call causes test failures with no behavior change. This is over-specification.
