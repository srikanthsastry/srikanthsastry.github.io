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

**The decision/execution boundary that directive governance depends on does not exist in software.** In manufacturing, you do the same thing repeatedly. The design decision was already made, and execution follows a spec. Micro-decisions on the line (torque adjustments, material variations) are local and ephemeral; they don't compound.

In software, everything you build is new. If it weren't new, you'd just call the API that already does it. Every act of writing code is a design decision: choosing an abstraction, designing an interface, decomposing a system. No spec can fully predetermine these choices because [essential complexity](/garden/essential-complexity-makes-software-ungovernable/) (Brooks) can't be fully specified.

And critically, **software decisions compound.** Every abstraction choice constrains every future choice built on top of it. A manufacturing micro-decision lives and dies in the moment. A software decision lives on in the codebase and influences all future software that builds on it. The center can't centralize what it can't see, and it can't see what's embedded in the act of writing code. But those invisible decisions are shaping the company's technical future.
