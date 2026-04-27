---
title: "Tests as Executable Documentation"
garden_type: note
maturity: evergreen
tags: [software-testing, unit-tests, documentation]
created: 2026-04-27
related_posts:
  - /merits-of-unit-tests-part-1/
related_notes:
  - tests-as-first-customer
excerpt_text: >
  Unit tests are the best documentation for code, superior to wikis, inline comments, and external docs.
---

Unit tests are the best documentation for code, superior to wikis, inline comments, and external docs. Three properties make them uniquely effective:

1. **Discoverability** — they live alongside the code, not in a separate wiki that nobody can find.
2. **Written in the developer's native tongue** — code, not prose. Engineers write software better than they write technical documentation, especially when English isn't their first language.
3. **Self-correcting** — CI ensures tests pass, which means they can never become obsolete. Wrong documentation is worse than no documentation, and tests sidestep this entirely.

Each unit test functions as a "how-to example" for using the code. Anyone wanting to understand an API can read its tests and come away with working knowledge in minutes. The folly::Future library is a canonical example: the header file tells you the API, but the test file teaches you how to actually use it.

This reframes the purpose of unit tests from "verification" to "communication." Verification is the least interesting reason to write tests; documentation is the most enduring.
