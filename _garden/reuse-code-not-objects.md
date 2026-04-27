---
title: "Reuse Code, Not Objects"
garden_type: note
maturity: evergreen
tags: [software-engineering, design-patterns, DRY, statefulness]
created: 2026-04-27
related_posts:
  - /reuse-code-not-objects/
related_notes: []
excerpt_text: >
  DRY (Don't Repeat Yourself) applies to code, not to object instances.
---

DRY (Don't Repeat Yourself) applies to *code*, not to *object instances*. Reusing stateful objects across iterations is a common anti-pattern that introduces subtle, hard-to-debug state leakage bugs.

The pattern: a stateful object is created once and reused in a loop via an `init()` or `reset()` method. When processing one iteration throws an exception partway through, some fields retain stale values from the *previous* iteration. The next consumer of those fields reads corrupted state without any indication that it's stale.

These bugs are particularly dangerous because:
- The stale state is *type-correct* — it won't cause a crash, just silently wrong behavior
- The bug only manifests when a preceding iteration fails in a specific way
- The failure mode is non-local: the bug appears in iteration N but was caused by iteration N-1

The fix is simple: create new instances and discard them when done. If object creation is expensive, that's a separate optimization problem — don't let it drive you into reusing mutable state.

The general principle: prefer immutable, disposable objects over mutable, long-lived ones. When you must have state, make it explicit and contained rather than accumulated across uses.
