---
title: "Review Asymmetry Defeats Procedural Controls for AI Output"
garden_type: note
maturity: budding
tags: [suggestible-actor, guardrail-erosion, code-review, review-bottleneck]
created: 2026-04-28
related_posts: []
related_notes:
  - context-window-is-trust-boundary
  - review-is-the-bottleneck
  - suggestible-actor-as-attack-surface
excerpt_text: >
  Procedural controls ("developers should review AI output") are insufficient because they recreate the review asymmetry problem.
---

**Procedural controls ("developers should review AI output") are insufficient because they recreate the review asymmetry problem.** The volume of agent output exceeds human review capacity, and the output looks plausible by construction. Telling developers to review AI-generated code assumes that the bottleneck (human attention) can scale with the throughput (machine generation). It cannot. This is the same structural problem that makes review the bottleneck in non-AI workflows, amplified by the generation speed of the agent.
