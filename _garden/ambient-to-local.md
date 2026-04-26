---
title: "Convert Ambient Knowledge into Local Context"
garden_type: thought
maturity: budding
tags: [ai, software-design, prescriptions]
created: 2026-04-24
related_posts:
  - /the-suggestible-actor/
related_notes:
  - directive-gap
  - suggestible-actor-properties
  - susceptibility-peaks-at-failure
  - friction-requires-intent
excerpt_text: >
  The core design principle for the suggestible actor: convert ambient knowledge into local context.
  Human developers carry implicit knowledge the AI agent cannot access. Make it explicit and local.
---

The core design principle for the [suggestible actor](/garden/suggestible-actor-properties/): convert ambient knowledge into local context. Human developers carry ambient knowledge — org norms, conventions, institutional history, an understanding of *why* the system is structured the way it is — that the AI agent cannot access. Making that knowledge explicit and local is how you steer an actor that has no judgment and no cultural awareness.

This means: inline comments adjacent to the code the agent will modify. Docstrings on the functions it will call. Unit test failure messages that tell the agent what to do, not just what went wrong. READMEs precise enough for the agent to follow step by step. `AGENTS.md` files that encode the ambient knowledge a human developer would carry. Project templates, linters, and consistent directory structure that encode convention at the tooling level.

[Ergonomic friction](/garden/friction-requires-intent/) relies on the actor to interpret signals. The suggestible actor cannot. So instead of making incorrect behavior uncomfortable, make the correct behavior locally available at the exact point where the agent will look for it. Close the [directive gap](/garden/directive-gap/) by putting the answer where the question will be asked.
