---
title: "Cedar Expressiveness Decidability Tradeoff"
garden_type: note
maturity: budding
created: 2026-04-27
related_posts: []
related_notes:
  - backstop-layer-must-be-weaker
  - three-classes-of-guardrail-erosion-resistance
excerpt_text: >
  Cedar demonstrates the expressiveness-decidability tradeoff: a deliberately restricted authorization DSL that is analyzable by SMT solvers and provably consistent.
---

**Cedar demonstrates the expressiveness-decidability tradeoff: a deliberately restricted authorization DSL that is analyzable by SMT solvers and provably consistent.** Amazon's Cedar implements ABAC in a language that is not Turing-complete. The innovation is not the authorization model. It is the design pattern: move your invariants into a restricted, formally verifiable language that is separate from the codebase the agent modifies. For the guardrail erosion problem, guardrails that live in the same Turing-complete medium as the agent's work product are vulnerable to erosion. Guardrails in a separate, less expressive medium are resistant.
