---
title: "The Suggestible Actor: Four Properties"
garden_type: thought
maturity: budding
tags: [ai, software-design, actor-models, suggestible-actor]
created: 2026-04-24
related_posts:
  - /the-suggestible-actor/
related_notes:
  - intent-spectrum
  - ai-agent-category-error
  - goal-vs-intent
  - directive-gap
  - confabulation-is-plausible
  - susceptibility-peaks-at-failure
  - ambient-to-local
  - friction-requires-intent
excerpt_text: >
  The suggestible actor is defined by four properties: goal-oriented, locally reasoning, susceptible to local
  context, and confabulates under uncertainty. Confabulation is the convergent failure mode of the other three.
---

**The suggestible actor is defined by four properties that together predict its failure modes.**

1. **Goal-oriented.** The actor has a target but no motivation, no values, no comprehension of what it is pointed at or why.
2. **Locally reasoning.** The actor reasons only over what is immediately available in its context window.
3. **Susceptible to local context.** Every input during execution influences subsequent behavior, with [susceptibility peaking at failure](/garden/susceptibility-peaks-at-failure/).
4. **Confabulates under uncertainty.** When local context is insufficient, the agent generates plausible structure and proceeds as if it were real.

Confabulation is the convergent failure mode: the agent must produce something (goal-oriented), can only draw from what is nearby (locally reasoning), and pattern-matches from whatever is available (susceptible). When the [directive gap](/garden/directive-gap/) is wide, the result is plausible-looking wrongness.
