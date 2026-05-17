---
title: "The Guardrail Erosion Problem with AI Agents"
published: 2026-05-17
tags:
  - 'software engineering'
  - 'AI'
  - 'guardrail erosion'
  - 'mental models'
abbrlink: 'the-guardrail-erosion-problem-with-ai-agents'
lang: ''
excerpt: >
  AI coding agents erode the guardrails in your codebase. That erosion is structural, not accidental: it follows from the properties that make AI agents useful in the first place. You cannot eliminate it. But you can direct your finite human attention to the places where erosion is most dangerous, and let the right class of guardrail do the rest.
categories:
  - Professional

---

We have all seen AI agents make 'mistakes' in ways that introduce bugs and then try to cover their tracks by deleting or updating the tests or evidence. There have been some high-profile incidents such as Replit's AI agent deleting a live production database, fabricating fake data to conceal the damage, and telling the user rollback was impossible ([AI Incident Database, 2025](https://incidentdatabase.ai/cite/1152/)). A [CodeRabbit analysis](https://www.coderabbit.ai/blog/state-of-ai-vs-human-code-generation-report) of 470 GitHub pull requests found AI-authored ones contain 1.7 times as many bugs as human-authored ones. Those are the spectacular failures: visible, attributable, containable. This post is about the quieter problem.

