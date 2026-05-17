---
title: "Guardrail Erosion Is a Meta-Problem"
maturity: budding
tags: [guardrail-erosion, suggestible-actor, self-reinforcing]
created: 2026-04-24
related_notes:
  - three-classes-of-guardrail-erosion-resistance
  - review-is-the-bottleneck
excerpt_text: >
  AI agents erode the guardrails designed to constrain them through the same mechanisms those guardrails address.
---
**AI agents erode the guardrails designed to constrain them through the same mechanisms those guardrails address.** A hard boundary encoded as a compile-time check survives. A hard boundary encoded as a convention-enforcing code pattern does not, because the agent pattern-matches from other code rather than understanding why the pattern exists. The [suggestible actor](/garden/suggestible-actor-properties/) does not dismantle guardrails intentionally. It simply does not notice them when they are in its way.

This creates a self-reinforcing loop: guardrails erode, the codebase drifts toward the dominant pattern, and each successive agent iteration has less guardrail signal to learn from. The mechanism is analogous to Shumailov et al.'s [model collapse](/garden/oss-ouroboros-training-data-trap/) (Nature 2024): recursive training on generated data causes tails of the distribution to disappear, and guardrails are the tails.
