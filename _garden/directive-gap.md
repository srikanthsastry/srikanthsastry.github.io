---
title: "The Directive Gap"
garden_type: thought
maturity: seedling
tags: [ai, software-design, failure-modes]
created: 2026-04-24
related_posts:
  - /the-suggestible-actor/
related_notes:
  - confabulation-is-plausible
  - ambient-to-local
  - suggestible-actor-properties
  - susceptibility-peaks-at-failure
excerpt_text: >
  The distance between the human's goal — with all their ambient knowledge — and the context actually
  available to the agent during execution. This gap is the root cause of most suggestible-actor failures.
---

The directive gap: the distance between the human's goal (with all their ambient knowledge) and the context actually available to the agent during execution. The human who said "implement feature X" had knowledge about the codebase, conventions, and likely obstacles that was never made local. This gap is the root cause of most suggestible-actor failures. When it is wide, the agent [confabulates](/garden/confabulation-is-plausible/).

Every prescription for the suggestible actor — actionable error messages, hard boundaries with signposts, documentation as local context, CI/CD gates that report remediation — is a strategy for closing this gap. The core principle is to [convert ambient knowledge into local context](/garden/ambient-to-local/): make explicit what the human developer would have carried implicitly.
