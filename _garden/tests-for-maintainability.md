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
  The fundamental purpose of unit tests is not verification. It is sustainable software maintenance.
---

**The fundamental purpose of unit tests is not verification. It is sustainable software maintenance.** Verification is a side effect. The real value: unit tests enable a codebase to evolve over time without degrading. Tests that verify behavior but are themselves unmaintainable defeat the purpose; tests so complex nobody dares modify them are net negative.

When maintenance is the north star, every testing decision follows: [simplicity over cleverness](/garden/simplicity-over-dry-in-tests/), [behavior over implementation](/garden/test-behavior-not-implementation/), independence over shared infrastructure, [readability over DRY](/garden/tests-as-executable-documentation/).
