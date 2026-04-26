---
title: "The Three Assumptions of C&C Governance"
garden_type: note
maturity: budding
tags: [governance, command-and-control, information-theory, original-framework, tech-industry]
created: 2026-04-26
related_posts:
  - /cargo-cult-governance/
related_notes:
  - isomorphic-mimicry-in-tech-governance
  - in-software-execution-is-decision-making
  - essential-complexity-makes-software-ungovernable
excerpt_text: >
  C&C governance rests on three implicit assumptions about the information pipeline. The tech industry structurally violates all three.
---

**C&C governance rests on three implicit assumptions about the information pipeline. The tech industry structurally violates all three.**

The three assumptions:

1. **Compression.** When information is summarized upward through the reporting chain, the compression preserves the signal that matters for decision-making. Theoretical grounding: Hayek (1945) on the irreducible locality of knowledge.

2. **Proxy validity.** The quantitative metrics available to decision-makers correlate with the reality they are managing. Theoretical grounding: Austin (1996) on measurement dysfunction. Partial measurement doesn't just miss what's unmeasured; it actively degrades it by redirecting effort.

3. **Separability.** Decision-making and execution are distinct activities that can be cleanly divided between levels of the hierarchy. Theoretical grounding: Brooks (1986) on essential vs. accidental complexity. In software, [execution IS decision-making](/garden/in-software-execution-is-decision-making/) because every act of building code is a design decision, and software decisions compound.

These assumptions hold in manufacturing, pharma, aviation, and military operations. They fail in tech because of [essential complexity](/garden/essential-complexity-makes-software-ungovernable/) (Brooks): the irreducible difficulty of the problem domain means information resists compression, metrics can't proxy for craft, and the decision/execution boundary doesn't exist.

Evolution: Originally formulated as four assumptions (adding fidelity). Fidelity was cut because it is a general organizational requirement, not C&C-specific. Any governance model fails if the reporting chain distorts information. The remaining three are specific to C&C's structural dependence on centralized decision-making.

The framework's contribution is diagnostic: it identifies *which* preconditions C&C depends on and shows that tech violates them structurally, not contingently. The mismatch is inherent in the domain, not fixable by better tools or smarter executives.
