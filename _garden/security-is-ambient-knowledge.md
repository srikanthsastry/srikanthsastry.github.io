---
title: "Security Is Ambient Knowledge the Suggestible Actor Cannot Access"
garden_type: note
maturity: evergreen
tags: [suggestible-actor, guardrail-erosion, security, ambient-knowledge, ai-code-quality]
created: 2026-04-26
related_posts: []
related_notes:
  - ambient-to-local (ambient to local conversion as core prescription)
  - class2-guardrails-suppress-symptoms
  - directive-gap (security awareness lives in the gap)
  - fu-copilot-security-weaknesses
  - guardrail-erosion (security vulns as fuel for the generation ratchet)
  - security-vuln-base-rate-undercount
  - suggestible-actor-properties (properties 2 and 3: locally reasoning, susceptible to local context)
excerpt_text: >
  AI coding agents produce security vulnerabilities at a steady base rate (~25-30%) that only decreases in response to explicit local feedback, confirming that security is ambient knowledge the suggestible actor cannot access unprompted.
---

**AI coding agents produce security vulnerabilities at a steady base rate (~25-30%) that only decreases in response to explicit local feedback, confirming that security is ambient knowledge the suggestible actor cannot access unprompted.** Fu et al. (TOSEM) analyzed 733 AI-generated code snippets from real GitHub repositories. 29.5% of Python and 24.2% of JavaScript snippets contained security weaknesses across 43 CWE categories, 8 in the Top-25. The distribution is broad, indicating general indifference to security properties rather than a localized blind spot. Copilot Chat fixes 55.5% of these issues when given static analysis warnings. Without the warnings, it produces the same vulnerabilities. The agent responds to local context but has no internal model of security.
