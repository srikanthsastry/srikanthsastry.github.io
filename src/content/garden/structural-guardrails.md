---
title: "Structural Guardrails"
maturity: evergreen
tags: [guardrail-erosion, suggestible-actor, guardrail-taxonomy]
created: 2026-05-17
related_notes:
  - static-analysis-insufficient-for-ai-code
  - three-classes-of-guardrail-erosion-resistance
excerpt_text: >
  Structural guardrails are guardrails woven into the structure of software development that cannot be modified in situ.
---
**Structural guardrails are guardrails woven into the structure of software development that cannot be modified in situ.** Changing them requires a significant change to the build and execution environment. Type systems, capability restrictions, formal verification, and property-based tests with human-authored properties all belong to this class. They enforce properties that must hold regardless of the path taken to satisfy them. The agent does not need to understand why the guardrail exists; it just needs to know that the goal cannot be accomplished without satisfying it. Structural guardrails are the only class whose enforcement mechanism does not depend on the agent's cooperation.
