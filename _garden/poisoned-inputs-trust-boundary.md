---
title: "Supply-Chain Attacks Target AI Coding Tool Trust Boundaries"
garden_type: note
maturity: seedling
tags: [guardrail-erosion, supply-chain, suggestible-actor, trust-boundary]
created: 2026-04-27
related_posts: []
related_notes:
  - input-poisoning-as-third-vector
  - suggestible-actor-assumes-clean-inputs
  - supply-chain-attacks-targeting-ai-coding-tools-2026
excerpt_text: >
  Supply-chain attacks now explicitly target AI coding tool trust boundaries, poisoning the environment the agent operates in rather than exploiting the agent's reasoning.
---

**Supply-chain attacks now explicitly target AI coding tool trust boundaries, poisoning the environment the agent operates in rather than exploiting the agent's reasoning.** Compromised packages inject malicious payloads into agent responses mid-flight, harvest agent configurations alongside credentials, and self-propagate through stolen tokens. The attack surface is not the agent's logic but the inputs the agent trusts implicitly.
