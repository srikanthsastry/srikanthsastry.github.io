---
title: "Minimize Public Surface for Testability"
garden_type: note
maturity: evergreen
tags: [software-testing, unit-tests, encapsulation, software-design]
created: 2026-04-27
related_posts:
  - /privatize-your-classes-for-better-unit-testing/
related_notes:
  - test-behavior-not-implementation
  - testability-drives-design
  - tests-for-maintainability
  - unit-test-attribute-tradeoffs
excerpt_text: >
  If a class is only used internally by another class, don't test it directly.
---

**If a class is only used internally by another class, don't test it directly. Test it through the public class it serves.** If `HideMe` is private to `CallMe` and you refactor their internal API, `HideMe`'s tests break without adding information that `CallMe`'s tests don't already provide. Those tests have zero marginal value and non-zero maintenance cost.

Aggressively push logic into private classes, limit the public surface that needs direct testing, and verify through the public contract. This yields high [unit-test-attribute-tradeoffs](/garden/unit-test-attribute-tradeoffs/) with reasonable completeness and a smaller, more [tests-for-maintainability](/garden/tests-for-maintainability/) suite.
