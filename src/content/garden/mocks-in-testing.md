---
title: "Mocks in Testing"
maturity: evergreen
tags: [software-testing, unit-tests, test-doubles, mocks]
created: 2026-04-27
related_notes:
  - mocks-vs-stubs
  - stubs-in-testing
  - test-behavior-not-implementation
excerpt_text: >
  Mocks verify outbound interactions from the SUT to its dependencies.
---

**Mocks verify outbound interactions from the SUT to its dependencies.** They assert that the SUT communicated correctly: the right method was called, with the right arguments, the right number of times. Use mocks when the side effect *is* part of the specification (logging to a server, sending an email, filing a task).

The common misuse: applying mocks where [stubs](/garden/stubs-in-testing/) belong. Verifying that a data-fetching call happened is over-specification. It couples the test to implementation details and makes it brittle to refactoring. Reserve mocks for commands (methods that produce observable side effects), not queries (methods that return data).
