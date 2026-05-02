---
title: "Tests as Executable Documentation"
garden_type: note
maturity: evergreen
tags: [software-testing, unit-tests, documentation]
created: 2026-04-27
related_posts:
  - /merits-of-unit-tests-part-1/
  - merits-of-unit-tests-part-1
related_notes:
  - tests-as-first-customer
excerpt_text: >
  Unit tests are the best documentation for code.
---

**Unit tests are the best documentation for code.** They're discoverable (they live alongside the code), written in the developer's native tongue (code, not prose), and self-correcting (CI ensures they never become obsolete). Each test is a how-to example. Anyone wanting to understand an API can read its tests and come away with working knowledge faster than from any wiki or Javadoc.

This reframes unit tests from verification to communication. Verification is the least interesting reason to write tests; [tests-as-first-customer](/garden/tests-as-first-customer/) is the most enduring.
