---
title: "Deterministic Checkers"
maturity: budding
tags: [guardrail-erosion, suggestible-actor, structural-guardrails, build-systems]
created: 2026-09-14
related_notes:
  - consenting-adults-language-philosophy
  - patterns-as-enforceable-types
  - structural-guardrails
  - suggestible-actor-properties
  - three-classes-of-guardrail-erosion-resistance
related_posts:
  - /the-consenting-adults-problem/
excerpt_text: >
  A check the model can edit is a suggestion, not a guardrail.
---

**A check the model can edit is a suggestion, not a guardrail.**

Deterministic checkers (compilers, build visibility rules, CI gates) earn their place by a placement test: the check is evaluated by a tool outside the model's control, over an artifact outside the model's write path. Bazel's `visibility` rules live in BUILD files and are evaluated by the build system, so an agent editing source cannot grant itself access. The check runs on a different artifact than the one the agent writes.

Conventions fail this test. They live in the same files the model rewrites. A markdown file saying "do not import from _internal" sits in a repo the model can write to. Python's `__all__` is weaker still: a list inside the module itself, affecting only star imports. The model imports the private name directly and nothing fails at runtime. The violation is silent until a human happens to read that exact diff.

If the model's write path includes the BUILD file, the visibility check slides back into the lie space and the property collapses. Determinism is the qualification, not intelligence. The compiler is not smarter than the human reviewer. It is the same every time, and it checks every path, not the ones the eye lands on.

Related: [structural-guardrails](/garden/structural-guardrails/), [consenting-adults-language-philosophy](/garden/consenting-adults-language-philosophy/), [suggestible-actor-properties](/garden/suggestible-actor-properties/), [patterns-as-enforceable-types](/garden/patterns-as-enforceable-types/)
