---
title: "Testability Forces Dependency Injection"
garden_type: note
maturity: evergreen
tags: [software-testing, unit-tests, software-design, dependency-injection]
created: 2026-04-27
related_posts:
  - /the-merits-of-unit-tests-part-3/
related_notes:
  - testability-drives-design
  - tests-as-first-customer
excerpt_text: >
  Testability forces dependency injection: code that constructs its own dependencies internally is untestable without expensive integration infrastructure.
---

**Testability forces dependency injection: code that constructs its own dependencies internally is untestable without expensive integration infrastructure.** Tests force you to inject dependencies from outside, making them explicit and swappable. This is not just a testing convenience. It reveals the real dependency graph that was previously hidden inside constructors and factory methods.
