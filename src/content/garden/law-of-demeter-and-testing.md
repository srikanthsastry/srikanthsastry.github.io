---
title: "Law of Demeter and Testing"
maturity: evergreen
tags: [software-testing, unit-tests, law-of-demeter, software-design, coupling]
created: 2026-04-27
related_notes:
  - minimize-public-surface-for-testability
  - testability-drives-design
excerpt_text: >
  Demeter violations in production code become mock chains and bloated test fixtures in test code.
---

**Demeter violations in production code become mock chains and bloated test fixtures in test code.** The Law of Demeter ("only talk to your immediate friends") surfaces two testing problems. Object chains like `a.getB().getC().doThing()` force tests to mock the entire chain, and changing any link cascades failures. Fat parameters (passing a whole `Customer` when you need two fields) create test noise where every test constructs a complete object with irrelevant fields.

Both forms force tests to know too much about collaborator structure. The test is telling you the [testability-drives-design](/garden/testability-drives-design/): push behavior toward the object that owns the data, accept only the data the function needs.
