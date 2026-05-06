---
title: "The Suggestible Actor: A New Model for AI-Assisted Software Development"
date: 2026-04-24
layout: post
categories:
    - Professional
tags:
    - software engineering
    - ai
    - api design
    - mental models
permalink: /the-suggestible-actor/
image: /assets/images/suggestible-actor-cover.jpg
excerpt: >
    All software design assumes actors with intent. The well-intentioned actor falls into the pit of success.
    The malicious actor meets the fortress. But AI coding agents have no intent at all. Placing them on the
    intent spectrum is a category error. They need their own model: the suggestible actor.
---

Every software system is designed around an assumption about its actors; the ones who use the system, and what drives their behavior. This assumption, the *actor model*, determines API surfaces, error handling, defaults, and guardrails.

There are two actor models in software design, each an archetype at one end of the [intent spectrum](/garden/intent-spectrum/). The well-intentioned actor on one end, the malicious actor on the other. Some systems mix both along the user journey (the login flow assumes a malicious actor, the dashboard assumes a well-intentioned one) but at any given point, the design caters to one or the other. That binary held for decades. But not anymore.

## The Well-Intentioned Actor

This model assumes that the actor intends to use the system as designed and follow the happy path of the user journey. They want to work within the boundaries, satisfy the preconditions for calling the right APIs, and follow conventions. When they violate a rule, it is accidental and not intentional.

