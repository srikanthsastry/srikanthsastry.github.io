---
title: "Hallucination Is a Mathematical Inevitability"
maturity: evergreen
tags: [suggestible-actor, hallucination, formal-proof, autoregressive-models]
created: 2026-05-17
related_notes:
  - guardrail-erosion-meta-problem
  - suggestible-actor-properties
excerpt_text: >
  Hallucination in autoregressive language models is a proven mathematical limitation, not an engineering problem awaiting a fix.
---
**Hallucination in autoregressive language models is a proven mathematical limitation, not an engineering problem awaiting a fix.** Xu et al. (2024) use computability theory to show that LLMs cannot learn all computable functions, making hallucination inevitable regardless of scale, training data, or architecture. This is not a "we haven't solved it yet" result. It is a formal impossibility proof: no autoregressive model can guarantee freedom from hallucination.

This matters for [guardrail erosion](/garden/guardrail-erosion-meta-problem/) because hallucination is one of the four [suggestible actor](/garden/suggestible-actor-properties/) properties. If it cannot be eliminated, the erosion dynamics that follow from it cannot be eliminated either. A more capable model hallucinates differently, not less.
