---
title: "In Software, Execution Is Decision-Making"
garden_type: note
maturity: evergreen
tags: [governance, software-engineering, directive-governance, separability]
created: 2026-04-25
related_posts:
  - /cargo-cult-governance/
related_notes:
  - three-assumptions-framework
  - essential-complexity-makes-software-ungovernable
excerpt_text: >
  The decision/execution boundary that directive governance depends on does not exist in software. Every act of building code is a design decision, and software decisions compound.
---

**The decision/execution boundary that directive governance depends on does not exist in software.** In manufacturing, the design decision was already made, and execution follows a spec. Micro-decisions on the line are local and ephemeral.

In software, everything you build is new. Every act of writing code is a design decision: choosing an abstraction, designing an interface, decomposing a system. And software decisions compound. Every abstraction choice constrains every future choice built on top of it. The center cannot centralize what is embedded in the act of writing code.
