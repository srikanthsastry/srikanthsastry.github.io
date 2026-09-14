---

title: "The Consenting Adults Problem"
published: 2026-09-14
series: 'suggestible-actor'
series_order: 5
series_label: 'The Suggestible Actor'
tags:
  - 'software engineering'
  - 'AI'
  - 'mental models'
abbrlink: 'the-consenting-adults-problem'
image: /assets/images/consenting-adults-cover.webp
lang: ''
excerpt: >
  Permissive languages assumed a consenting adult at the keyboard. AI agents are not consenting adults. The way out is deterministic enforcement: checkers the agent cannot move, and types that make the disallowed unwritable.
categories:
- Professional

---

With AI Agents writing a huge fraction of software we are starting to see large cracks in the integrity of the software development process itself. It all stems from the fundamental assumption that the software development process is executed by humans, and that is no longer true with AI Agents. I previously characterized AI Agents as [Suggestible Actors](/the-suggestible-actor/) that are [locally reasoning, suggestible when stuck, and confabulate under uncertainty](/garden/suggestible-actor-properties/). I have talked about various aspects of these cracks before: [Guardrail erosion](/the-guardrail-erosion-problem-with-ai-agents/) ([note](/garden/guardrail-erosion-meta-problem/)), [Architecture Orphaning](/the-architecture-orphaning-problem-with-ai-agents/), and [the hidden directive gap](/the-hidden-directive-gap/). In this post, I talk about a new crack that seems to be spreading through our codebases. Ironically, the source of this crack is the very same feature of languages that made them insanely popular: a weakened type system. Languages such as Python and JavaScript have weakly enforced type systems (if at all) with easy escape hatches. The AI Agents treat them as invitations for coercive violence against codebases. I call this "[the consenting adults problem](/garden/consenting-adults-language-philosophy/)".

## We are all consenting adults here

Let's start with two of the most popular languages today: Python and JS. They both have weak typing, at best. Python's philosophy is that the programmer knows what they are doing and gives them a lot of freedom in how they use the language and constructs within it. There are no access modifiers, and you use underscore conventions instead of visibility rules. Similarly, in JS, types are inferred at runtime and provide virtually no enforcement. These languages explicitly do not prevent you from doing dangerous things because it assumes good judgement from the author.

