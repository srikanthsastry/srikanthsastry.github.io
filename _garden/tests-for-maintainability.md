---
title: "Tests Exist for Maintainability"
garden_type: note
maturity: evergreen
tags: [software-testing, unit-tests, software-maintenance]
created: 2026-04-27
related_posts:
  - /the-big-why-about-unit-tests/
related_notes:
  - test-behavior-not-implementation
  - tests-as-executable-documentation
  - tests-as-refactoring-safety-net
excerpt_text: >
  The fundamental purpose of unit tests is not verification — it is sustainable software maintenance.
---

The fundamental purpose of unit tests is not verification — it is sustainable software maintenance. Verification is a side effect. The real value proposition: unit tests enable a codebase to evolve over time without degrading.

This reframing has practical consequences:
- Tests that verify behavior but are themselves unmaintainable defeat the purpose
- Tests that pass but are so complex nobody dares modify them are net negative
- The test suite's value is proportional to the confidence it gives developers to change code, not to the number of assertions it contains

When maintenance is the north star, every testing decision follows: simplicity over cleverness, behavior over implementation, independence over shared infrastructure, readability over DRY.
