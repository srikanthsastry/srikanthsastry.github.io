---
title: "Directive gap closure is indistinguishable from aligned confabulation"
maturity: budding
tags: [suggestible-actor, spec-driven-development, directive-gap, confabulation]
created: 2026-05-22
related_notes:
  - co-artifact-model
  - confabulation-is-plausible
  - directive-gap
  - reverse-pass-observer
  - suggestible-actor-properties
  - two-layer-governance-model
related_posts:
  - /the-hidden-directive-gap/
excerpt_text: >
  When iterating on a spec, convergence against a model's confabulation pattern is indistinguishable from convergence against intent.
---

**When iterating on a spec, convergence against a model's confabulation pattern is indistinguishable from convergence against intent.**

The directive gap between spec and intent never fully closes — it goes *invisible* when the model's confabulation happens to fill the remaining gaps in ways that match the author's intent. The author stops iterating because the tests pass, not because the spec is complete. The convergence is real but fragile: it is convergence against *this model's* confabulation pattern, not against a model-independent specification.

When the model changes, different confabulations fill the same gaps differently. Tests break. The directive gap reappears. The spec feels "model-relative" (Wasowski's observation), but the instability was always there — the prior model's confabulations were masking it.

This explains why Wasowski found that one executable test survived four model generations while a 1,500-word spec needed reinterpretation each time: the test encodes behavior formally (model-independent), while the spec relies on the model to fill directive gaps (model-dependent).

Implication: SDD's convergence criterion is wrong. "Tests pass" is necessary but not sufficient — it conflates "the spec is complete" with "the model's confabulations happen to align with intent." A truly complete spec would survive model changes. The gap between those two states is the hidden directive gap.

Potential follow-up post to Act 3. The compiler analogy: imagine if every compiler release changed which language features it supported, so source code needed rewriting each time. That's what model-relative specs feel like — but the instability is in the spec's incompleteness, not in the model.

Related: [suggestible-actor-properties](/garden/suggestible-actor-properties/), [confabulation-is-plausible](/garden/confabulation-is-plausible/), [directive-gap](/garden/directive-gap/)
