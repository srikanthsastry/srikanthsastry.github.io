---
title: "Social Guardrails"
maturity: evergreen
tags: [guardrail-erosion, suggestible-actor, guardrail-taxonomy]
created: 2026-05-17
related_notes:
  - three-classes-of-guardrail-erosion-resistance
excerpt_text: >
  Social guardrails are conventions and patterns, documented or not, that form the social contract around which humans write software.
---
**Social guardrails are conventions and patterns, documented or not, that form the social contract around which humans write software.** Naming conventions, architectural patterns, code style norms, and implicit rules like "we never touch that module without talking to Alice first" all fall in this class. The [suggestible actor](/garden/suggestible-actor-properties/) sees traces of them in code patterns but treats them as weak signals: it pattern-matches the convention without understanding why it exists. Social guardrails erode too fast to be a reliable line of defense because the agent has no mechanism to distinguish a convention from an accident of history.
