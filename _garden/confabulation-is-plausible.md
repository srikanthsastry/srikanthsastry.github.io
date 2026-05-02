---
title: "Confabulation Is Plausible"
garden_type: note
maturity: budding
tags: [ai, failure-modes, hallucination]
created: 2026-04-24
related_posts:
  - /the-suggestible-actor/
related_notes:
  - ambient-to-local
  - directive-gap
  - suggestible-actor-properties
  - susceptibility-peaks-at-failure
excerpt_text: >
  AI agent confabulation is not random — it is plausible-looking wrongness constructed from pattern and proximity rather than knowledge.
---

**AI agent confabulation is not random — it is plausible-looking wrongness constructed from pattern and proximity rather than knowledge.** The failure mode is not garbage; it is convincing fiction.

This is the convergent failure mode of the [suggestible actor](/garden/suggestible-actor-properties/)'s other three properties. The agent is goal-oriented (so it must produce *something*), locally reasoning (so it draws only from what's nearby), and susceptible to local context (so it pattern-matches from whatever is available). When the [directive gap](/garden/directive-gap/) is wide and local context is insufficient, the agent fills the void with plausible structure: a call to an API that does not exist, a convention that was never established, a security bypass that "should work based on the patterns in this codebase."
