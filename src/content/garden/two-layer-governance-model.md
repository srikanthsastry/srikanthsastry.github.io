---
title: "Two-Layer Governance Model"
maturity: budding
tags: [software-architecture, AI, spec-driven-development]
created: 2026-05-23
related_notes:
  - architecture-orphaning
  - behavioral-vs-architectural-coherence-tests
  - directive-gap
  - directive-gap-hidden-by-confabulation
  - review-is-the-bottleneck
  - structural-guardrails
  - suggestible-actor-properties
related_posts:
  - /the-hidden-directive-gap/
  - /the-architecture-orphaning-problem-with-ai-agents/
excerpt_text: >
  AI-assisted software development requires two distinct, complementary layers of governance: iterative spec convergence and architectural coherence.
---

**AI-assisted software development requires two distinct, complementary layers of governance: iterative spec convergence and architectural coherence.** Neither substitutes for the other.

Iterative specification convergence (the spec layer) handles functional correctness. The human iterates on the spec; the LLM regenerates; verification narrows the directive gap. This is what Spec-Driven Development does at its best.

Structural guardrails (the implementation layer) handle architectural coherence. Enforcement mechanisms constrain implementation in ways not expressible at the spec level. They change slowly and require high human investment, but that investment is amortized over the lifetime of the architecture.

Convergence verifies "does this code do what the spec says?" Structural guardrails verify "does this code respect the system's architectural constraints?" The spec cannot enforce architecture through its test pipeline without collapsing the abstraction, and structural guardrails cannot close the directive gap.
