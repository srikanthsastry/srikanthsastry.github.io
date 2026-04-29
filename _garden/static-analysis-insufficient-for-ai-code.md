---
title: "Static Analysis Insufficient For Ai Code"
garden_type: note
maturity: evergreen
tags: [guardrail-erosion, static-analysis, formal-verification, suggestible-actor]
created: 2026-04-24
related_posts: []
related_notes:
  - backstop-layer-must-be-weaker
  - three-classes-of-guardrail-erosion-resistance
excerpt_text: >
  Industry static analysis tools are structurally insufficient for AI-generated code.
---

**Industry static analysis tools are structurally insufficient for AI-generated code.** Blain's Z3 study found that six industry static analysis tools combined flag only 7.6% of artifacts and miss 97.8% of formally proven vulnerabilities. The CI/CD enforcement layer that the Suggestible Actor post relies on (linters, type checks, static analyzers) catches a fraction of what formal verification catches. This is not a configuration problem. It is a structural gap between pattern-based detection and property-based proof.
