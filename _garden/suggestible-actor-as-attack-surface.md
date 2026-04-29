---
title: "The Suggestible Actor as Attack Surface"
garden_type: note
maturity: budding
tags: [suggestible-actor, directive-gap, prompt-injection, confused-deputy, guardrail-erosion]
created: 2026-04-28
related_posts: []
related_notes:
  - context-window-is-trust-boundary
  - review-asymmetry-defeats-procedural-controls
excerpt_text: >
  The suggestible actor is a confused deputy: it has legitimate credentials and access but no capacity to distinguish trusted context from poisoned context.
---

**The suggestible actor is a confused deputy: it has legitimate credentials and access but no capacity to distinguish trusted context from poisoned context.** An attacker does not need to breach the system directly. They place malicious instructions where the agent will encounter them (a GitHub Issue, a code comment, a documentation file), and the agent executes them faithfully. The agent's susceptibility to local context, the very property that makes it steerable for good, is the same property that makes it steerable for harm. Every input channel to the agent's context window is an attack surface.
