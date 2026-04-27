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
  Cyclomatic complexity measures the number of independent execution paths through a function.
---

Cyclomatic complexity measures the number of independent execution paths through a function. High complexity means more branches, more test scenarios needed for coverage, and more cognitive load to understand the code.

Functions with deeply nested if-else blocks, loops with breaks/continues, and multiple branching paths are bug factories — hard to read, hard to test, hard to maintain. Yet engineers routinely normalize this overhead.

The fix is usually straightforward: extract branching logic into well-named helper functions, flatten nested conditionals, and simplify boolean expressions. A function with cyclomatic complexity 4 can often be reduced to 2 with 60 seconds of refactoring — fewer paths, fewer bugs, happier teammates.
