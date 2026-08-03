---
title: "The Hidden Directive Gap"
published: 2026-08-03
series: 'suggestible-actor'
series_order: 4
series_label: 'The Suggestible Actor'
tags:
  - 'software engineering'
  - 'AI'
  - 'mental models'
  - 'spec-driven-development'
abbrlink: 'the-hidden-directive-gap'
image: /assets/images/hidden-directive-gap-cover.webp
lang: ''
excerpt: >
  Spec-Driven Development shifts the job from writing code to defining what correct means. But it hides a trap: the spec looks stable until you change the model. The fix is to treat spec and code as co-artifacts and use the new model as an observer.
categories:
  - Professional
---

AI coding agents appear to unlock the promise of converting natural language to code; that's the whole value proposition of "vibe coding". But if this should be taken with any seriousness, we need sufficient rigor behind it. The so-called Spec Driven Development (SDD) is one attempt at that rigor, and it holds promise. However, it does have its blind spots. I talked about *Architecture Orphaning* as one such blind spot previously. Here, I introduce you to another one: the hidden directive gap. Just like with architecture orphaning, there are ways to augment SDD to mitigate it.

![Spec casts different code shadows depending on model light - anime style](/assets/images/hidden-directive-gap-diagram.webp)

## Directive gap

Directive Gap is the inherent ambiguity that separates human intention from the system behavior that implements that intention. This is not a new problem. It has been studied for a long time. The holy grail is a process/tool that can capture human intent as specifications and convert it into software without losing any fidelity. There have been many attempts at it: Design by Contract (Meyer/Eiffel), Z notation, VDM, CASE tools, Model-Driven Development, *etc.* The paradigm they all followed was to eliminate ambiguity from specifications so that these specifications can be converted into software with precision and determinism. They all failed for the same reason. Eliminating ambiguity made the specification language so complex that the spec itself becomes a programming language. So now you have to pay the cost twice: once developing a complex and detailed spec, and again in maintaining and executing the program.

AI coding agents appear to side step this issue by resolving a lot of ambiguity 'correctly' enough to make natural language a 'good enough' simulacrum of a formal specification. SDD takes the LLM agent as a node in an iterative loop of starting with the spec, generating code, running tests, refining the spec to eliminate failures, and rinse and repeat until failures disappear.

Now you don't have to pay twice. You just iterate on the spec. Conversion to code is cheap. This makes SDD a directionally right attempt at converting intention to behavior. It shifts the responsibility of the software engineer from "write code" to "define what 'correct' means". But there is a problem. As one executes the SDD process, how do you know that you are done; how many iterations are enough; when can we say that the directive gap is closed?

## The termination problem

Let's look at the information we have available to decide if we have iterated enough in SDD. We have the spec, the code, and the tests. The AI agent/LLM model is a constant. A natural stopping point is when the code passes all the tests. After all, the tests are the signal we use to determine how to refine the spec. If the tests pass, then we have no signal to refine the spec. So we should be done. Sure, there might be bugs, but that's true of even human authored code. At worst, code quality now has parity with human authored code, and all the humans have to do is maintain the specs that are easier to understand and manipulate. If only!

Notice the assumption smuggled into the previous paragraph: the LLM model is a constant. While that might be true during an SDD session across all iterations, it is not true in general. Every few months some AI lab releases a new model, and it promises to be better than all other models that came before it. What happens when you switch the model? Say, that your spec for a job scheduler was iterated meticulously through SDD on Claude Opus 5, and your employer decided to switch over to Codex 5.6. Would the spec produce the same code with Codex 5.6? In fact, the chances are that the code produced by Codex 5.6 will actually fail at least one test whereas they all passed with the same spec on Claude Opus 5.

