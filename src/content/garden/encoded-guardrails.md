---
title: "Encoded Guardrails"
maturity: evergreen
tags: [guardrail-erosion, suggestible-actor, guardrail-taxonomy]
created: 2026-05-17
related_notes:
  - encoded-guardrails-suppress-symptoms
  - three-classes-of-guardrail-erosion-resistance
excerpt_text: >
  Encoded guardrails are guardrails encoded into the software lifecycle that the agent can modify in situ, within the same codebase it is already changing.
---
**Encoded guardrails are guardrails encoded into the software lifecycle that the agent can modify in situ, within the same codebase it is already changing.** Linters, [static analysis](/garden/static-analysis-insufficient-for-ai-code/), unit tests, integration tests, and regression tests all belong to this class. The agent responds to them because violations produce errors that block progress, and errors are the contextual feedback the [suggestible actor](/garden/suggestible-actor-properties/) is most susceptible to. But the agent can satisfy them trivially: delete a failing test, drop a precondition check, or suppress a linter warning. The error is gone. The vulnerability is not.
