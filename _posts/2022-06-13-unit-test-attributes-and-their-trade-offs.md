---
title: "Primary attributes of unit test suites and their tradeoffs"
date: 2022-06-13
id: 20220612092019
tags:
  - "unit tests"
  - "software engineering"
categories:
  - professional
layout: post
permalink: /unit-test-attributes-and-their-trade-offs/
excerpt: >
  Unit test suites have three attributes: accuracy, completeness, and speed. 
  You can maximize any two, but not all three. 
  So how do you choose what to maximize?
...
![](/images/accuracy-completeness-speed.png)
Unit test suites have three primary attributes.

1. accuracy, 
2. completeness, and
3. speed. 

*Accuracy* says that if a test fails, then there is a bug. _Completeness_ says that if there is a bug, then a unit test will fail. _Speed_ says that tests will run 'fast'. These three attributes are in opposition with each other, and you can only satisfy any two of the three attributes!

Before discussing these attributes, it is important to note that they are not properties of test suite at rest, but rather, of the test suite during changes. That is, these attributes are measured only when you are making changes to the code and running the test suite in response to those changes. Also, these attributes are not applicable to a single unit test. Instead, they apply to the test suite as a whole. Furthermore, the quality of your test suite is determined by how well the suite measures up along these attributes.


### Attributes' descriptions
Let's describe each of these attributes, and then we can see any unit test suite is forced to trade off these attributes.

1. _Accuracy._ It is a measure of robustness of the test suite to changes in the production code. If you make a change to the production code _without changing your unit tests_, and your test suite has a failure, then how likely is it that your changes introduced a bug? Accuracy is a measure of this likelihood. High quality unit tests typically have very good accuracy. If your test suite has poor accuracy, then it suggests that either your tests are brittle, they are actually testing implementation details instead of functionality, or your production code is poorly designed with leaky abstractions. Inaccurate tests reduce your ability to detect regressions. They fail to provide early warning when a diff breaks existing functionality (because the developer cannot be sure that the test failure is a genuine bug, and not an artifact of test brittleness). As a result, developers are more likely to ignore test failure, or modify the tests to make it 'pass', and thus introduce bugs in their code.
2. _Completeness_. This is a measure of how comprehensive the test suite really is. If you make a change to the production code _without changing your unit tests_, and you introduce a bug in _an existing functionality_, then how likely is it that your test suite will fail? Completeness is a measure of this likelihood. A lot of the test coverage metrics try to mimic the completeness of your test suite. However, [we have seen how coverage metrics are often a poor proxy for completeness]({% post_url 2022-04-29-do-not-index-on-test-coverage %}).
3. _Speed_. This is simply a measure of how quickly a test suite runs. If tests are hermetic with the right use of [test doubles]({% post_url 2022-05-25-mocks-stubs-and-how-to-use-them %}), then each test runs pretty quickly. However, if the tests are of poor quality or the test suite is very large, then they can get pretty slow. It is most noticeable when you are iterating on a feature, and with each small change, you need to run the test suite that seems to take forever to complete. Slow tests can have a disproportionate impact on developer velocity. It will make developer less likely to run tests eagerly, it increases the time between iterations, and it increases the CI/CD latency to where the gap between your code landing and the changes making it to prod can be unreasonably large. If this gets bad enough, it will discourage developers from running tests as needed, and thus allow bugs to creep in.

### Attribute constraints and trade offs

There is a tension among attributes, and how these attributes contribute to overall unit test suite quality. 

Among accuracy, completeness, and speed, you cannot maximize all three; that is, you cannot have a _fast_ test suite that will fail if _and only if_ there is a bug. Maximizing any two will minimize the third.
- A prefect test suite with high accuracy and completeness will inevitably be huge, and thus very slow. 
- A fast test suite with high accuracy will often only test only the most common user journeys, and thus be incomplete. 
- A test suite with very high coverage is often made 'fast' through extensive use of test doubles and ends up coupling tests with the implementation details, which makes the tests brittle, and therefore inaccurate.

### What's the right trade off?
![Image not found: /images/balance-scale.jpg](/images/balance-scale.jpg "Image not found: /images/balance-scale.jpg")

A natural follow up to the trade offs among accuracy, completeness, and speed is _"What is the right trade off?"_. It helps to notice that, empirically, we are always making this trade off and naturally settling on some point in the trade-off surface. What is this natural resting point for these trade offs? Let's examine a few things to help us answer the above question.

1. From experience, we know that bugs in software are inevitable, and we have learned to deal with it. While bug-free code might be the ideal, no one reasonably expects bug-free software, and we accept some level of incorrectness in our implementations.
2. Flaky/brittle tests can have very significant negative consequences. Such tests are inherently untrustworthy, and therefore, serve no useful purpose. In the end, we tend to ignore such tests, and for all practical purposes they just don't exist in our test suite.
3. While extremely slow tests are an issue, we have figured out ways to improve test speeds through infrastructure developments. For instance,our CI/CD systems can run multiple tests in the test suite in parallel, and thus we are delayed only by the slowests tests in the test suite; we have figured out how to prune the affected tests in a diff by being smart about the build and test targets affected by the changes, and thus, we need not run the entire test suite for a small change; the machines that execute tests have just gotten faster, thus alleviating some of the latency issues, etc.

From the above three observations, we can reasonably conclude that we cannot sacrifice accuracy. Accurate tests are the bedrock of trustworthy (and therefore, useful) test suites. Once we maximize accuracy, that leaves us with completeness and speed. Here there is a sliding scale between completeness and speed, and we could potentially rest anywhere on this scale.

So, is it ok to rest anywhere on the tradeoff spectrum between completeness and accuracy? Not quite. If you dial completeness all the way up and ignore speed, then you end up with a test suite that no one wants to run, and therefore, not useful at all. On the other hand, if you ignore completeness in favor of speed, then you are likely going to see a lot of regressions in your software and completely undermine consumer confidence in your product/service. In effect, **the quality of your test suite is determined by the lowest score among the three attributes.** Therefore, it is important to rest between completeness and speed, depending on the tolerance to errors and the minimum developer velocity you can sustain. For instance, if you are developing software for medical imaging, then your tolerance to errors is very very low, and so you should be favoring completeness at the expense of speed (and this is evident in how long it takes to make changes to software in the area of medical sciences). On the other hand, if you are building a web service that can be rolled back to a safe state quickly and with minimal external damage, then you probably want to favor speed over completeness (but only to a point; remember that your test quality is now determined by the completeness, or the lack thereof).

Thus, in conclusion, always maximize accuracy, and trade off between completeness and speed, depending on your tolerance of failures in production.