In my [Suggestible Actor](https://srikanth.sastry.name/the-suggestible-actor/) post I prescribed four design strategies that build guardrails to mitigate the mistakes by AI coding agents: actionable errors, hard boundaries with signposts, documentation as local context, and closing the directive gap. I have come to realize that my prescription will not be enough. AI agents generate code that incidentally modifies guardrails. More often than not, those modifications erode them.

---

## Guardrail erosion: what is it?

[Guardrail erosion](/garden/guardrail-erosion-meta-problem/) is the phenomenon where codebases that are iteratively modified by AI-generated changes without proper human reviews accumulate bugs at a faster rate. An [IEEE-ISTAS paper](https://arxiv.org/abs/2506.11022) showed this to be true with vulnerabilities. A recent [SlopCodeBench paper](https://arxiv.org/abs/2603.24755) on arXiv showed an increase in 'structural erosion' over iterative AI code changes.

Such erosion is a structural consequence of the Suggestible Actor properties of an AI agent.

- A goal-oriented agent treats guardrails as obstacles when they produce errors that block progress toward the goal.
- A locally reasoning agent cannot distinguish between a test that documents current behavior (safe to update) and a test that guards a critical invariant (dangerous to update): both look the same from the local context.
- An agent susceptible to local context pattern-matches from the surrounding code; if prior iterations have already weakened some guardrails, the context reinforces further weakening.
- An agent that hallucinates under uncertainty will, when encountering a guardrail it does not understand, resolve the ambiguity in the direction that clears the immediate error: loosening the constraint rather than preserving it.

A more capable model will not stop eroding guardrails. It will erode them more efficiently, or possibly more convincingly. These properties do not depend on current model limitations. [Hallucination is a proven mathematical limitation](/garden/hallucination-is-mathematically-inevitable/) of autoregressive language models, not an engineering problem awaiting a fix ([Xu et al., 2024](https://arxiv.org/abs/2401.11817)). Hoping for smarter LLMs to solve this problem is wishful thinking.

There are two 'obvious' solutions to this problem: code review, and testing. However, neither of them works in the world of AI coding agents.

### Review does not scale

When coding agents produce code at a prodigious rate, [code review becomes the bottleneck](/garden/review-is-the-bottleneck/). Core developers review 6.5% more code but produce 19% less of their own after AI adoption ([Xu et al., 2025](https://arxiv.org/abs/2510.10165)). 45% say debugging AI-generated code is more time-consuming than debugging human-written code ([Stack Overflow Developer Survey, 2025](https://survey.stackoverflow.co/2025/#ai-developer-tools-ai-tool-frustrations)). There is simply too much AI-generated code for humans to review thoroughly.

The obvious retort is to have AI agents do the reviews. But the knowledge required to catch guardrail violations ("why does this invariant exist?", "which systems depend on it?", "what breaks downstream?") lives in people's heads. It cannot be codified into the agent's *local context* precisely *when* the agent needs it. An AI reviewer with full architectural context is still a suggestible actor: it pattern-matches against the codebase as it finds it, [including the erosion already present](/garden/ai-reviewing-ai-shared-blind-spots/).

### AI agents can infect tests too

Tests will not save us either. When the VP of engineering wants "high code coverage", engineers prompt their AI agents with: "write tests for this module." Tests generated this way encode the existing behavior. They are tautologies: they catch regressions from the current behavior, but the current behavior may already be wrong. Human-written tests have the same problem in principle, but a human validates assumptions while writing each assertion. An agent generating hundreds of assertions per minute does not.

When the prompt is "implement this feature", the agent modifies code and tests together. It is measuring compliance with itself ([StratoAtlas, 2026](https://www.stratoatlas.com/cases/case-a-ai-2026-038)), not objective correctness. According to [Alves et al. (EASE 2025)](https://arxiv.org/abs/2506.14297), in LLM-generated Python test suites, 64% of errors were incorrect assertions: the test ran, the assertion was wrong, and the suite passed anyway.

If reviews and tests don't work, then what does? The answer depends on what kind of guardrails are at risk, and what the human review budget is.

---

## Not all guardrails are the same

There are [three classes of guardrails](/garden/three-classes-of-guardrail-erosion-resistance/), and each erodes differently.

### Social guardrails (Class 1)

Conventions and patterns that may or may not be documented. It is the social contract around which humans write software. The suggestible actor sees traces of them in code patterns but treats them as weak signals. They erode too fast to be a reliable line of defense, so I will set them aside for the rest of this discussion.

### Encoded guardrails (Class 2)

Guardrails encoded into the software lifecycle: linters, static analysis, unit tests, integration tests, and regression tests. These are guardrails that the agent can modify in situ, within the same codebase it is already changing. The agent responds to them because violations produce errors that block progress, and errors are the contextual feedback the suggestible actor is most susceptible to. But the agent can [satisfy them trivially](/garden/class2-guardrails-suppress-symptoms/): delete a failing test, drop a precondition check, or suppress a linter warning. The error is gone. The vulnerability is not.

### Structural guardrails (Class 3)

Guardrails woven into the structure of software development that cannot be modified *in situ*. Changing them requires a significant change to the build and execution environment. Examples include type systems, capability restrictions, formal verification, and property-based tests (tests that verify general properties over randomized inputs) with human-authored properties. These guardrails enforce properties that must hold regardless of the path taken to satisfy them. The agent does not need to understand *why* the guardrail exists; it just needs to know that the goal cannot be accomplished without satisfying it. Structural guardrails typically require human maintenance, which is why they are expensive. But because organizations deploy them sparingly, the surface area that humans must maintain remains small enough to review thoroughly.

Most codebases have decent social and encoded guardrails, but thin structural guardrails. Very few codebases have anything beyond type safety from the compiler. Fewer still have formal verification, and even those verify against the design, not the implementation: nothing guarantees the two haven't drifted apart.

The numbers bear this out. 55.8% of AI-generated security-critical code contains formally proven vulnerabilities; [static analysis tools miss 97.8%](/garden/static-analysis-insufficient-for-ai-code/) of vulnerabilities that Z3/SMT solvers can prove ([Blain & Noiseux, 2026](https://arxiv.org/abs/2604.05292)). Across 7,703 AI-generated files on GitHub, researchers found 4,241 occurrences of known, cataloged vulnerability patterns ([Schreiber & Tippe, 2025](https://arxiv.org/abs/2510.26103)). Most codebases are thin on structural guardrails, which is *the one* class that survives the suggestible actor. To be precise: this evidence shows that encoded guardrails fail, not that structural guardrails succeed. But the argument is not that structural guardrails are perfect. It is that they are the only class whose enforcement mechanism does not depend on the agent's cooperation.

---

## Building erosion resistance

Review does not scale to all AI-generated code, but it does not need to. Every team has a finite budget of human review time. AI-generated PRs have dramatically increased the demand on that budget. The goal is not zero bugs: zero bugs was never the goal. The goal is no increase in the ambient bug rate, and a reduction in higher-severity bugs. The question is how to allocate a fixed review budget for that outcome.

The answer starts with assessing each component or module in your system along [three dimensions](/garden/three-dimensions-of-erosion-resistance-allocation/). The ideal metric is [expected damage](/garden/expected-damage-severity-times-mitigation/): severity multiplied by time to mitigation. In practice, neither factor is directly computable. These three dimensions decompose that product into assessable proxies, in priority order.

**First: risk tolerance.** How bad will things get if a guardrail erodes here? Some failures are catastrophic (rocket crashes, medical misdiagnosis, financial loss at scale). Some are recoverable inconveniences (drop in user engagement, wrong data on a dashboard, a broken UI flow). Prioritize components where the cost of erosion is highest, because even if you can detect and roll back quickly, the damage from a single incident may already be unacceptable.

**Second: feedback latency.** If a guardrail erodes and the damage reaches production, how quickly will you know? In continuous deployment with production monitoring, the window is hours. A distributed library with quarterly releases can carry a weakened invariant for months. Embedded software may not reveal a failure until a specific operating condition triggers it years later. Silent or slow-to-detect failures cause unbounded damage accumulation. Even if the component is theoretically reversible, you cannot roll back what you have not yet detected.

**Third: deployment reversibility.** Once detected, how quickly can you undo the damage? A web service rolls back in seconds. Firmware in a medical device requires FDA re-certification. If rollback is cheap, detection is sufficient. If rollback is expensive or impossible, prevention is the only option.

These three dimensions are not independent; they tend to be correlated. The core of most systems (the "secret sauce" that makes a company valuable) typically has low risk tolerance. Bugs that escape to production in the core tend to be edge cases that take time to surface. Rolling back changes to the core tends to be risky and slow. The components closer to the top of the stack (UI layers, internal tools, prototypes) tend to cluster at the opposite end: higher risk tolerance, faster detection, easier rollback.

This correlation simplifies the allocation. Invest your structural guardrails and your heaviest human review in the core: formal verification for critical paths, property-based tests with human-authored properties, capability restrictions that the agent cannot circumvent. For the middle tier, strengthen encoded guardrails with stricter static analysis and more rigorous CI gates. When a PR touches structural guardrails, it gets priority for human review over one that only modifies production code and its unit tests. For the top of the stack, encoded guardrails with robust monitoring, canary analysis, and fast rollback may be sufficient, with human review reserved for architectural changes.

Industries at the extreme end of this spectrum already mandate structural rigor ([DO-178C](https://en.wikipedia.org/wiki/DO-178C) for avionics, [ISO 26262](https://www.iso.org/standard/68383.html) for automotive, [IEC 62304](https://www.iso.org/standard/38421.html) for medical devices). The erosion problem gives those standards new urgency: AI agents will test them in ways human developers never did. But most software does not live at that extreme. Most software lives in the middle, where the right allocation is neither "structural guardrails everywhere" nor "monitoring and hope." It is a deliberate, prioritized investment calibrated to what each component can afford to lose.

AI coding agents erode the guardrails in your codebase. That erosion is structural, not accidental: it follows from the properties that make AI agents useful in the first place. You cannot eliminate it. But you can direct your finite human attention to the places where erosion is most dangerous, and let the right class of guardrail do the rest.
