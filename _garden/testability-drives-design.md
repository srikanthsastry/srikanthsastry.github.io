---
title: "Testability Drives Design"
garden_type: note
maturity: evergreen
tags: [software-testing, unit-tests, software-design, modularity, dependency-injection]
created: 2026-04-27
related_posts:
  - /the-merits-of-unit-tests-part-3/
related_notes:
  - tests-as-executable-documentation
  - tests-as-refactoring-safety-net
excerpt_text: >
  The act of writing unit tests exerts design pressure that improves software quality in two complementary ways: enforcing modularity and forcing healthy dependency injection.
---

The act of writing unit tests exerts design pressure that improves software quality in two complementary ways: enforcing modularity and forcing healthy dependency injection.

## Modularity pressure

If a class or method is hard to test, it's doing too much. The symptoms are diagnostic:

- **Too many input combinations** → methods have too many responsibilities
- **Too many operation orderings** → methods have too many side effects
- **Combinatorial explosion of test cases** → the class conflates concerns that should be separate

The cure is extraction. When an anonymous inner class makes a containing class untestable, pulling it into its own class with its own tests makes both components simpler, more readable, and more maintainable.

## Dependency injection pressure

Code that constructs its own dependencies internally (e.g., `new ExternalService(...)` inside a method) is effectively untestable without expensive integration infrastructure. Writing tests forces you to inject dependencies from outside, which:

1. Makes the code testable with mock/stub substitutions
2. Makes the code more flexible for production use (swap implementations)
3. Makes dependencies explicit rather than hidden

This is testability as a *design heuristic*, not just a verification mechanism. Hard-to-test code is a code smell. The tests aren't just checking behavior — they're revealing structural problems.
