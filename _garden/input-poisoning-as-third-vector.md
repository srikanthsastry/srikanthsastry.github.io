---
title: "Input Poisoning As Third Vector"
garden_type: note
maturity: seedling
tags: [guardrail-erosion, supply-chain, degradation-vectors]
created: 2026-04-27
related_posts: []
related_notes:
  - guardrail-erosion-meta-problem
  - poisoned-inputs-trust-boundary
  - review-is-the-bottleneck
excerpt_text: >
  Input poisoning is a third degradation vector alongside the generation ratchet and the exploitation ratchet.
---

**Input poisoning is a third degradation vector alongside the generation ratchet and the exploitation ratchet.** The generation ratchet: degraded code enters the codebase and becomes context for future generation, compounding quality loss. The exploitation ratchet: low-severity bugs chain into high-severity exploits. Input poisoning: the environment the agent reads from is corrupted before the agent even begins. The two-layer architecture (human backstop / agent execution) does not address it because the corruption happens below the layer the human monitors.
