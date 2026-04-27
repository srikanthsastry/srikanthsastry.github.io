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
  Your version control system should fit your development model, not the other way around.
---

**Your version control system should fit your development model, not the other way around.** Git's design assumptions — distributed, branch-heavy, multi-repo friendly — conflict with how most SaaS companies actually work: trunk-based development with continuous deployment. Git serializes commits (forcing unnecessary feature branches), encourages branching when you want every change on trunk ASAP, exposes too much power to developers who just want to commit code, and discourages monorepos despite their value for cross-service coordination.

When teams spend more time working around their VCS than writing software, the tool has become the problem.
