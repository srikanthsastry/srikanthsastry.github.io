---
title: "Fakes Over Stubs"
garden_type: note
maturity: evergreen
tags: [software-testing, unit-tests, test-doubles, fakes]
created: 2026-04-27
related_posts:
  - /mocks-stubs-andhow-to-use-them/
related_notes:
  - mocks-vs-stubs
  - stubs-in-testing
excerpt_text: >
  Prefer fakes over stubs when the dependency has stateful behavior.
---

**Prefer fakes over stubs when the dependency has stateful behavior.** A fake implements the same API with a lightweight backing store (a Dict instead of a database, for example). Fakes are more robust to refactoring and more extensible than stubs with preconfigured return values, because they do not require resetting or ordered canned responses for different user journeys.
