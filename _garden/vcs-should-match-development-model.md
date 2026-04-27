---
title: "VCS Should Match Your Development Model"
garden_type: note
maturity: evergreen
tags: [software-engineering, version-control, git, trunk-based-development]
created: 2026-04-27
related_posts:
  - /git-may-not-be-the-best-for-saas-companies/
related_notes:
  - survival-vs-excellence-modes
excerpt_text: >
  Git's design assumptions (distributed, branch-heavy, multi-repo friendly) conflict with the realities of SaaS development in medium-to-large enterprises, where the dominant pattern is trunk-based development with continuous deployment.
---

Git's design assumptions (distributed, branch-heavy, multi-repo friendly) conflict with the realities of SaaS development in medium-to-large enterprises, where the dominant pattern is trunk-based development with continuous deployment.

The mismatch manifests in four ways:

1. **Scaling** — Git serializes commits, so large teams resort to feature branches as a workaround, adding overhead that's unnecessary when you're only releasing from trunk.
2. **Unnecessary branching** — "Never commit to master" becomes dogma, but in continuous-deploy SaaS, you *want* every change on trunk ASAP. Branches delay integration and encourage large, risky merges.
3. **Complexity** — Git exposes too much power (history rewriting, detached HEADs, merge vs. rebase debates) to developers who just want to commit code. The tool gets in the way.
4. **Multi-repo bias** — Git's poor large-repo performance pushes teams toward multi-repo setups, which fragment API definitions and make cross-service coordination harder. Monorepo + microservices is a valid pattern that Git discourages.

The deeper principle: your version control system should be chosen to fit your development and deployment model, not the other way around. When teams spend more time working around their VCS than writing software, the tool has become the problem.
