---
title: "Test Behavior, Not Implementation"
maturity: evergreen
tags: [software-testing, unit-tests, test-design]
created: 2026-04-27
related_posts:
  - /unit-test-the-brains-and-not-the-nerves/
related_notes:
  - mocks-vs-stubs
  - tests-as-refactoring-safety-net
excerpt_text: >
  Test what a system does (brains), not how it does it (nerves).
---

**Test what a system does (brains), not how it does it (nerves).** Tests coupled to implementation details break during legitimate refactoring and provide false confidence. They pass when the wiring is correct but miss behavioral bugs. A test that asserts "given input X, the output is Y" survives refactoring. A test that asserts "method A calls method B with argument C" breaks the moment you restructure internals.

The fix: test at the public interface boundary. Provide inputs, assert on outputs and observable side effects. Let the implementation be free to change. When tests mirror production code structure line-by-line or require deep knowledge of internals to set up, they're [mocks-vs-stubs](/garden/mocks-vs-stubs/).
