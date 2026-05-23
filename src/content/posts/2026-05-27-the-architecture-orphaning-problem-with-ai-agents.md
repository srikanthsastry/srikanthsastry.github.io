---

title: "The Architecture Orphaning Problem with AI Agents"
published: 2026-05-27
series: 'suggestible-actor'
series_order: 3
series_label: 'The Suggestible Actor'
tags:

- 'software engineering'
- 'AI'
- 'software architecture'
- 'spec-driven development'
- 'mental models'
abbrlink: 'the-architecture-orphaning-problem-with-ai-agents'
image: /assets/images/architecture-orphaning-cover.jpg
lang: ''
excerpt: >
  Spec-Driven Development gets functional correctness right but leaves architecture unanchored. The Suggestible Actor model explains why: specs cannot enforce structural constraints, and LLMs, reasoning locally, orphan the architecture one generation at a time.
categories:
- Professional

---

[Spec-Driven Development](https://martinfowler.com/articles/exploring-gen-ai/sdd-3-tools.html) (SDD) has become the new cool thing to try in AI-assisted software development. It has drawn apologists, critics, and apologist-turned-critics. And somehow, they all have a point. But how? The Suggestible Actor model and its guardrail erosion corollary explain those objections — and provide a mechanism to address them.

---

## Spec-Driven Development: why is it useful, when others failed?

SDD ([Böckeler 2025](https://martinfowler.com/articles/exploring-gen-ai/sdd-3-tools.html), [Bouchard 2026](https://medium.com/@healthy_crimson_leopard_464/spec-driven-development-from-vibe-coding-to-structured-ai-development-30dff25362ff)) iterates between structured specifications and human review gates until the spec is unambiguous enough to generate code. It correctly shifts the developer's job from "write code" to "define what correct means." SDD is arguably the first directionally right attempt at an AI-native development pattern.

Every prior spec-first methodology (Waterfall, design-by-contract, CASE tools) failed because specification was *additional* to implementation. You spent effort on the spec, then more on the implementation. The latter is necessary *and* expensive, and so people often forgo the former.

Generative AI changed that cost calculus. Implementation is cheaper, but it [erodes guardrails](/the-guardrail-erosion-problem-with-ai-agents/) systematically. Specifications appear to be the antidote: the surplus human attention goes to spec development as a foil against erosion. Hence SDD.

But how *does* SDD resist guardrail erosion? The [Suggestible Actor](/the-suggestible-actor/) model and its [guardrail erosion corollary](/the-guardrail-erosion-problem-with-ai-agents/) reveal that there is always a [directive gap](/garden/directive-gap/) between what you specified and what you meant. The iterative process of testing a specification against the produced code and refining the specification in response narrows this directive gap to the point of functional correctness.

However, there is a layer in software design that iteration cannot reach: architectural constraints.

## Architecture orphaning

While a spec describes *WHAT* the system should do, it does not describe *HOW* it should do it. Questions such as "which library to use" and "which boundaries to respect" are outside the spec. A spec *can* state architectural constraints, but behavioral tests derived from that spec cannot *enforce* them. A test that verifies correct output passes whether the code calls a shared service or reimplements the logic inline. Stating the constraint is easy; detecting violations through the spec-to-test pipeline is the gap.

The *WHAT* and the *HOW* are two distinct layers in software design. In traditional development, one human holds both layers in the same head. With LLMs, the layers separate, and architectural decisions fall between:

- The spec's test pipeline **cannot enforce** it (behavioral tests don't verify architectural choices)
- The LLMs **cannot infer** it (architecture is system-level, non-local; the [suggestible actor reasons locally](/garden/ambient-to-local/))

Architecture becomes an [orphaned layer](/garden/architecture-orphaning/): too low for the spec, too high for the locally reasoning agent. Sure, SDD lists architecture as a design phase; but listing is not the same thing as governing. Architectural decisions remain invisible to the behavioral test.

---

## SDD critics are really talking about architecture orphaning

Critics come from different directions, but look closer: they are observing symptoms of architecture orphaning without diagnosing it.

**Canciani** (["Code over Specs,"](https://blog.devgenius.io/the-spec-is-the-code-why-i-dont-buy-spec-driven-design-f75c784f7b46) May 2026) proposes "fitness functions" — architectural tests that enforce structural boundaries: *"You aren't writing a spec; you are setting a hard boundary."* He also advocates Architectural Design Records (ADRs) as "case law" that stops AI from re-litigating settled architectural decisions. Canciani is arguing for [structural guardrails](/garden/structural-guardrails/) without the theoretical grounding for why specs can't do this work.

**Dev.to/REAP** (["Why SDD Fails,"](https://dev.to/casamia918/why-spec-driven-development-fails-and-what-we-can-learn-from-it-2pec) May 2026) states it directly: *"The same specification produces different implementations across different runs — varying architectural choices, data structures, and error handling."* That sentence is architecture orphaning as empirical observation. Their fix is evolving "Genomes" of principles and conventions: richer context for the agent, but still a [social guardrail (one of the least robust guardrails).](/garden/social-guardrails/) The agent *can* violate it when the local context moves past these conventions.

**Konrad et al.** (["Architecture Without Architects,"](https://arxiv.org/abs/2604.04990) Apr 2026) arrive at the phenomenon empirically. AI coding agents select frameworks, scaffold infrastructure, and wire integrations in seconds: *"These are architectural decisions, yet almost no one reviews them as such."* They coin the term "vibe architecting" — architecture shaped by prompts rather than deliberate design — and confirm that prompt wording alone produces structurally different systems for the same task. This is architecture orphaning observed in the wild, with independent terminology.

The consequences are already measurable. [Huang et al. (2026)](https://arxiv.org/abs/2601.21276) find that LLM agents disregard code reuse opportunities, and that reviewers express *more* positive emotions toward AI-generated code than human code: surface plausibility masks structural damage. [GitClear's analysis](https://www.gitclear.com/coding_on_copilot_data_shows_ai_downward_pressure_on_code_quality) of 153 million lines tells the same story: less refactoring, more copy-paste, code that "resembles an itinerant contributor."

---

## A separate layer for architectural governance

For AI-assisted software development, we need [two distinct layers of governance](/garden/two-layer-governance-model/): (1) iterative spec convergence, which is what SDD provides, and (2) architectural coherence, which [structural guardrails](/garden/structural-guardrails/) provide.

**Iterative specification convergence** (spec layer) handles functional correctness. The human iterates on the spec; the LLM regenerates; verification narrows the directive gap. It happens for each feature and frequently. This is what SDD does at its best.

**Architectural coherence** (implementation layer) handles architectural drift and ensures drift is deliberate. Enforcement is expressed per-system, requires high investment (human effort), and changes slowly. This is what SDD lacks and cannot provide, because SDD operates entirely at the spec layer.

Neither substitutes for the other; they complement each other. Convergence verifies "does this code do what the spec says?" Structural guardrails verify "does this code respect the system's architectural constraints?" The spec cannot *enforce* architecture through its test pipeline without collapsing the abstraction, and structural guardrails cannot close the directive gap.

Both layers produce tests, but these [two types of tests are distinct](/garden/behavioral-vs-architectural-coherence-tests/). SDD produces behavioral tests (e.g., "given valid credentials, return 200") that pass regardless of *how* the behavior is satisfied. Architectural coherence tests verify structure: they are derived from the architecture document, not the spec, and encode structural decisions as test constraints.

![Two-layer governance model](/assets/images/two-layer-governance-model.svg)

---

## What does architectural coherence look like?

Your architecture says all authentication goes through the auth service. The SDD behavioral test ("given valid credentials, return 200") passes whether the code calls the auth service or reimplements auth inline. The architectural coherence test: a build-system visibility rule that prevents the user-facing service from importing auth implementation libraries directly. It can only depend on the auth service client. That rule lives in CI configuration the agent cannot modify. Violation is a build failure, not a review comment.

With such tests in place, the architect's job shifts from drawing boxes and arrows to designing types, build rules, and capability boundaries. The tooling for this is nascent: today, building architectural coherence tests is a manual investment per system. That investment is the cost of the two-layer governance model, and it is a tooling gap the ecosystem has not yet closed.

---

SDD promised to harness the power of AI coding agents without the quagmire of multi-generational vibe coding. But that promise comes with a near-fatal loss of architectural coherence. This is a genuine trade-off that you cannot reclaim without paying with the scarcest resource: human attention that builds and maintains your structural guardrails.