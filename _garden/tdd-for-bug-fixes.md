---
title: "TDD for Bug Fixes"
garden_type: note
maturity: evergreen
tags: [software-testing, tdd, bug-fixing, test-driven-development]
created: 2026-04-27
related_posts:
  - /tdd-for-bug-fixes/
related_notes:
  - tests-as-executable-documentation
  - tests-for-maintainability
excerpt_text: >
  Bug fixes should follow a TDD workflow split across two PRs.
---

**Bug fixes should follow a TDD workflow split across two PRs.** The first PR proves the bug: write a test that invokes the code with the offending input and asserts the *incorrect* (current buggy) output — this test passes, confirming the bug is reproducible. The second PR fixes the code and flips the assertion to expect the *correct* output.

Why not a single PR? Because when both the fix and the test arrive together, you cannot verify the test actually catches the bug — it might pass regardless. The two-PR approach gives a verifiable chain: the test [documents](/garden/tests-as-executable-documentation/) the bug, then the fix proves itself against that documentation.
