---
title: "Backstop Layer Must Be Weaker"
garden_type: note
maturity: budding
created: 2026-04-27
related_posts: []
related_notes:
  - backstop-cannot-be-review
  - cedar-expressiveness-decidability-tradeoff
  - pbt-locality-cross-system-guardrails
excerpt_text: >
  The backstop layer must be less expressive than the system it guards.
---

**The backstop layer must be less expressive than the system it guards.** Leveson's STAMP principle: the control structure must be independent of the thing it controls. Sharpened: the control structure must be *less expressive* than the system it governs. Weak enough to verify, strong enough to capture the invariants that matter.

Turing completeness is the enemy of verification. The moment a policy language can express arbitrary computation, you lose decidability and any hope of proving properties about it. Every successful formal verification story is a story about giving up Turing completeness in a specific layer so that layer can be machine-checked. The pattern generalizes: type systems, TLA+, property-based testing specs all trade expressiveness for decidability in one layer while leaving the implementation layer unconstrained.
