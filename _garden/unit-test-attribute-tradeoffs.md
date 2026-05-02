---
title: "Unit Test Attribute Trilemma"
maturity: evergreen
tags: [software-testing, unit-tests, test-design]
created: 2026-04-27
related_posts:
  - /unit-test-attributes-and-their-trade-offs/
related_notes:
  - coverage-metrics-are-misleading
  - detroit-vs-london-testing
  - never-sacrifice-test-accuracy
  - test-behavior-not-implementation
excerpt_text: >
  Unit test suites have three attributes in tension: accuracy (if a test fails, is there a real bug?
---

**Unit test suites have three attributes in tension: accuracy (if a test fails, is there a real bug?), completeness (if there is a bug, will a test catch it?), and speed.** You cannot maximize all three. High accuracy plus completeness yields a huge, slow suite. Accuracy plus speed sacrifices completeness. Completeness plus speed requires over-mocking that tanks accuracy. The quality of a suite is determined by its weakest attribute.
