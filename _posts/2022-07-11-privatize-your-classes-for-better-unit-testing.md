---
title: "'Privatize' your classes for better unit testing"
date: 2022-07-11
id: 20220711091101
tags:
  - "unit tests"
  - "software engineering"
  - "refactoring"
categories:
  - Professional
layout: post
permalink: /privatize-your-classes-for-better-unit-testing/
image: /images/amber-iceberg-under-water.jpg
...
<!-- ![](images/amber-iceberg-under-water.jpg) -->
You service may be massive, but it's public API surface is pretty small; it has just a handful of APIs/endpoints. Everything else behind those APIs are 'private' and 'implementation details'. It is highly advisable to follow this pattern even when designing the implementation of your service, almost like a fractal. This will pay dividends in the quality of your test suite.

For instance, you service implementation should be split into 'modules' where each module has a well defined API through which other modules interact with it. This API boundary has to be strict. Avoid the temptation of breaking this abstraction because your module need this 'one tiny bit' of information that is available inside the implementation of another module. You will regret breaking encapsulation, I guarantee it!

If you follow this pattern, you will eventually reach a class that has a public API, has all of its external/shared dependencies shared, and delegates a lot of it's business logic and complex computation to multiple 'private' classes that are practically hermetic and have no external/shared dependencies. At this point, treat all these 'private' classes as, well, private. That is, DO NOT WRITE UNIT TESTS FOR SUCH CLASSES!

Yes, that statement seems to fly in the face of all things sane about software testing, but it is a sane statement, nonetheless. These private classes should be tested indirectly via unit tests for the public class that they serve/support. This will make your tests a lot more accurate. Let me explain.

Say, you have a public class `CallMe` and it uses a private class `HideMe`, and furthermore, `HideMe` is used only by `CallMe`, and the software design enforces this restriction. Assume that both `CallMe` and `HideMe` have their own unit tests, and the tests do an excellent job. At this point, there is a new requirement that necessitates that we refactor `CallMe`'s implementation, and as part of that refactoring, we need to modify the API contract between `CallMe` and `HideMe`. Since `HideMe`'s only  caller is `CallMe`, it is completely safe to treat this API contract as an implementation detail and modify it as we see fit. Since we are modifying the specification of `HideMe`, we have to change the tests for `HideMe` as well. 

Now, you run the tests, and the tests for `HideMe` fail. What information does that give you? Does that mean that there is a bug in `HideMe`; or does it mean that we did not modify the tests correctly? You cannot determine this until you either manually inspect `HideMe`'s test code, or until you run the tests for `CallMe`. If `CallMe`'s tests fail, then (since this is a refactoring diff) there must be a bug in `HideMe` and/or `CallMe`, but if the tests don't fail, then it must be an issue in `HideMe`'s tests.

Thus, it turns out that the failure in `HideMe` tests gives you no additional information compared to failure in `CallMe`'s tests. Thus, tests for `HideMe` have zero benefits and a non-zero maintenance cost! In other words, testing `HideMe` directly is useless!

By aggressively refactoring your code to push as much of you logic into private classes, you are limiting the API surface of your software that needs direct testing, and simultaneously, ensuring that your tests suite is not too large, has very [high accuracy, with reasonable completeness]({% post_url 2022-06-13-unit-test-attributes-and-their-trade-offs %}).