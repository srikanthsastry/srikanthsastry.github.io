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
  Bug fixes should follow a TDD workflow split across two PRs:
---

Bug fixes should follow a TDD workflow split across two PRs:

1. **PR 1 — Prove the bug:** Write a test that invokes the code with the offending input and asserts the *incorrect* (current buggy) output. This test passes, proving the bug exists and is reproducible.

2. **PR 2 — Fix and flip:** Fix the production code and update the test assertion to expect the *correct* output. The test now passes with the fix, providing proof that the fix works.

Why not a single PR? Because when both the fix and the test arrive together, you cannot verify that the test actually catches the bug. The test might be a dud — passing regardless of the fix. The two-PR approach gives you a verifiable chain: the test fails on old code (PR 1 proved it), and passes on new code (PR 2 proves the fix).
