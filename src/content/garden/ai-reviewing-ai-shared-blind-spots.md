---
title: "AI Reviewing AI: Shared Blind Spots"
maturity: evergreen
tags: [guardrail-erosion, ai-review, blind-spots, model-collapse]
created: 2026-04-24
related_notes:
  - guardrail-erosion-meta-problem
  - review-is-the-bottleneck
  - three-classes-of-guardrail-erosion-resistance
excerpt_text: >
  AI models reviewing AI-generated code share systematic blind spots with the generator, creating gaps that neither side detects.
---
**AI models reviewing AI-generated code share systematic blind spots with the generator, creating gaps that neither side detects.** [Blain & Noiseux (2026)](https://arxiv.org/abs/2604.05292) show models detect their own vulnerabilities 78.7% of the time in review mode but generate them 55.8% by default. This suggests AI code review can partially close the review gap. Google (AIware '24) and Meta (TestGen-LLM) are investing heavily in this direction.

But if the reviewer model is trained on similar data as the generator, the review itself has systematic gaps. The models do not know what they do not know, and neither does the reviewer. This is the epistemic equivalent of [model collapse](/garden/oss-ouroboros-training-data-trap/) applied to the review pipeline.
