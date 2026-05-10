---
title: "Tests as First Customer"
maturity: evergreen
tags: [software-testing, unit-tests, api-design, usability]
created: 2026-04-27
related_notes:
  - testability-drives-design
  - tests-as-executable-documentation
excerpt_text: >
  Writing unit tests makes you your own first customer.
---

**Writing unit tests makes you your own first customer.** By covering all use cases in tests, you probe the user experience of your API before anyone else does. This is distinct from [testability-drives-design](/garden/testability-drives-design/). That's about internal structure, while this is about the external interface. If your test setup is awkward, your API is awkward: combinatorial constructors, nonsensical method calls, ambiguous entry points all surface as pain during test writing.

API usability and testability form a virtuous cycle: simplifying the API constrains code paths, which makes it more testable, which reveals further simplifications. The tests become a feedback loop that polishes the interface from the consumer's perspective.
