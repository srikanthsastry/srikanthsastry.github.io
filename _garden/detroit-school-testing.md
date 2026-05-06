---
title: "The Detroit School of Unit Testing"
maturity: evergreen
tags: [software-testing, unit-tests, test-design, detroit-school]
created: 2026-04-27
related_notes:
  - detroit-vs-london-testing
  - london-school-testing
  - mocks-vs-stubs
excerpt_text: >
  The Detroit (classical) school defines a unit as a unit of behavior: one or more classes collaborating to produce an observable result.
---

**The Detroit (classical) school defines a unit as a *unit of behavior*: one or more classes collaborating to produce an observable result.** Code in a unit must be internal, connected in the dependency tree, and not shared with other parts of the software. Isolation means replacing only shared and external dependencies with test doubles. Private, non-shared dependencies participate as real collaborators.

This definition originated with Kent Beck's *Test Driven Development*. Its consequence: Detroit tests exercise real collaboration between classes. They break only when behavior changes, not when internal structure is reorganized. The tradeoff is coarser fault localization. When a test fails, the bug could be in any class participating in the behavior.
