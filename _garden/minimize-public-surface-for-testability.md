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
  - unit-test-attribute-tradeoffs
excerpt_text: >
  If a class is only used internally by another class, don't write unit tests for it directly.
---

If a class is only used internally by another class, don't write unit tests for it directly. Test it indirectly through the public class it serves. This fractal pattern — modules with strict API boundaries containing private implementation classes — pays dividends in test suite quality.

Why: If `HideMe` is private to `CallMe`, and you refactor their internal API, `HideMe`'s tests will break. But that breakage tells you nothing that `CallMe`'s tests don't already tell you. The failure could be a real bug or just a test-update error — you can't distinguish without running `CallMe`'s tests anyway. So `HideMe`'s tests have zero marginal information value and non-zero maintenance cost.

The principle: aggressively push logic into private classes, limit the public API surface that needs direct testing, and test through the public contract. This yields high accuracy with reasonable completeness and a smaller, more maintainable test suite.
