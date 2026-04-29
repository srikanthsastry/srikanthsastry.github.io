---
title: "The Agent's Context Boundary Is a Trust Boundary"
garden_type: note
maturity: budding
tags: [suggestible-actor, prompt-injection, security, trust-boundary]
created: 2026-04-28
related_posts: []
related_notes:
  - review-asymmetry-defeats-procedural-controls
  - suggestible-actor-as-attack-surface
excerpt_text: >
  Structural mitigation for the suggestible actor requires treating the agent's context boundary as a trust boundary.
---

**Structural mitigation for the suggestible actor requires treating the agent's context boundary as a trust boundary.** Inputs from untrusted sources must be sandboxed or stripped before entering the agent's context. This is the same architectural principle as the backstop layer: separate the verification surface from the execution surface. The agent cannot evaluate the trustworthiness of its own inputs. That evaluation must happen before the inputs reach the context window, not after the agent has already acted on them.
