---
title: "Git Conflicts with Trunk-Based SaaS Workflows"
garden_type: note
maturity: evergreen
tags: [software-engineering, version-control, git, trunk-based-development]
created: 2026-04-27
related_posts:
  - /git-may-not-be-the-best-for-saas-companies/
related_notes:
  - vcs-should-match-development-model
excerpt_text: >
  Git's distributed, branch-heavy design conflicts with trunk-based continuous deployment workflows.
---

**Git's distributed, branch-heavy design conflicts with trunk-based continuous deployment workflows.** Git serializes commits (forcing unnecessary feature branches), encourages branching when you want every change on trunk ASAP, exposes too much power to developers who just want to commit code, and discourages monorepos despite their value for cross-service coordination. These are not user-error problems. They are design assumptions baked into the tool that conflict with how most SaaS companies actually work.
