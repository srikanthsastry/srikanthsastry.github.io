---
title: "Architecture Orphaning"
maturity: budding
tags: [software-architecture, AI, suggestible-actor]
created: 2026-05-23
related_notes: []
related_posts:
  - /the-hidden-directive-gap/
  - /the-architecture-orphaning-problem-with-ai-agents/
excerpt_text: >
  Architecture orphaning is the phenomenon where architectural decisions fall between layers that neither specs nor AI agents can govern.
---

**Architecture orphaning is the phenomenon where architectural decisions fall between layers that neither specs nor AI agents can govern.** A spec describes *what* the system should do; behavioral tests derived from specs verify functional correctness. But architectural constraints (which library to use, which boundaries to respect, which service owns which responsibility) are not enforceable through the spec-to-test pipeline. The test "given valid credentials, return 200" passes whether the code calls the shared auth library or reimplements auth logic inline.

The AI agent cannot fill this gap either. Architecture is system-level and non-local; the suggestible actor reasons locally. The result: architecture becomes an orphaned layer, too low for the spec, too high for the locally reasoning agent.
