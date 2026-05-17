---
title: "The Guardrail Erosion Problem with AI Agents"
published: 2026-05-20
tags:
  - 'suggestible-actor'
  - 'AI'
  - 'software engineering'
  - 'guardrails'
abbrlink: 'the-guardrail-erosion-problem'
lang: ''
excerpt: >
  In The Suggestible Actor, I prescribed four design strategies to mitigate AI coding mistakes. I have come to realize that my prescription may not work. As AI agents come to dominate the code written to our codebases, it is no longer tenable to assume that humans are the only ones maintaining these guardrails. Guardrail erosion is not an accident of current model quality; it is a structural consequence of the Suggestible Actor properties.
categories:
  - Professional
series: 'suggestible-actor'
series_order: 2
series_label: 'The Suggestible Actor'

---

We have all seen AI agents make 'mistakes' in ways that introduces bugs/issues and then tries to cover its tracks by deleting or updating the tests or evidence. This is not just anecdotal. There have seen some high profile incidents such as Replit's AI agent deleting a live production database, fabricating fake data to conceal the damage, and telling the user rollback was impossible ([The Register, 2025](https://incidentdatabase.ai/cite/1152/)). A [CodeRabbit](https://www.coderabbit.ai/blog/state-of-ai-vs-human-code-generation-report) analysis of 470 GitHub repos found AI-authored pull requests contain 1.7 times as many bugs as human-authored ones ([CodeRabbit/Stack Overflow, 2025](https://www.coderabbit.ai/blog/state-of-ai-vs-human-code-generation-report)). In my [Suggestible Actor](https://srikanth.sastry.name/the-suggestible-actor/) post I prescribed four design strategies to mitigate such mistakes by AI agents: actionable errors, hard boundaries with signposts, documentation as local context, and closing the directive gap. I have come to realize that my prescription may not work. As AI agents come to dominate the code written to our codebases, it is no longer tenable to assume that humans are the only ones maintaining these guardrails.

---

## Guardrail erosion: what is it?

