---
title: "Suggestible Actor Assumes Clean Inputs"
garden_type: note
maturity: seedling
tags: [guardrail-erosion, supply-chain, suggestible-actor, assumptions]
created: 2026-04-27
related_posts: []
related_notes:
  - poisoned-inputs-trust-boundary
excerpt_text: >
  The suggestible actor model silently assumes clean inputs from the toolchain.
---

**The suggestible actor model silently assumes clean inputs from the toolchain.** The prescriptions (explicit intent, local guardrails, human backstop) all assume the agent receives uncompromised data from its environment. That assumption is no longer safe. If the packages, documentation, or context the agent consumes are themselves poisoned, every downstream guardrail operates on corrupted foundations.
