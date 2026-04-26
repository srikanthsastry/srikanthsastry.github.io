---
title: "Confabulation Is Plausible"
garden_type: thought
maturity: budding
tags: [ai, failure-modes, hallucination]
created: 2026-04-24
related_posts:
  - /the-suggestible-actor/
related_notes:
  - suggestible-actor-properties
  - directive-gap
  - susceptibility-peaks-at-failure
  - ambient-to-local
excerpt_text: >
  AI agent confabulation is not random. It is plausible-looking wrongness — output constructed from pattern
  and proximity rather than knowledge. The danger is not that these errors are spectacular; it is that they
  look correct.
---

AI agent confabulation is not random. It is plausible-looking wrongness: output constructed from pattern and proximity rather than knowledge. It fits the shape of what should be there. This makes confabulation harder to detect than obvious failures, precisely because the output looks correct. The failure mode is not garbage; it is convincing fiction.

This is the convergent failure mode of the [suggestible actor's](/garden/suggestible-actor-properties/) other three properties. The agent is goal-oriented (so it must produce *something*), locally reasoning (so it draws only from what's nearby), and susceptible to local context (so it pattern-matches from whatever is available). When the [directive gap](/garden/directive-gap/) is wide and local context is insufficient, the agent fills the void with plausible structure — a call to an API that does not exist, a convention that was never established, a security bypass that "should work based on the patterns in this codebase."
