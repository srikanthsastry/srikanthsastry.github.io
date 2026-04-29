---
title: "Ai Reviewing Ai Shared Blind Spots"
garden_type: note
maturity: budding
tags: [guardrail-erosion, ai-review, blind-spots, model-collapse]
created: 2026-04-24
related_posts: []
related_notes:
  - review-is-the-bottleneck
  - three-classes-of-guardrail-erosion-resistance
excerpt_text: >
  AI models reviewing AI-generated code share systematic blind spots with the generator, creating gaps that neither side detects.
---

**AI models reviewing AI-generated code share systematic blind spots with the generator, creating gaps that neither side detects.** Blain's data shows models detect their own vulnerabilities 78.7% of the time in review mode but generate them 55.8% by default. This suggests AI code review can partially close the review gap. Google (AIware '24) and Meta (TestGen-LLM) are investing heavily in this direction.

But if the reviewer model is trained on similar data as the generator, the review itself has systematic gaps. The models do not know what they do not know, and neither does the reviewer. This is the epistemic equivalent of model collapse applied to the review pipeline.
