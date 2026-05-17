---
title: "Three Classes of Guardrail Erosion Resistance"
maturity: budding
tags: [guardrail-erosion, taxonomy, formal-verification, suggestible-actor]
created: 2026-04-24
related_notes:
  - guardrail-erosion-meta-problem
  - static-analysis-insufficient-for-ai-code
  - social-guardrails
  - encoded-guardrails
  - structural-guardrails
excerpt_text: >
  Guardrails fall into three classes by erosion resistance: erasable (convention-dependent), detectable (tool-enforced), and immutable (formally enforced).
---
**Guardrails fall into three classes by erosion resistance: erasable (convention-dependent), detectable (tool-enforced), and immutable (formally enforced).** [Social guardrails](/garden/social-guardrails/) (documentation, naming conventions, architectural patterns as "how we do things") erode fastest because the [suggestible actor](/garden/suggestible-actor-properties/) walks through conventions without noticing. [Encoded guardrails](/garden/encoded-guardrails/) (linters, [static analysis](/garden/static-analysis-insufficient-for-ai-code/), CI/CD gates) erode moderately because agents respond to errors but can satisfy checks trivially without satisfying the underlying invariant. [Structural guardrails](/garden/structural-guardrails/) (type systems, capability restrictions, property-based tests, formal verification) resist erosion because they encode mathematical properties that cannot be circumvented by pattern-matching.

Most guardrails prescribed in the Suggestible Actor post are social or encoded. The only erosion-resistant class is structural, which most codebases have very little of.
