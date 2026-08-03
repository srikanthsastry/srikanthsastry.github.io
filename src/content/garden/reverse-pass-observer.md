---
title: "Reverse-Pass Observer Role"
maturity: budding
tags: [suggestible-actor, spec-driven-development, evaluation, erosion-resistance]
created: 2026-08-03
related_notes:
  - co-artifact-model
  - confabulation-is-plausible
  - directive-gap-hidden-by-confabulation
  - suggestible-actor-properties
related_posts:
  - /the-hidden-directive-gap/
excerpt_text: >
  Using the AI model as observer that describes deviations rather than judge that declares conformance.
---

**Using the AI model as observer that describes deviations rather than judge that declares conformance.**

After forward-pass convergence (spec → code → tests pass), run a reverse pass: ask the model "does this code implement this spec, and what deviations do you see?" First time, deviations are null by construction.

The observer role matters because of [suggestible actor properties](/garden/suggestible-actor-properties/): goal-oriented actors produce output satisfying the goal. Prompting for "deviations" biases toward finding them (completion bias). Framing as observation with receipts — "spec says X; code does Y" — makes interpretation visible, compared to collapsing to yes/no judgment. The receipt is the value, not absence of judgment.

On model upgrade M1→M2, run reverse pass before new development. M2's deviations are hidden directive gap made visible. Triage: material deviations → refine spec + regenerate; incidental/preference deviations → append to spec to prevent churn. Union of observations across models grows monotonically; so does noise floor — signal-to-noise depends on confabulation rates.

This is [confabulation](/garden/confabulation-is-plausible/) applied to evaluation itself: observation confabulates too. False positives are cheap individually but costly in aggregate when 5 models × 2 directions × N modules produces hundreds to triage.

Related: [co-artifact-model](/garden/co-artifact-model/), [directive-gap-hidden-by-confabulation](/garden/directive-gap-hidden-by-confabulation/)