This is not speculation. Wasowski ran precisely such an experiment and talked about it in his post ["Stop Writing Specs. Start Writing Facts. The Entire SDD Movement Is Already Obsolete."](https://medium.com/@jaroslaw-wasowski) His spec needed constant 'refinement' as he upgraded across Claude Sonnet 3.5, 3.7, 4, and Opus 4.5+. The spec that worked in the previous model produced incorrect code in the new model. The tests, on the other hand, stayed constant.

Folks from AWS discovered a mathematical limitation of closing the directive gap. In their ["Fidelity Probes" paper](https://arxiv.org/abs/2605.17246), Erata et al. found that if a single iteration has a non-zero base rate of generating code that doesn't completely align with the spec, then there is a non-zero lower bound on the 'error/gap' between the spec and code across multiple iterations.

I ask again: how do you know you are done?

## The hidden gap

The spec is unstable relative to different AI models. But (spec, model) combination is stable. That is the key observation of focus on. Why is that the case; why is (spec, model) stable, but spec alone is not? The answer comes back to the directive gap. When iterating on a spec with a given model, the fixed point that you reach is NOT a signal that the directive gap is closed; instead, it is really a signal that the *model has hidden the directive gap through confabulation*.

In some ways, the problem is worse than before. The spec-based development before AI agents exposed the directive gap no matter how nuanced, so that you knew where your spec was deficient. AI agents now hide any directive gap below a threshold and are only revealed when the model changes. This lulls you into a false sense of security with a rude awakening on the other side of a model upgrade.

How do you address this hidden gap? If you try to make the spec detailed enough to be model independent then (a) you have no idea if you have actually succeeded, and (b) spec becomes as detailed as the programming language itself, and is effectively self-defeating. Instead, I suggest a reframed approach: *what if, instead of treating spec as the primary artifact, we treated both spec and code as co-artifacts, and we measured mutual fidelity using the AI agent?*

## The "reverse pass": AI agent as an observer

In this reframed approach, you start the same as any SDD iteration. You continually refine the spec until you have reached a fixed point, where all the tests pass and the code generated by AI matches the spec's intent. Let's call this the "forward pass", where you go from the spec to code. Instead of stopping here, you turn the AI agent's gaze backward, and ask it the question: "does the implementation/code conform to the spec, and if not, what are the deviations?".  This is the "reverse pass"; an addendum to SDD. In this step, you are now using the AI agent as an observer and not as an implementer.

Now, the first time you are doing this, if you have followed the SDD process correctly, the answer to this question from the AI agent is "yes, the implementation conforms to the spec, and there are no deviations." However, this is not going to be the case in the future, with model upgrades. For now, let's start with the pair `(spec, code)` as co-artifacts. We expect this to be stable for a given model. All changes/bug fixes are going to be through spec changes or addendums, but with the same model. Since the model is constant, the "reverse pass" should still continue to say that the implementation conforms to the spec.

## Model upgrades: reconciliation via the "reverse pass"

When you perform the inevitable model upgrade. The `(spec, code)` co-artifacts are no longer stable. Before you start any new development or change the spec, the first thing you do is perform a "reverse pass" with the new model. In effect, you ask the new model/agent "does the implementation/code conform to the spec, and if not, what are the deviations?", and this time, the agent will respond back with a set of deviations of the code from the spec; the new model will interpret the spec differently from the old model. This is part of your *hidden directive gap made visible*.

Here is often where SDD breaks down with complaints of unstable specs. With the reverse pass result, your co-artifacts evolve from `(spec, code)` to `(spec, code, deviations, model)`. This is the true artifact of the modified SDD process. In fact, it was always `(spec, code, deviations, model)`, but the first time around, the model was implied, and the deviations were null by construction.
At this point, you have some options.

1. Since the code is "correct", you can simply record those deviations as part of the SDD artifact and make those observed deviation part of the spec itself, and so `spec + deviations` becomes the new spec.
2. Alternatively, you can review those deviations, and see if they reveal true gaps in the implementation; if so, you now refine your spec to account for the deviations and run another set of SDD iterations until the "reverse pass" produces no more deviations.

Either way, you eventually converge back to `(spec, code)` as co-artifacts with a null for `deviations` and the `model` is implied.

The important thing to observe is that a model upgrade now looks a lot like a compiler upgrade or a language upgrade. Just like existing code needs to be changed when you go from one version of the compiler to another (especially when the compiler changes are not backward compatible), you are essentially doing the same thing when upgrading the AI model. This is precisely why the spec and code are co-artifacts with the model as the implied constant and the deviations ("reverse pass" results) as a transient artifact through such upgrades.

## Why aren't tests enough?

What value does a reverse pass add on top of a robust test suite? Both serve different purposes. The tests are there to ensure that the code's behavior meets the requirements, whereas the reverse pass is there to reveal any directive gaps that have now become visible. Examples of issues that a reverse pass catches, but tests miss include implementation inefficiency, output instability (at scale), and missed invariants and preconditions. Here are illustrations for each.

*Implementation inefficiency.* If the implementation uses sort to get top-k, the tests will still pass, despite an $n log(n)$ implementation instead of a $k log (n)$ implementation. A reverse pass would catch that.

*Output instability. *Say, in Javascript, the code uses `Array.sort()` and the test cases verified the expected output to be correct. However, `Array.sort()` does not provide stable outputs, and unless the test suite was specifically looking for such stability, it will likely miss it. In fact, to even think of such a test, one would have to have known about the properties of `Array.sort()`; so, either the generated code does not use `Array.sort()`, or if it does, it will likely miss the tests for stability. A reverse pass would catch it as part of its semantic analysis of the code against the spec.

*Missed invariants.* Similar arguments apply for invariant checks as well. During forward passes, the spec goes through semantic analysis, and code is checked against tests. The rigor of semantic analysis of the code is higher in a reverse pass, and so, reverse pass is more likely to spot such invariant violations that tests can miss.

## What does the SDD addendum look like?

Bringing it all back together, I propose the following addendums to Spec Driven Development.

1. The development process starts much like a regular SDD session with multiple iterations from spec to code to tests, and back to refining the specs which produce 'better' code until you have converged to a spec and the code that passes all the tests and is empirically 'correct'.
2. At this point, instead of treating either the spec or the code as the 'primary artifact', you treat both the spec and the code as co-artifacts. You commit both to your repo. Spec denotes the intent and the code describes the behavior. However, it is important to realize that this (spec, code) co-artifacts are stable only relative to the current model and harness.
3. Every time the AI model or harness changes, the (spec, code) artifacts may no longer be stable. However, it is important to note that the code's behavior is still empirically correct. Through a model/harness upgrade, we run a "reverse pass" and ask the new model/harness "does the code implement the spec, and if not, what deviations do you see between the spec and the code". This generates a report with observed deviations.
4. These deviations are either material to the system behavior, or incidental to model interpretation. In case of the former, we go through another round of regular SDD session to converge between the spec and the code. In case of the latter, we simply append the spec with the deviations so that future changes to specs does not result in code churn due to the incidental deviations.

The hidden directive gap does not go away. The fix is to stop pretending the spec alone is the artifact. Hold spec and code together, use the new model as an observer that makes its own reading visible, triage the delta. Model upgrades now look no different from third party library updates, or compiler updates, and that is something we know how to do well.
