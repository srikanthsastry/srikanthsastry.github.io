---
title: "The London School of Unit Testing"
garden_type: note
maturity: evergreen
tags: [software-testing, unit-tests, test-design, london-school]
created: 2026-04-27
related_posts:
  - /defining-unit-tests-two-schools-of-thought/
  - /in-unit-tests-i-favor-detroit-over-london/
  - defining-unit-tests-two-schools-of-thought
related_notes:
  - detroit-school-testing
  - detroit-vs-london-testing
  - mocks-in-testing
excerpt_text: >
  The London (mockist) school defines a unit as a single class, sometimes a single method.
---

**The London (mockist) school defines a unit as a *single class*, sometimes a single method.** Everything outside that class must be replaced by test doubles. If the class under test instantiates another class internally, that instantiation must use an injected instance or factory so it can be replaced in tests.

This definition was popularized by Steve Freeman and Nat Pryce in *Growing Object-Oriented Software, Guided by Tests*. Its consequence: London tests provide precise fault localization because every collaborator is [mocked](/garden/mocks-in-testing/). The tradeoff: tests are tightly coupled to internal structure. Renaming a method, extracting a class, or changing how collaborators interact breaks tests even when observable behavior is unchanged.
