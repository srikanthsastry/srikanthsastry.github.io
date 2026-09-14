---
title: "Language design philosophies embed assumptions about who writes the code"
maturity: budding
tags: [programming-languages, suggestible-actor, structural-guardrails, design-philosophy]
created: 2026-05-22
related_notes:
  - deterministic-checkers
  - patterns-as-enforceable-types
  - structural-guardrails
  - suggestible-actor-properties
  - three-classes-of-guardrail-erosion-resistance
related_posts:
  - /the-consenting-adults-problem/
excerpt_text: >
  Language design philosophies embed assumptions about who is writing the code.
---

**Language design philosophies embed assumptions about who is writing the code. The LLM era breaks the assumption that underlies permissive languages.**

Python's design philosophy is "we're all consenting adults here." That philosophy assumes the person writing the code understands the consequences. The suggestible actor does not understand consequences. It is not a consenting adult.

"Consenting adults" assumes human judgment. "Make illegal states unrepresentable" (Rust, Haskell) assumes no judgment. The LLM era validates the second philosophy because the assumption the first rests on no longer holds.

The structural guardrail defense depends on languages with nominal typing: Rust, Java, Haskell. The languages where LLM-assisted development is most prevalent (Python, JavaScript, TypeScript) have structural typing, weak encapsulation, or no static types. This is not a gap in the structural guardrail thesis. It is a prediction: as autonomous code generation scales, the languages that assume a competent human author will be at a structural disadvantage for maintaining architectural coherence.

Related: [suggestible-actor-properties](/garden/suggestible-actor-properties/), [structural-guardrails](/garden/structural-guardrails/), [three-classes-of-guardrail-erosion-resistance](/garden/three-classes-of-guardrail-erosion-resistance/)
