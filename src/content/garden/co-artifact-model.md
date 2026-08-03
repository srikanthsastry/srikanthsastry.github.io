---
title: "Spec and Code as Co-Artifacts Stable Relative to Model"
maturity: budding
tags: [suggestible-actor, spec-driven-development, directive-gap, confabulation]
created: 2026-08-03
related_notes:
  - architecture-orphaning
  - directive-gap
  - directive-gap-hidden-by-confabulation
  - two-layer-governance-model
related_posts:
  - /the-hidden-directive-gap/
excerpt_text: >
  Spec alone is unstable across models; the pair (spec, code) is stable relative to a given model and harness.
---

**Spec alone is unstable across models; the pair (spec, code) is stable relative to a given model and harness.**

Spec-driven development converges where tests pass for M1. That point is not [directive-gap](/garden/directive-gap/) closed. It is M1's confabulations filling gaps in ways that align with intent: the [hidden directive gap](/garden/directive-gap-hidden-by-confabulation/). Treating (spec, code) as co-artifacts makes stability explicit and complements [two-layer-governance-model](/garden/two-layer-governance-model/). [architecture-orphaning](/garden/architecture-orphaning/) shows why specs cannot enforce this layer, so model upgrades become compiler upgrades that must re-validate existing behavior.
