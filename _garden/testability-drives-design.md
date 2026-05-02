---
title: "Testability Forces Modularity"
garden_type: note
maturity: evergreen
tags: [software-testing, unit-tests, software-design, modularity]
created: 2026-04-27
related_posts:
  - /the-merits-of-unit-tests-part-3/
  - the-merits-of-unit-tests-part-3
related_notes:
  - testability-forces-dependency-injection
  - tests-as-executable-documentation
  - tests-as-first-customer
  - tests-as-refactoring-safety-net
excerpt_text: >
  Hard-to-test code is a design smell: if a class is hard to test, it is doing too much.
---

**Hard-to-test code is a design smell: if a class is hard to test, it is doing too much.** Too many input combinations, too many side effects, too many conflated concerns. The cure is extraction. Writing unit tests exerts pressure toward smaller, focused modules because the test demands a unit small enough to exercise in isolation.
