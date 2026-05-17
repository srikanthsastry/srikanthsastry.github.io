---
title: "Three Dimensions of Erosion Resistance Allocation"
maturity: budding
tags: [guardrail-erosion, risk-framework, decision-theory]
created: 2026-05-17
related_notes:
  - expected-damage-severity-times-mitigation
  - three-classes-of-guardrail-erosion-resistance
excerpt_text: >
  Risk tolerance, feedback latency, and deployment reversibility are decomposed proxies of expected damage, and they tend to correlate.
---
**Risk tolerance, feedback latency, and deployment reversibility are decomposed proxies of expected damage, and they tend to correlate.** Risk tolerance approximates severity. Feedback latency and deployment reversibility together approximate time to mitigation. The priority ordering follows from the decomposition: severity first (if it is low, the product is small regardless), then the two components of time to mitigation.

These dimensions are not independent. The core of most systems (the "secret sauce") clusters at low risk tolerance, slow detection, and hard rollback. The top of the stack (UI layers, internal tools, prototypes) clusters at the opposite end. This correlation simplifies allocation: invest structural guardrails and heavy human review in the core, strengthen encoded guardrails in the middle tier, and rely on monitoring with fast rollback at the top.