This philosophy and associated attributes of the language are a feature, and not a bug. These are expressive, accessible, and fast to prototype, which makes them wildly popular.
And it works when the author is a human and is designing the system with [conceptual integrity](https://en.wikipedia.org/wiki/The_Mythical_Man-Month#Conceptual_integrity_); they understand that without such conceptual integrity, which lives outside the system, [the essential complexity](/garden/essential-complexity-makes-software-ungovernable/) makes software near-impossible to maintain. In essence, these languages are useful only when the author is a "consenting adult" (aka "responsible user").

## Suggestible Actor `is not` Consenting Adult

A suggestible actor (my model for an AI agent) is goal oriented and locally reasoning, which means that the actor is trying to accomplish a goal, but does not have a good understanding of the conceptual integrity that underpins the system. When working with a weakly typed codebase, such an actor cannot reliably see system-level consequences of bypassing encapsulation boundaries that were laid down by conventions alone. In pursuit of its goal, if it encounters an obstacle, it becomes highly susceptible to suggestions from its local context, and if that local context permits breaking the conceptually intended boundary, the AI agent *will* break that boundary.

### Does this argument hold only for weakly typed languages and not for strongly typed ones such as Java or Rust?

The argument does hold for strongly typed languages, but in a different form. Let's consider dynamically typed languages such as JavaScript, statically (but weakly) typed languages such as Python (with strict type hints), and strongly typed languages such as Rust. In all cases, the AI agent does not have a reliable notion of conceptual integrity (that lies only in the head of the human developers).

In statically (but weakly) typed languages, type widening is often an escape hatch employed by humans for very specific and constrained situations. AI Agents, on the other hand, treat it as a "get-out-of-jail-free" card and flood the zone with it. A [recent study by Lee et al.](https://dl.acm.org/doi/10.1145/3793302.3793578) across TypeScript PRs found that AI Agents use the `any` type widening escape hatch 9x more frequently than human authors. Static types exist for a reason and AI Agents are becoming good at undermining them without regard.

In strongly typed languages, you *can* encode large parts of that conceptual integrity into the types, and then the compiler will enforce that encoding by enforcing those types. Dynamically typed languages lack such enforcement and don't even need any escape hatches. Naturally, such codebases are acutely susceptible to [guardrail erosion](/the-guardrail-erosion-problem-with-ai-agents/) ([note](/garden/guardrail-erosion-meta-problem/)).

With strongly typed languages, the failure mode is a couple of levels above in the architecture layer. I explored this in the [Architecture Orphaning](/the-architecture-orphaning-problem-with-ai-agents/) post where I argue that the *locally reasoning* property of Suggestible Actor makes it susceptible to silent architecture drift even with strongly typed languages.

### Why not encode the rules that define the conceptual integrity into the AI Agent's context; wouldn't that address the issue?

A markdown file specifying the conceptual integrity of the system being mutated looks like a good antidote to this problem. However, two properties of the [Suggestible Actor](/garden/suggestible-actor-properties/) render it ineffective: Local Reasoning, and Confabulation under Uncertainty. Every AI Agent has a fixed size context window, and when it fills up, it 'compacts', which is an inherently lossy process. So, if you load the context initially with all the information about your system, as the Agent progresses through its task, as its context window fills up, it *will* compact that information away. In fact, the longer the Agent iterates on the task, the more likely it is to lose this information. Once this information is lost and no longer 'local', the *locally reasoning* Agent is no longer directed by it. Beyond that, when the Agent encounters an unexpected impediment (e.g., bug, assertion failure, etc.), it will make something up as part of its *confabulation under uncertainty*.

This was empirically observed by Dente et al. in [Constraint Decay](https://arxiv.org/abs/2605.06445v1), and they found that the AI Agent's performance gets worse with such added rules! On my reading, that's because the initial context is flooded with rules which cannot be verified until the end, and so the AI Agent has less available context to work with initially, resulting in lower initial performance, and since the rules have been compacted away, it cannot verify those rules in the end, leading to poor corrective behavior.

### How do strong static types with forced compiler checks help?

A strong compiler forces clearer and less ambiguous code from the AI agent than a weaker typed system would simply paper over. For instance, TypeScript imposes fewer restrictions and gives you easy escape hatches that an AI agent can use to generate code that introduces data races that compile, run, only fail intermittently. In contrast, the Rust compiler statically enforces ownership and borrowing rules that exclude broad classes of memory errors and data races. Safe code cannot violate them. Any escape hatches that Rust provides are very clunky and puts the AI Agent into states with larger uncertainty; so, the AI Agent's simplest path to success is to actually write correct code.

## Proposal: two towers

We are not going to stop using AI for code generation. What we need is a mechanism to prevent a suggestible actor from exploiting the hidden directive gap and decaying the orphaned code architecture. Our primary defense is to deploy structural guardrails, which are robust against the agents' guardrail erosion. Here, I propose two such structural guardrails: [deterministic checkers](/garden/deterministic-checkers/), and [encoding patterns and constraints via type narrowing](/garden/patterns-as-enforceable-types/).

### Tower one: deterministic checkers

We don't need more "intelligence" to address the decay, we just need stronger checkers. Importantly, these checkers should not be accessible to the session in which the AI Agent is generating/modifying code. Examples of such checkers include visibility rules in the build system, compilers, CI systems, etc. Let's consider some concrete examples.

Consider Bazel's BUILD files. What if we put BUILD files, or more specifically, visibility rules in the BUILD files, outside the purview of an agent that is modifying the functional code. Effectively, you are now separating the visibility and accessibility contract from the functional implementation.  Here is an illustration.

```python
package(default_visibility = ["//visibility:private"])

rust_library(
    name = "ledger",
    srcs = ["src/ledger.rs"],
    edition = "2021",
    visibility = [
        "//billing:__pkg__",
        "//refunds:__pkg__",
    ],
)
```

This makes the `ledger` target visible only to billing and refunds. If any agent edits the code to take a dependency on it outside those modules, the build will simply fail even before the compiler runs. This helps keep your API boundaries sane. *This only works if the agent cannot modify the BUILD file in the same session. If the agent can edit the BUILD file as well, then all bets are off.*

Another example is precondition checks. If your precondition checks can be placed outside the boundary within which an agent can edit functional code, then the agent cannot silently decay your constraints. You can allow agents to edit those preconditions, but only as a separate distinct change that requires human approvals. Such changes tend to be low-volume (if these changes are high-volume, then that's a code smell for bad design) and so HITL is feasible.

### Tower two: constraints via type narrowing

You can encode your constraints and patterns into types and then let the compiler (or any other kind of deterministic checker such as static analysis or linters) take care of enforcing those constraints. Here are some examples.

#### **Example 1: Browser names are strings, but not all strings are browser names.**

Typically, browser names are passed in as strings.

```rust
fn render(browser: &str) {}

render("chrome");    // ok
render("netscape");  // compiles, fails later at runtime
```

However, this has the unfortunate side effect of allowing bad browser names at build time, only to fail at runtime. Instead, what if we narrowed the type from string to a concrete browser name type? In Rust, that would be an enum.

```rust
enum Browser { Chrome, Firefox, Safari } // extend as needed

fn render(b: Browser) {}

render(Browser::Chrome);   // ok
render("netscape");        // compile error: expected Browser, found &str
```

No variant exists for an unsupported browser, so there is nothing to construct. The unsupported shape has no type to pass.

#### **Example 2: Order Id and User Id are both u64s, and yet distinct types**

Unique ids are often generated by your database as u64 integers regardless of what they semantically represent. Your code often follows this built-in type. So, you end up with code that looks as follows.

```rust
fn get_user(id: &u64) {}

let order_id: u64 = 1732047610;
get_user(&order_id); // compiles, wrong id family, wrong data
```

The above code will compile, and the subtle bug where you passed in an order id instead of the user id could go uncaught. An AI agent will not hesitate to exploit this ambiguity if it serves its immediate goal, regardless of the externalities.

Instead, consider

Newtype case:

```rust
struct UserId(u64);
struct OrderId(u64);

fn get_user(id: &UserId) {}

let order_id = OrderId(1732047610);
get_user(&order_id); // compile error: expected &UserId, found &OrderId
```

And just like that, an entire class of potential bugs of swapping ids types disappears into compiler errors. From here on, ids arrive as `OrderId`, not `u64`.

#### **Example 3: order flow as typestate**

You can encode lifecycles into types as well. Continuing the previous example, consider the order status that can only go from pending to paid to shipped. If you just model the status as a string, then you can run into errors of the following type.

```rust
struct Order { status: String }

let mut order = Order { status: "pending".into() };
order.status = "shipped".into(); // skips pay, compiles
```

Your AI agents could well introduce bugs through incorrect state transitions to fix an issue or add an "optimization". Instead, if the states and their transitions were encoded into the types, then the problem disappears. Here is an illustration.

```rust
struct Pending; struct Paid; struct Shipped;
struct Order<S> { _state: std::marker::PhantomData<S> }

impl Order<Pending> {
    fn pay(self) -> Order<Paid> { Order { _state: std::marker::PhantomData } }
}
impl Order<Paid> {
    fn ship(self) -> Order<Shipped> { Order { _state: std::marker::PhantomData } }
}

let order = Order::<Pending> { _state: std::marker::PhantomData };
let order = order.ship(); // compile error: no method `ship` on Order<Pending>
```

The invalid transition has no method, so it cannot be written. The model can only call transitions that exist.

Obviously, we could go on with more detailed examples and patterns, but I think these should suffice.

## Open questions and predictions

Assuming that the consenting adults problem is very real, and that strong types with structural guardrails are the way out, where does that leave us with the current state of our codebases? Will loosely typed languages such as Python, JS, and TypeScript survive the AI authored era?

My prediction is that we are not close to AI Agents acquiring conceptual integrity in any durable fashion (that will not be compacted away). Given that, I expect the following to happen.

1. Languages with loose typing will have to evolve stronger types. "Consenting adults" as a model does not survive if the author is not an adult. If stronger types do not emerge, then these languages will be relegated to codebases of smaller sizes that can all be held within the LLM's context window.
2. Languages with strong types (such as Rust) will see their popularity rise. Larger codebases will migrate towards such languages. The more a compiler can do for you, the more reliable the software will be when authored by agents.
3. Build toolchains will go through an inflection point where they graduate from being a simple expression of pre-configured steps to a DSL that encodes large parts of conceptual integrity and enforce them as structural guardrails.

These are strong predictions, but as always, weakly held. Let's see what the next generations of models and agents offer, and I will revise my predictions accordingly.
