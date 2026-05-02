---
title: "Susceptibility Peaks at Failure"
maturity: budding
tags: [ai, software-design, design-levers]
created: 2026-04-24
related_posts:
  - /the-suggestible-actor/
related_notes:
  - ambient-to-local
  - confabulation-is-plausible
  - directive-gap
  - suggestible-actor-properties
excerpt_text: >
  An AI agent's susceptibility to local context peaks at the point of failure.
---

**An AI agent's susceptibility to local context peaks at the point of failure.** Susceptibility is lowest when the agent has momentum and highest when the current approach has failed and no obvious alternative is available. Guidance placed at failure points has outsized influence on the agent's behavior.

Error messages become the primary control surface. The difference between `403 Forbidden` and `403 Forbidden: identity 'svc-deploy' lacks 'write:documents' scope` is the difference between an agent that routes around your authorization system and one that follows the correct path. The agent will ignore your README when it has momentum. It will read your error message when it is stuck.
