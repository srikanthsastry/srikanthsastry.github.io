---
title: "The Directive Gap"
maturity: evergreen
tags: [ai, software-design, failure-modes]
created: 2026-04-24
related_posts:
  - /the-suggestible-actor/
related_notes:
  - ambient-to-local
  - confabulation-is-plausible
  - suggestible-actor-properties
  - susceptibility-peaks-at-failure
excerpt_text: >
  The directive gap is the distance between the human's goal (with all their ambient knowledge) and the context actually available to the agent during execution.
---

**The directive gap is the distance between the human's goal (with all their ambient knowledge) and the context actually available to the agent during execution.** The human who said "implement feature X" had knowledge about the codebase, conventions, and likely obstacles that was never made local. This gap is the root cause of most suggestible-actor failures. When it is wide, the agent [confabulates](/garden/confabulation-is-plausible/).

Every prescription for the [suggestible actor](/garden/suggestible-actor-properties/) (actionable error messages, hard boundaries with signposts, documentation as local context, CI/CD gates that report remediation) is a strategy for closing this gap. The core principle is to [convert ambient knowledge into local context](/garden/ambient-to-local/): make explicit what the human developer would have carried implicitly.
