---
title: "Tests as First Customer"
garden_type: note
maturity: evergreen
tags: [software-testing, unit-tests, api-design, usability]
created: 2026-04-27
related_posts:
  - /merits-of-unit-tests-part-5/
related_notes:
  - testability-drives-design
  - tests-as-executable-documentation
excerpt_text: >
  Writing unit tests makes you your own first customer.
---

Writing unit tests makes you your own first customer. By covering all use cases in tests, you are forced to wear the consumer's hat and probe the user experience of your API. This is distinct from [testability as a design heuristic](/garden/testability-drives-design/) — that's about internal structure, while this is about the external interface.

The diagnostic is practical: if your test setup is awkward, your API is awkward. Combinatorial constructor variants, nonsensical method calls on certain configurations, ambiguous entry points — these all surface as pain during test writing before they surface as pain for real consumers.

The pattern that emerges:

1. Write tests for the first API draft
2. Notice friction (too many constructor variants, ambiguous state combinations, methods that shouldn't be callable in certain configurations)
3. Redesign the API to eliminate the friction
4. Repeat until the tests read cleanly

A simpler, more usable API also constrains code paths, making the code more testable and less bug-prone. API usability and testability form a virtuous cycle: each improvement in one feeds the other.
