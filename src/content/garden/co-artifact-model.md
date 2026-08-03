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

Spec-Driven Development converges to a fixed point where tests pass for a given model M1. That fixed point is not "directive gap closed" but "M1's confabulations fill remaining gaps in ways that happen to align with intent" — the [hidden directive gap](/garden/directive-gap-hidden-by-confabulation/).

Treating (spec, code) as co-artifacts makes the stability explicit. Both are committed. For constant M1, the reverse pass observer says "conforms." When model changes to M2, (spec, code) may no longer be stable. The co-artifact evolution is `(spec, code) → (spec, code, deviations, model) → (spec', code')`. This reframes model upgrades as compiler upgrades: existing correct behavior must be re-validated against the new interpreter.

This is the complement to [two-layer governance](/garden/two-layer-governance-model/): spec layer governs functional correctness, co-artifact stability governs model-relative interpretation.

Related: [directive-gap](/garden/directive-gap/), [architecture-orphaning](/garden/architecture-orphaning/)
