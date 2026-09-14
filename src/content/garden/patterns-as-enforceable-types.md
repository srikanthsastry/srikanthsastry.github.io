---
title: "Patterns as Enforceable Types"
maturity: budding
tags: [type-systems, suggestible-actor, structural-guardrails, rust]
created: 2026-09-14
related_notes:
  - consenting-adults-language-philosophy
  - deterministic-checkers
  - structural-guardrails
  - suggestible-actor-properties
  - three-classes-of-guardrail-erosion-resistance
related_posts:
  - /the-consenting-adults-problem/
excerpt_text: >
  Narrow the type until the disallowed state cannot be written.
---

**Narrow the type until the disallowed state cannot be written.**

Encoding allowed patterns as types turns violations into compile errors instead of judgment calls. An enum of supported browsers has no variant for an unsupported one, so there is nothing to construct. The unsupported shape has no type to pass. Newtyped IDs make swapping a user ID for an order ID a type error the compiler catches. Typestate makes invalid lifecycle transitions unrepresentable: no method exists for the illegal transition, so it cannot be written.

Each step shrinks the suggestible actor's lie space. The model can only call transitions that exist. This is token narrowing at the type level: the decoder's scope is pruned by construction, not by instruction. It does not give the agent conceptual integrity. It reduces the space in which the agent can lie.

This is the second tower of governance before model, alongside [deterministic checkers](/garden/deterministic-checkers/) that live outside the agent's write path.

Related: [structural-guardrails](/garden/structural-guardrails/), [consenting-adults-language-philosophy](/garden/consenting-adults-language-philosophy/), [suggestible-actor-properties](/garden/suggestible-actor-properties/), [deterministic-checkers](/garden/deterministic-checkers/)
