---
title: "Survival vs. Excellence as Engineering Modes"
garden_type: note
maturity: evergreen
tags: [software-engineering, engineering-culture, tech-debt, decision-making]
created: 2026-04-27
related_posts:
  - /are-you-building-for-survival-or-excellence/
  - /when-should-you-build-for-survival/
related_notes: []
excerpt_text: >
  Software development approaches fall into two distinct modes: building for survival and building for excellence (success).
---

Software development approaches fall into two distinct modes: **building for survival** and **building for excellence** (success). The mode should be a deliberate choice driven by circumstances, not a default driven by developer temperament.

## Building for survival

Optimize for speed to a specific outcome. Sacred deadlines, end-to-end functionality for a single use case, "get things done by hook or crook." Every shortcut accrues tech debt with compounding interest. What you get: you survive. What you don't get: a path forward, reusable components, or understanding of the broader solution space.

Indicators: deadlines are non-negotiable, specific use cases matter more than "doing it right," the end product matters more than the process.

## Building for excellence

Deliberate, decomposition-driven development. Understand the problem space before executing. Tease apart essential vs. incidental complexity. Build composable abstractions where writing code becomes routine and the innovation is in composition across abstraction layers.

What you get: reusable components, ability to pivot, parallelizable development, improved bus factor. What you don't get: a quick start. Risk: analysis paralysis.

## When to choose survival

1. **Resource-constrained and failure is acceptable** — limited runway, no room to renegotiate
2. **High environmental uncertainty** — experimental tech, nascent problem spaces, customers who "know it when they see it"
3. **Stakeholder risk is lower than your survival risk** — but *never* when stakeholders bear existential risk (e.g., medical software)
4. **Solving a genuinely one-time problem** — but ensure the code actually gets discarded afterward

The critical nuance: the choice is rarely binary. You can almost always negotiate on deadlines, scope, resources, or expectations. Without considering negotiation, the survival-vs-excellence framing is incomplete.
