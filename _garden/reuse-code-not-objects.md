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
  DRY applies to code, not to object instances. Reusing stateful objects across iterations introduces subtle state leakage bugs.
---

**DRY applies to *code*, not to *object instances*.** Reusing stateful objects across iterations (creating once and calling `init()` or `reset()` each time) introduces subtle state leakage bugs. When one iteration throws partway through, some fields retain stale values from the previous iteration. The next consumer reads corrupted state that is type-correct (no crash, just silently wrong), only manifests when a preceding iteration fails in a specific way, and appears in iteration N despite being caused by iteration N-1.

The fix: create new instances and discard them. Prefer immutable, disposable objects over mutable, long-lived ones.
