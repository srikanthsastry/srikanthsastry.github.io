---
title: "Law of Demeter and Testing"
garden_type: note
maturity: evergreen
tags: [software-testing, unit-tests, law-of-demeter, software-design, coupling]
created: 2026-04-27
related_posts:
  - /law-of-demeter-and-unit-tests/
related_notes:
  - minimize-public-surface-for-testability
  - testability-drives-design
excerpt_text: >
  The Law of Demeter ("only talk to your immediate friends") takes two forms relevant to testability:
---

The Law of Demeter ("only talk to your immediate friends") takes two forms relevant to testability:

**Object chains:** Code like `a.getB().getC().doThing()` forces tests to set up the entire chain of collaborators as mocks. Each link requires another mock, and changing any link cascades test failures. The fix: push behavior toward the object that owns the data — encapsulate operations within the immediate dependency.

**Fat parameters:** Passing a large data object (e.g., an entire `Customer`) when the function only needs two fields (name, email) creates test noise. Every test must construct a complete object with irrelevant fields, making it unclear which fields matter. The fix: accept only the data the function needs.

Both forms create the same testing problem: tests that know too much about collaborator structure, making them brittle and hard to read. Demeter violations in production code become mock chains and bloated test fixtures in test code — the test is telling you the design needs work.
