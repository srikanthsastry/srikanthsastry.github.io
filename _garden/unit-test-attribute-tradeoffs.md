---
title: "Unit Test Attribute Tradeoffs"
garden_type: note
maturity: evergreen
tags: [software-testing, unit-tests, test-design]
created: 2026-04-27
related_posts:
  - /unit-test-attributes-and-their-trade-offs/
related_notes:
  - coverage-metrics-are-misleading
  - detroit-vs-london-testing
  - test-behavior-not-implementation
excerpt_text: >
  Unit test suites have three attributes in tension: accuracy, completeness, and speed. You cannot maximize all three.
---

**Unit test suites have three attributes in tension: accuracy (if a test fails, is there a real bug?), completeness (if there's a bug, will a test catch it?), and speed.** You cannot maximize all three. High accuracy + completeness yields a huge, slow suite; accuracy + speed sacrifices completeness; completeness + speed requires over-mocking that tanks accuracy.

**Never sacrifice accuracy.** Accurate tests are the bedrock of a trustworthy suite. Once accuracy is locked in, trade off completeness against speed based on your tolerance for production failures. [Coverage metrics](/garden/coverage-metrics-are-misleading/) attempt to proxy completeness but fail at it. The quality of a suite is determined by its weakest attribute.
