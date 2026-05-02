---
title: "Backward Compatibility for Leaky Abstractions"
garden_type: note
maturity: evergreen
tags: [software-engineering, backward-compatibility, leaky-abstractions, defensive-programming]
created: 2026-04-27
related_posts:
  - /backward-compatibility-where-you-dont-expect/
related_notes: []
excerpt_text: >
  When a framework leaks implementation details (like serializing arguments at schedule time but loading code from HEAD at execution time), changing a function signature breaks the assumption that old code calls old signatures.
---

**When a framework leaks implementation details (like serializing arguments at schedule time but loading code from HEAD at execution time), changing a function signature breaks the assumption that old code calls old signatures.** The defensive fix is a three-step backward-compatible migration: add `**kwargs` and defaults so old payloads don't crash, change the signature while branching logic based on which params are present, then delete the old logic once all old payloads have drained.

This pattern (familiar from protobuf's all-fields-optional philosophy) works whenever callers and callees evolve at different speeds, whether from leaky abstractions, rolling deploys, or serialized state.
