---
title: "Class 2 Guardrails Suppress Symptoms Without Addressing the Cause"
garden_type: note
maturity: budding
tags: [suggestible-actor, guardrail-erosion, security, guardrail-taxonomy]
created: 2026-04-26
related_posts: []
related_notes:
  - guardrail-erosion
  - security-is-ambient-knowledge
  - security-vuln-base-rate-undercount
excerpt_text: >
  Static analysis warnings are Class 2 guardrails: they reduce the vulnerability rate when present, but the agent satisfies them reactively without internalizing the principle.
---

**Static analysis warnings are Class 2 guardrails: they reduce the vulnerability rate when present, but the agent satisfies them reactively without internalizing the principle.** The moment the warning is absent (new code path, new CWE category, edge case the tool does not cover), the base rate reasserts itself. Class 2 guardrails suppress symptoms. They do not address the cause, which is the absence of ambient security knowledge in the agent's reasoning. This is the fundamental limitation of tool-enforced guardrails for the suggestible actor: compliance without understanding.
