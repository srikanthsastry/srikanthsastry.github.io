---
title: "Testability Drives Design"
garden_type: note
maturity: evergreen
tags: [software-testing, unit-tests, software-design, modularity, dependency-injection]
created: 2026-04-27
related_posts:
  - /the-merits-of-unit-tests-part-3/
related_notes:
  - tests-as-executable-documentation
  - tests-as-refactoring-safety-net
excerpt_text: >
  Hard-to-test code is a design smell.
---

**Hard-to-test code is a design smell.** Writing unit tests exerts pressure that improves software in two ways. First, modularity: if a class is hard to test, it's doing too much — too many input combinations, too many side effects, too many conflated concerns. The cure is extraction. Second, dependency injection: code that constructs its own dependencies internally is untestable without expensive integration infrastructure, so tests force you to inject from outside, making dependencies explicit and swappable.

This is [testability as a design heuristic](/garden/tests-as-first-customer/), not just a verification mechanism. The tests aren't checking behavior — they're revealing structural problems.
