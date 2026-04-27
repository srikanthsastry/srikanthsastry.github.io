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
  Every script that mutates system state should build an undo alongside the forward operation.
---

**Every script that mutates system state should build an undo alongside the forward operation.** The pressure to skip this is real — the forward path is the goal, the undo feels defensive. But when you need it, you need it *immediately*: under time pressure, during someone else's incident, with adrenaline compromising your judgment. A hastily improvised undo under those conditions makes things worse.

The practical rule: every mutation script should log the exact commands needed to reverse its effects — even just printing inverse commands to stdout as the forward operations execute. The cost of building the undo is paid once; the cost of not having it is paid repeatedly and unpredictably.
