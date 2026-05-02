---
title: "Convert Ambient Knowledge into Local Context"
maturity: evergreen
tags: [ai, software-design, prescriptions]
created: 2026-04-24
related_posts:
  - /the-suggestible-actor/
related_notes:
  - confabulation-is-plausible
  - directive-gap
  - friction-requires-intent
  - suggestible-actor-properties
  - susceptibility-peaks-at-failure
excerpt_text: >
  The core design principle for the suggestible actor: convert ambient knowledge into local context.
---

**The core design principle for the suggestible actor: convert ambient knowledge into local context.** Human developers carry implicit knowledge (org norms, conventions, institutional history) that the AI agent cannot access. Making that knowledge explicit and local is how you steer an actor that has no judgment.

This means: inline comments adjacent to the code the agent will modify, docstrings on the functions it will call, unit test failure messages that tell the agent what to do, `AGENTS.md` files that encode ambient knowledge, and project templates that encode convention at the tooling level. Close the [directive gap](/garden/directive-gap/) by putting the answer where the question will be asked.
