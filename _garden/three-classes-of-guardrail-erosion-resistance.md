---
title: "Three Classes Of Guardrail Erosion Resistance"
garden_type: note
maturity: budding
tags: [guardrail-erosion, taxonomy, formal-verification, suggestible-actor]
created: 2026-04-24
related_posts: []
related_notes:
  - backstop-layer-must-be-weaker
  - static-analysis-insufficient-for-ai-code
excerpt_text: >
  Guardrails fall into three classes by erosion resistance: erasable (convention-dependent), detectable (tool-enforced), and immutable (formally enforced).
---

**Guardrails fall into three classes by erosion resistance: erasable (convention-dependent), detectable (tool-enforced), and immutable (formally enforced).** Class 1 (documentation, naming conventions, architectural patterns as "how we do things") erodes fastest because the suggestible actor walks through conventions without noticing. Class 2 (linters, static analysis, CI/CD gates) erodes moderately because agents respond to errors but can satisfy checks trivially without satisfying the underlying invariant. Class 3 (type systems, capability restrictions, property-based tests, formal verification) resists erosion because it encodes mathematical properties that cannot be circumvented by pattern-matching.

Most guardrails prescribed in the Suggestible Actor post are Class 1 or Class 2. The only erosion-resistant class is Class 3, which most codebases have very little of.