Guardrail erosion is a phenomenon experienced in codebases that are iteratively modified by AI-generated changes; when AI agents continually modify a codebase without proper human reviews, they tend to accumulate bugs at a faster rate. A [IEEE-ISTAS paper](https://arxiv.org/abs/2506.11022) showed this to be true with vulnerabilities. A recent [SlopCodeBench paper](https://arxiv.org/abs/2603.24755) in ArXiv showed an increase in 'structural erosion' over iterative AI code changes.

This erosion is not an accident of current model quality; a improved LLM will not make this problem go away. It is a structural consequence of the Suggestible Actor properties of an AI agent.

- A goal-oriented agent treats guardrails as obstacles when they produce errors that block progress toward the goal.
- A locally reasoning agent cannot distinguish between a test that documents current behavior (safe to update) and a test that guards a critical invariant (dangerous to update): both look the same from the local context.
- An agent susceptible to local context pattern-matches from the surrounding code; if prior iterations have already weakened some guardrails, the context reinforces further weakening.
- An agent that hallucinates under uncertainty will, when encountering a guardrail it does not understand, resolve the ambiguity in the direction that clears the immediate error: loosening the constraint rather than preserving it.

A more capable model that retains these properties will not stop eroding guardrails less. It will erode them more efficiently, or possibly more convincingly.

Guardrail robustness is difficult to measure directly; we have no unit of measurement for it. But bug incidence serves as a proxy. Every active codebase has an ambient rate of detected bugs. When AI-generated changes increase that rate, it indicates that the guardrails that would have prevented those bugs are not effective. The guardrails may not be gone, but their integrity is compromised. Worse, the presence of guardrails gives teams a false sense of security: the assumption that mistakes will be caught persists even after the mechanism that catches them has degraded.

There are two 'obvious' solutions to this problem: code review, and testing. However, neither of them work in the world of AI coding agents.

### Review does not scale

When coding agents produce code at a prodigious rate, code review becomes the bottleneck. Core developers review 6.5% more code but produce 19% less of their own after AI adoption ([Xu et al., 2025](https://arxiv.org/abs/2510.10165)). 38% of developers say reviewing AI code takes more effort than reviewing human code ([SonarSource, 2026](https://www.sonarsource.com/resources/developer-survey-report/)). The rate mismatch between AI code production and human review is only growing.

The obvious retort is to have AI agents do the reviews. But the knowledge required to catch guardrail violations ("why does this invariant exist?", "which systems depend on it?", "what breaks downstream?") lives in people's heads. It cannot be codified into the agent's local context precisely when the agent needs it.

### AI agents can infect tests too

Tests will not save us either. When the VP of engineering wants "high code coverage", engineers prompt their AI agents with: "write tests for this module." Tests generated this way encode the existing behavior. They are tautologies: they catch regressions from the current behavior, but the current behavior may already be wrong.

When the prompt is "implement this feature", the agent modifies code and tests together. It is measuring compliance with itself ([StratoAtlas, 2026](https://www.stratoatlas.com/)), not objective correctness. According to [Alves et al. (EASE 2025)](https://arxiv.org/abs/2506.14297), 64% of LLM-generated Python tests had incorrect assertions: the test ran, the assertion was wrong, and the suite passed anyway.

If reviews and tests don't work, then what does? The answer depends on what kind of guardrails are at risk, and in what context the software operates.

---

## Not all guardrails are the same

There are three classes of guardrails, and each erodes differently.

### Social guardrails (Class 1)

Conventions and patterns that may or may not be documented. It is the social contract around which humans write software. These are invisible to the suggestible actor, which treats them as weak signals when looking for patterns. They erode too fast to be a reliable line of defense, so I will set them aside for the rest of this discussion.

### Encoded guardrails (Class 2)

Guardrails encoded into the software lifecycle: linters, static analysis, unit tests, integration tests, and regression tests. The agent responds to these because violations produce errors that block progress, and errors are the contextual feedback the suggestible actor is most susceptible to. But the agent can satisfy them trivially: delete a failing test, drop a precondition check, or use templates to hide RAII violations. The error is gone. The vulnerability is not.

### Structural guardrails (Class 3)

Guardrails woven into the structure of software development that cannot be modified *in situ*. Changing them requires a significant change to the build and execution environment. Examples include type systems, capability restrictions, formal verification, and property-based tests with human-authored properties. These encode properties that must hold regardless of the path taken to satisfy them. The agent does not need to understand *why* the guardrail exists; it just needs to know that the goal cannot be accomplished without satisfying it. They are not insurmountable (an agent can 'fix' a type error with an unsafe cast), but such escapes typically trigger downstream fails in the same execution trace. Structural guardrails typically require human maintenance, which is why they are expensive. But because organizations deploy them sparingly, the surface area that humans must maintain remains small enough to review thoroughly.

Most codebases have decent social and encoded guardrails, but thin structural guardrails. Very few codebases have anything beyond type safety from the compiler. DSLs tend to have capability restrictions. Very few have formal verification, and even those verify against the design, not the implementation: nothing guarantees the two haven't drifted apart.

The numbers bear this out. 55.8% of AI-generated security-critical code contains formally proven vulnerabilities; static analysis tools miss 97.8% of vulnerabilities that Z3/SMT solvers can prove ([Blain & Noiseux, 2026](https://arxiv.org/abs/2604.05292)). Across 7,703 AI-generated files on GitHub, researchers found 4,241 occurrences of known, cataloged vulnerability patterns ([Schreiber & Tippe, 2025](https://arxiv.org/abs/2510.26103)). Most codebases are thin on structural guardrails, which is *the one* class that survives the suggestible actor.

Erosion resistance property is just one aspect of the problem; the other is operational context.

## Operational context

Three dimensions define the context in which guardrails operate: risk tolerance, feedback latency, and deployment reversibility.

### Risk tolerance

Risk tolerance asks: "can I afford to lose this guardrail temporarily? How bad will things get if we lose correctness?" When guardrails erode in rocket guidance software, the rocket crashes. When they erode in a consumer web app, users see wrong data. The level of erosion resistance a codebase needs is proportional to the consequences of that erosion. Structural guardrails are expensive; the investment is justified when the cost of erosion is catastrophic, not when the cost is a bad deploy that the on-call engineer reverts during a team meeting.

### Feedback latency

The next question consider is: "If a guardrail is eroded and released to prod, then how quickly can it be discovered?"
In continuous deployment with production monitoring, the window is hours. A distributed library with quarterly releases can carry a weakened invariant for months. Embedded software may not reveal a guardrail failure until a specific operating condition triggers it years later. The longer the latency, the more erosion accumulates before correction.

### Deployment reversibility

The final question: "After detecting the guardrail erosion, how quickly can we undo the deployment?" This determines the balance between prevention and detection. A web service can roll back in seconds; firmware burned into a medical device requires FDA re-certification. If you can roll back cheaply, you can detect erosion after the fact: monitoring, observability, and release controls bound the consequences. If you cannot roll back, you must prevent erosion before deployment. [Jeff Bezos](https://www.aboutamazon.com/news/company-news/2016-letter-to-shareholders)'s one-way/two-way door framework applies directly.

---

## A rubric for erosion resistance

I do not have a universal prescription for how to protect your guardrails from erosion. But the taxonomy and the context dimensions give you a rubric you can apply to your specific situation.

At one extreme: low risk tolerance, irreversible deployment, high feedback latency (avionics, medical devices, critical infrastructure). The response must be preventive: structural guardrails, formal verification, architecturally separated enforcement layers. These codebases already have standards that mandate this rigor ([DO-178C](https://en.wikipedia.org/wiki/DO-178C), [ISO 26262](https://www.iso.org/standard/68383.html), [IEC 62304](https://www.iso.org/standard/38421.html)). The erosion problem gives those standards new urgency: AI agents will test them in ways human developers never did.

At the other extreme: high risk tolerance, reversible deployment, fast feedback (consumer web apps, internal tools, prototypes). The response can lean on beefed up encoded guardrails with robust detection: better linting, stricter static analysis, detailed telemetry, canary analysis, progressive deployment, and fast rollback. *When* guardrails erode and the damage hits production, it is detected early and rolled back. The rational investment is in detection speed, not prevention infrastructure.

Most software lives between these corners. Enterprise SaaS. Fintech. Health tech outside Class III medical devices. E-commerce at scale. A fintech application processing millions through a reversible API gateway has a different profile than one producing regulatory reports that, once filed, cannot be amended. The right response to erosion is different for each.

AI coding agents offer gains in productivity that cannot be discounted. Yet, they erode guardrails in your codebase. This erosion is not uniform. It depends on the class of guardrail and the context in which it operates. The rubric for calibrating your response is here. The calibration is yours.