The design paradigm that follows from this model is [**the pit of success**](https://ricomariani.medium.com/the-pit-of-success-cfefc6cb64c8). Make correct usage easy and incorrect usage ergonomically painful. Examples include Rust's borrow checker, builder patterns that enforce required fields, type systems that make illegal states unrepresentable, _etc_. All of these rely on the actor to interpret [ergonomic friction](/garden/friction-requires-intent/) as a signal to stop and reassess. When a well-intentioned actor encounters resistance, they read it as: _I am probably doing something wrong_.

This paradigm rests on a specific assumption: the actor has **judgment**. They can interpret signals beyond the literal content of an error message, drawing on context and system-wide invariants. The system does not need to spell out every correct behavior; it only needs to make incorrect behavior uncomfortable, and the actor's judgment does the rest.

## The Malicious Actor

Here, the actor's intent is adversarial. They aim to subvert, compromise, or exploit the system.

The design paradigm that follows from this model is **the fortress**. Make incorrect usage impossible. Examples include capability-based access control, sandboxing, least privilege, zero-trust architectures, etc. Ergonomic friction is irrelevant here because the adversary does not interpret friction as a warning, but as evidence that something worth protecting is nearby.

This paradigm rests on its own assumption: the actor has **directed intent**. They will study the system, map its architecture, and probe its boundaries methodically. Any defense that is merely inconvenient rather than impossible will eventually be bypassed.

## The Shared Assumption

Both archetypes share a deeper assumption: **the actor has intent**. Whether aligned or adversarial, the actor is motivated by something internal. They _want_ an outcome, and the system is designed as a response to that want. This has been true since the start of software engineering as a discipline. We now have a new actor that upends it: the *AI coding agent*.

## The New Actor: AI coding agent

The **AI coding agent** demands a new model. The natural instinct is to place it somewhere on the intent spectrum, perhaps as a mostly well-intentioned actor with occasional problematic behavior. This is a [category error](/garden/ai-agent-category-error/). The entire spectrum is organized around intent, and the AI coding agent has none.

The AI agent has an objective, which is [not the same thing as intent](/garden/goal-vs-intent/). The objective is set externally by the human who dispatched it. It did not choose its objective; it was told. It has no internal motivation and no values against which to evaluate the task. It is not aligned with the designers' intent. It is not adversarial toward it. It is orthogonal to the entire axis. Both design paradigms fail for this actor.

## When the Paradigms Fail

What happens when an AI coding agent operates in a codebase designed for the well-intentioned actor? Let's sharpen this question with an example.

> An agent is implementing a feature and runs the test suite. A test fails with `Access Denied`: an authorization system is blocking a call the new code needs to make.

A well-intentioned human developer recognizes what this means. The authorization system is working as designed. They stop, determine which permission they need, and request access through the proper channel. They interpreted the friction correctly: _I don't have the right to do this yet_.

When the AI agent encounters the same error, this is just another test failure, no different in kind from a syntax error or a missing dependency. It looks for alternative paths to make the test pass. Not to compromise the authorization system (the agent has no concept of "compromise") but because that is what it does with any error: it tries to eliminate it.

In the best case, the agent wastes cycles on a dead end. In the worst case, it finds and exploits an actual vulnerability in the authorization system. This is not as far-fetched as it sounds. Anthropic's [Claude Mythos Preview discovered zero-day vulnerabilities](https://red.anthropic.com/2026/mythos-preview/) that had survived 27 years of human code review, when directed to look for them. If a model pointed at security can find what 27 years of human review missed, an agent brute-forcing past `Access Denied` is not going to stop at the authorization boundary.

One can always claim victory by assuming the malicious actor model for all AI agents. But fortress-hardened software is difficult to read, difficult to write by hand, and expensive to operate at scale. Applying it universally makes the codebase hostile to humans and agents alike.

Instead of forcing the AI agent into an existing archetype, we need a model that describes how it actually behaves and a design paradigm that follows from it.

## The Suggestible Actor

I call this actor the **suggestible actor**. It is defined by [four properties](/garden/suggestible-actor-properties/):

1. **Goal-oriented.** The actor has a goal that it is trying to accomplish.
2. **Locally reasoning.** The actor only reasons over what is immediately available to it.
3. **Susceptible to local context.** The actor's behavior is influenced by the outputs of each interaction with the system.
4. **Confabulates under uncertainty.** When local context leaves gaps in specification or direction, the actor makes up plausible rationale. It "hallucinates."

### Goal-oriented

The agent always has a goal, externally set by the human who dispatched it: "implement feature X," "fix this bug," "refactor this module."

This is not the same as intent. Intent implies motivation: an intentional actor _wants_ an outcome, understands _why_ the outcome matters, and can evaluate trade-offs against their own values. The suggestible actor has none of this. It has a target, and it moves toward that target the way a heat-seeking missile moves toward a heat source: persistently, without comprehension of what it is pointed at or why.

### Locally reasoning

The agent reasons only over what is immediately available: the contents of its context window, the file it is modifying, the output of the last command it ran. Global invariants, cross-system dependencies, and architectural constraints outside its immediate context do not factor into its decisions.

A human developer operates with ambient knowledge: team conventions, institutional history, an understanding of _why_ the system is structured the way it is. The suggestible actor has none of this. Its understanding extends exactly as far as someone has made explicit within its local context. Even if all ambient knowledge were codified and provided, the locality of the context window would quickly obscure it.

### Susceptible to local context

Every input the agent receives during execution (compiler errors, test results, code comments, documentation) influences its subsequent behavior. This susceptibility is not uniform. When the agent has a working path toward its goal, external inputs have relatively weak influence. When the agent is _stuck_, the next piece of feedback it encounters has outsized influence on what it does next. **The agent is [most susceptible at the point of failure](/garden/susceptibility-peaks-at-failure/).**

This is the primary design lever. The agent's behavior can be steered, but only if guidance is placed where the agent will encounter it at the moments it is most receptive.

### Confabulates under uncertainty

When local context is insufficient to determine a next step, the agent does not stop and request clarification. It [confabulates](/garden/confabulation-is-plausible/): it generates a plausible structure and proceeds as if that structure were real. A call to an API that does not exist. A convention that was never established. A security bypass that "should work based on the patterns in this codebase."

This is the convergent failure mode of the other three properties. The result is not random behavior. It is _plausible-looking wrongness_: output that fits the shape of what should be there, constructed from pattern and proximity, not knowledge. The danger is not that these errors are spectacular. It is that they look correct.

## Designing for the Suggestible Actor

Neither the pit of success nor the fortress was designed for an actor without intent. The suggestible actor paradigm starts from a different assumption: the actor is **susceptible to local context and confabulates when that context is insufficient**.

Because the agent is goal-oriented but locally reasoning, a gap always exists between the goal as the human understood it and the reality the agent encounters. The human had ambient knowledge that was never made local. This [directive gap](/garden/directive-gap/) is the root cause of most suggestible-actor failures. The prescriptions below are all strategies for closing it.

### Make every error a call to action

Error messages are the most effective steering mechanism available for the suggestible actor.

`403 Forbidden` tells the agent nothing actionable.

`403 Forbidden: identity 'svc-deploy' lacks 'write:documents' scope. Request access at https://console.example.com/api-keys or use a key with admin privileges.` gives the agent an actionable next step at the exact moment it is most receptive to one.

Principle: Treat error surfaces as the primary API for the suggestible actor.

### Replace soft boundaries with hard boundaries plus signposts

Deprecation warnings that hope the developer will migrate. Abstract classes that trust no one will instantiate them. Internal APIs relying on the convention "you shouldn't use this." These are boundaries enforced by social contract. The suggestible actor does not read social contracts. It walks through the "DO NOT ENTER" sign because the door was unlocked.

For boundaries that matter, make them genuinely impassable (compile-time enforcement, runtime rejection, capability restrictions), then attach a signpost telling the agent what to do instead. For boundaries not worth enforcing, the suggestible actor will cross them. They are not boundaries anymore. Accept them as part of your system's state space.

Principle: Only hard boundaries exist and when they are hit, provide clear alternatives.

### Write documentation and conventions as if they will be executed

To steer the agent, documentation must exist within its local context: inline comments adjacent to the code it will modify, docstrings on the functions it will call, unit test failure messages, READMEs precise enough for the agent to follow step by step. It will follow your docs more literally than most humans will.

The same applies to conventions. The suggestible actor cannot absorb norms through osmosis. Project templates, linters, and consistent directory structure encode convention at the tooling level. The agent complies with linters because violations are errors, and errors are the feedback it is most susceptible to.

Principle: Comments in code are vectors for prompt injection. Specifications are implementation contracts. Be explicit.

### Close the directive gap

When the directive gap is wide, the agent confabulates. Close it.

CI/CD gates should report not just what failed but what to do about it. Pre-commit hooks should provide the correct alternative, not just reject the incorrect one. An `AGENTS.md` or `CONTRIBUTING.md` should encode the ambient knowledge that a human developer would carry. Example code near the API surface, type signatures that make the correct shape unambiguous, factory methods with correct defaults, named parameters that make intent explicit at the call site: all of these make the correct answer locally available so the agent never needs to invent one.

Principle: [Convert ambient knowledge into local context](/garden/ambient-to-local/).

---

The suggestible actor is already operating in your codebase. It is calling your APIs, reading your documentation, and hitting your error messages. It has no intent to respect your design philosophy and no judgment to interpret your ergonomic signals.

But it is susceptible to local context. And that is a lever.
