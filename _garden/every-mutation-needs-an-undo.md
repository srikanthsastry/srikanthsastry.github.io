---
title: "Every Mutation Needs an Undo"
garden_type: note
maturity: evergreen
tags: [operations, scripts, software-engineering, safety]
created: 2026-04-27
related_posts:
  - /scripts-and-their-undo/
related_notes: []
excerpt_text: >
  When writing scripts that mutate the state of the world — deployments, replica changes, configuration updates — always build an undo mechanism alongside the forward operation.
---

When writing scripts that mutate the state of the world — deployments, replica changes, configuration updates — always build an undo mechanism alongside the forward operation.

The pressure to skip this is real: the forward path is the goal, the undo feels like defensive overhead. But when you need it (and you will), you need it *immediately* — under time pressure, during someone else's incident, with adrenaline compromising your judgment. A hastily improvised undo under those conditions is more likely to make things worse than better.

The practical rule: every mutation script should log the exact command(s) needed to reverse its effects. The undo doesn't need to be a separate script — it can be as simple as printing the inverse commands to stdout as the forward operations execute. What matters is that the reversal path exists and is tested *before* you need it.

This is a specific instance of a broader principle: any operation that changes system state should be designed for reversibility by default. The cost of building the undo is paid once; the cost of not having it is paid repeatedly and unpredictably.
