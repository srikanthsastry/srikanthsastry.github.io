---
title: "Expected Damage: Severity Times Time to Mitigation"
maturity: budding
tags: [guardrail-erosion, risk-framework, decision-theory]
created: 2026-05-17
related_notes:
  - three-classes-of-guardrail-erosion-resistance
  - three-dimensions-of-erosion-resistance-allocation
excerpt_text: >
  The ideal metric for guardrail investment is expected damage: severity multiplied by time to mitigation.
---
**The ideal metric for guardrail investment is expected damage: severity multiplied by time to mitigation.** A catastrophic failure detected in seconds may cause less total damage than a minor failure that silently accumulates for months. The product of the two is what matters, not either factor alone.

In practice, neither factor is directly computable. Severity depends on context, downstream dependencies, and failure modes that may not be enumerable. Time to mitigation depends on detection latency and rollback cost, both of which vary by deployment model. Because the ideal metric is uncomputable, you decompose it into assessable proxies: risk tolerance, feedback latency, and deployment reversibility.
