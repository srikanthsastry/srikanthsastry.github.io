---
title: "Behavioral Tests vs. Architectural Coherence Tests"
maturity: evergreen
tags: [software-architecture, AI, testing]
created: 2026-05-23
related_notes: []
related_posts:
  - /the-architecture-orphaning-problem-with-ai-agents/
excerpt_text: >
  Behavioral tests and architectural coherence tests serve different governance layers and should not be conflated.
---

**Behavioral tests and architectural coherence tests serve different governance layers and should not be conflated.** Both produce tests, but they verify different properties.

Behavioral tests (e.g., "given valid credentials, return 200") pass as long as the behavior is satisfied regardless of *how* it is satisfied. They are derived from the spec and verify functional correctness.

Architectural coherence tests verify structure. The test "the system calls the auth module with this payload" fails if the code reimplements auth inline. This test is derived from the architecture document, not the spec. It encodes a structural decision as a test constraint: a structural guardrail expressed as a test.

To qualify as a structural guardrail, an architectural coherence test needs two components: an enforcement mechanism (violations produce errors the agent cannot suppress) and a scope boundary (the test lives in infrastructure the agent cannot modify).
