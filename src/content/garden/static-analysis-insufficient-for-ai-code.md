---
title: "Static Analysis Is Insufficient for AI Code"
maturity: evergreen
tags: [guardrail-erosion, static-analysis, formal-verification, suggestible-actor]
created: 2026-04-24
related_notes:
  - three-classes-of-guardrail-erosion-resistance
excerpt_text: >
  Industry static analysis tools are structurally insufficient for AI-generated code.
---
**Industry static analysis tools are structurally insufficient for AI-generated code.** [Blain & Noiseux (2026)](https://arxiv.org/abs/2604.05292) found that six industry static analysis tools combined flag only 7.6% of artifacts and miss 97.8% of formally proven vulnerabilities. The CI/CD enforcement layer that the [Suggestible Actor](/garden/suggestible-actor-properties/) post relies on (linters, type checks, static analyzers) catches a fraction of what [formal verification](/garden/structural-guardrails/) catches. This is not a configuration problem. It is a structural gap between pattern-based detection and property-based proof.
