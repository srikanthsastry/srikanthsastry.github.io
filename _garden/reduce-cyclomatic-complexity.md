---
title: "Reduce Cyclomatic Complexity"
garden_type: note
maturity: evergreen
tags: [software-design, refactoring, code-quality, cyclomatic-complexity]
created: 2026-04-27
related_posts:
  - /reduce-cyclomatic-complexity/
related_notes:
  - testability-drives-design
excerpt_text: >
  Cyclomatic complexity measures independent execution paths through a function. High complexity means more branches, more bugs, more cognitive load.
---

**Cyclomatic complexity measures independent execution paths through a function.** High complexity means more branches, more test scenarios for coverage, and more cognitive load. Functions with deeply nested conditionals and multiple branching paths are bug factories. Hard to read, hard to [test](/garden/testability-drives-design/), hard to maintain.

The fix is usually straightforward: extract branching logic into well-named helpers, flatten nested conditionals, simplify boolean expressions. A function with cyclomatic complexity 4 can often be reduced to 2 with 60 seconds of refactoring. Fewer paths, fewer bugs, happier teammates.
