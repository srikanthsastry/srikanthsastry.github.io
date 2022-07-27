---
title: "The big WHY about unit tests"
date: 2022-06-06
id: 20220606093603
tags:
  - "unit tests"
  - testing
  - "software engineering"
categories:
  - professional
layout: post
permalink: /the-big-why-about-unit-tests/
excerpt: >
  The ultimate "why" for unit tests is maintainability. All the arguments for having robust, good quality unit tests comes down to the following. Unit tests help keep your production code maintainable. Looking at maintainability as the primary motivation for unit tests allows us to look at some aspects of unit tests differently.
...
![Why unit test?](/images/question_mark_person_leaning.png)
When you ask "why do we write need unit tests?", you will get several answers including
- To find common bugs in your code
- [As protection against regression]({% post_url 2017-11-12-the-merits-of-unit-tests-part-2 %})
- [To act as a de facto documentation of your code]({%post_url 2017-11-01-merits-of-unit-tests-part-1 %})
- [To help improve software design]({%post_url 2017-11-22-the-merits-of-unit-tests-part-3 %})
- [To help debug issues in production]({% post_url 2017-11-28-unit-tests-ftw-part-4 %})
- [Improve your APIs' usability]({% post_url 2017-12-28-merits-of-unit-tests-part-5 %})
- etc.

These seems like a collection of very good reasons, but it seems inelegant to state that the common phenomenon of unit testing has such disparate causes. 
There must be a 'higher' cause for writing unit tests. I argue that this cause is "maintainability". 

### Maintainability
![Maintainable software](/images/website-wrench-cog.png)
Here is a potentially provocative statement; "The final cause of unit tests is software maintainability".
To put it differently, if your software was immutable and could not be altered in any way, then that software does not need any unit tests.

Given that almost all software is mutable, unit tests exist to ensure that we can mutate the software to improve upon its utility in a sustainable manner. All the aforementioned answers to the question "why do we write unit tests" are ultimately subsumed by the cause of maintainability.

- Unit tests help you find bugs in your code, thus allowing safe mutations that add functionality.
- Unit tests protect against regression, especially when refactoring, thus allowing safe mutation of the software in preparation for functional changes.
- Unit tests act as de facto documentation. It allows developers who change the code to communicate across time and space on how best to use existing code for mutating other code.
- Unit tests help improve software design. It some code/class is difficult to unit test, then the software design is poor. So, you iterate until unit testing becomes easier. 
- Unit test help improve the usability of your API. Unit tests are the first customers of your API. If unit tests using your API are inelegant, then you iterate towards more usuable APIs. A more usable API is often a more used API, and thus, aids software evolution.

Interestingly, looking at maintainability as the primary motivation for unit tests allows us to look at some aspects of unit tests differently.

### Looking at unit tests differently

#### Unit tests incur a maintenance cost.
![](/images/calculator-sheet.png)

If it code incurs a maintenance cost, and unit tests help reduce that cost, then you can naturally ask the following; _since unit tests are also code, do they not incur a maintenance cost?_

Obviously the answer to the question above is an unequivocal "yes!". Thus, unit tests are only useful if the cost of maintaining them DOES NOT EXCEED the savings they provide as a buttress against production code. This observation has significant implications for how to design and write unit tests. For instance, unit tests must be simple straight line code that is human readable, even at the expense of performance and redundancy. See the post on [DRY unit tests](https://srikanth.sastry.name/dry-unit-tests-are-bad/) for a more detailed treatment on this topic.

#### Unit tests can have diminishing returns.
![](/images/down-graph-arrow.png)

If unit tests incur a maintenance cost, then their utility is the difference between the maintainability they provide and the cost they incur. Since software is a living/evolving entity, both this utility changes over time. Consequently, if you are not careful with your tests, then could become the proverbial Albatross across your neck.
   Consequently, it is important to tend to your unit test suite and pay attention when the utility of a test starts to diminish. Importantly, refactor your tests to ensure that you do not hit the point of diminishing, or even negative returns on your unit test.

#### Unit tests should be cognitively simple.
![](/images/simple-chair-wall-painting-white.png)
   
An almost necessary way to reduce the maintenance cost of a unit tests is to make it very simple to read and understand. It helps with maintenance in two ways. First, it makes it easy to understand the intent of the test, and the coverage that the test provides. Second, it makes it easy to modify the test (if needed) without having to worry about an unintended consequences such modifications might have; a degenerate case is that of tests that have hit the point of diminishing returns; more simple a test is, the easier it is to refactor and/or delete it. See the post on [DRY unit tests](https://srikanth.sastry.name/dry-unit-tests-are-bad/) for mote details.
   
#### A bad unit test is worse than no unit test.
![](/images/sad-face-spray-paint.png)
  
If unit test incur a maintenance cost, then a bad unit test has all the costs associated with unit tests and none of the benefits. It is a net loss. Your code base is much better off without that unit test. In fact, a bad unit test can have an even higher cost if it sends developers on a wild goose chase looking for bugs when such unit tests fail. So, unless a unit test is of high quality, don't bother with it. Just delete it.
  
#### A flaky unit test is the worst.
![](/images/yes-no.png)

This is a corollary of the previous observation, but deserves some explanation. Flaky tests have the side effect of undermining the trust in the entire test suite. If a test is flaky, then developers are more likely to ignore red builds, because 'that flaky test is the culprit, and so the failure can be ignored'. However, inevitably, some legitimate failure does occur. But, at this point, developers have been conditioned to ignore build/test failures. Consequently, a buggy commit makes it's way to prod and causes a regression, which would never have happened if you didn't have that flaky test.
