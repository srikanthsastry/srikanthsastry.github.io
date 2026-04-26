---
title: "Essential Complexity Makes Software Ungovernable"
garden_type: note
maturity: evergreen
tags: [governance, software-engineering, essential-complexity, brooks]
created: 2026-04-25
related_posts:
  - /cargo-cult-governance/
related_notes:
  - three-assumptions-framework
  - in-software-execution-is-decision-making
  - isomorphic-mimicry-in-tech-governance
excerpt_text: >
  Essential complexity makes software organizations ungovernable from the top. The information executives need to make good decisions is precisely the information that can't survive the reporting chain.
---

**Essential complexity makes software organizations ungovernable from the top.**

Brooks argued that software's essential complexity — complexity inherent in the problem, not the tooling — makes software hard to *build*. The extension: it also makes software organizations hard to *manage* from the top. The information executives need to make good decisions is precisely the information that can't survive the reporting chain. Essential complexity is irreducible by definition. Any compression for upward communication is necessarily lossy in ways that matter. The executive who can't see the abstraction can't evaluate the decision about the abstraction.

This is the hinge of the [three assumptions framework](/garden/three-assumptions-framework/): essential complexity is why compression fails, why proxies can't capture what matters, and why the [decision/execution boundary](/garden/in-software-execution-is-decision-making/) doesn't exist in software. And the problem gets worse over time — as tooling eliminates accidental complexity, essential complexity dominates the signal, making the information pipeline less adequate, not more.
