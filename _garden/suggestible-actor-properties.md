---
title: "The Suggestible Actor: Four Properties"
garden_type: thought
maturity: seedling
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
excerpt_text: >
  The suggestible actor is defined by four properties: goal-oriented, locally reasoning, susceptible to local
  context, and confabulates under uncertainty. Confabulation is the convergent failure mode of the other three.
---

The suggestible actor model describes how AI coding agents actually behave when operating in a codebase. It is defined by four properties:

1. **Goal-oriented.** The actor has a goal, externally set by the human who dispatched it. This is not the same as [intent](/garden/goal-vs-intent/) — it has a target but no motivation, no values, no comprehension of what it is pointed at or why.

2. **Locally reasoning.** The actor reasons only over what is immediately available: the contents of its context window, the file it is modifying, the output of the last command it ran. Global invariants and architectural constraints outside its immediate context do not factor into its decisions.

3. **Susceptible to local context.** Every input the agent receives during execution influences its subsequent behavior. This susceptibility is not uniform — it [peaks at the point of failure](/garden/susceptibility-peaks-at-failure/), making error messages and failure outputs the primary design lever.

4. **Confabulates under uncertainty.** When local context is insufficient, the agent does not stop and request clarification. It [confabulates](/garden/confabulation-is-plausible/): it generates a plausible structure and proceeds as if that structure were real.

Confabulation is the convergent failure mode of the other three. The agent must produce something (goal-oriented), can only draw from what's nearby (locally reasoning), and pattern-matches from whatever is available (susceptible to local context). When the [directive gap](/garden/directive-gap/) is wide, the result is plausible-looking wrongness.
