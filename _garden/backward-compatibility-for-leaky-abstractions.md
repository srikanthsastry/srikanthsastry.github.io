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
  When a framework leaks implementation details — like serializing function arguments at schedule time but loading function code from HEAD at execution time — changing a function signature breaks the assumption that old code calls old signatures and new code calls new ones.
---

When a framework leaks implementation details — like serializing function arguments at schedule time but loading function code from HEAD at execution time — changing a function signature breaks the assumption that old code calls old signatures and new code calls new ones.

The defensive fix is a three-step backward-compatible migration:

1. **Add `**kwargs` and defaults:** Accept unknown parameters without crashing. Log warnings for unrecognized args. Make all params optional with sensible defaults.
2. **Change the signature:** Old serialized payloads pass old params via `**kwargs`; new payloads pass new params directly. Branch logic based on which params are present.
3. **Delete old logic:** Once all old payloads have drained, remove the backward-compat branch.

This pattern — familiar from protobuf's all-fields-optional philosophy — works whenever callers and callees can evolve at different speeds, whether due to leaky abstractions, rolling deploys, or serialized state.
