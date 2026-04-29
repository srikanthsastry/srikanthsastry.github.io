---
title: "Backstop Cannot Be Review"
garden_type: note
maturity: budding
tags: [guardrail-erosion, review-asymmetry, backstop, formal-verification]
created: 2026-04-26
related_posts: []
related_notes:
  - backstop-layer-must-be-weaker
  - review-is-the-bottleneck
  - three-classes-of-guardrail-erosion-resistance
excerpt_text: >
  If review does not scale with AI code generation, the backstop layer cannot be review.
---

**If review does not scale with AI code generation, the backstop layer cannot be review.** Whatever gates AI-generated code must be structurally enforceable. It must fail closed without a human reading every line. This rules out human code review as the primary quality gate and points toward formal enforcement: type systems, property-based tests, verified DSLs, and other mechanisms that reject invalid code automatically.
