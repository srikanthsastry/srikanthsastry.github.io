---
title: "Defining unit tests: two schools of thought"
date: 2022-06-18
id: 20220618081449
tags:
  - "unit tests"
  - "software engineering"
  - "classical school"
  - "detroit school"
  - "london school"
categories:
  - professional
layout: post
permalink: /defining-unit-tests-two-schools-of-thought/
excerpt: >
  A unit test is a piece of code that verifies a "unit" of software, in "isolation", and quickly.
  There are two schools of thought on the notion of "unit" and "isolation", and that makes all the difference.
...
### Definitions: What is a unit test?
![](/images/london-detroit.jpg)

There are several definitions for unit tests. [Roy Osherove](https://www.artofunittesting.com/definition-of-a-unit-test) defines it as "piece of code that invokes a unit of work in the system and then checks a single assumption about the behavior of that unit of work"; Kent Beck turns the idea of defining unit tests on it's head by [simply stating a list of properties](https://tidyfirst.substack.com/p/desirable-unit-tests), and any code that satisfies those properties in a "unit test". 

I like Vladimir Khorikov's definition of a unit test in his book [Unit Testing Principles, Practices, and Patterns](https://www.manning.com/books/unit-testing). According to him, a unit test is a piece of code that (1) verifies a unit of software, (2) in isolation, and (3) quickly. The above definition only balkanizes a _unit test_ into three undefined terms: (1) unit of software, (2) isolation, and (3) quick/fast/speed. Of the three, the third one is the easiest to understand intuitively. Being _fast_ simply means that you should be able to run the test in real time and get the results quickly enough to enable interactive iteration of modifying the unit of software you are changing. However, the other two terms: _unit of software_, and _isolation_ merit more discussion.

### Are you from Detroit, or London?

In fact, there are two schools of thought around how the above two terms should be defined. The 'original/classic/Detroit' school, and the 'mockist/London' school. Not surprisingly, the school of thought you subscribe to has a significant impact on how you write unit tests. For a more detailed treatment of the two schools of thought, I suggest Martin Folwer's [excellent article on the subject of Mocks and Stubs](https://martinfowler.com/articles/mocksArentStubs.html#ClassicalAndMockistTesting). Chapter 2 of Khorikov's book [Unit Testing Principles, Practices, and Patterns](https://www.manning.com/books/unit-testing) also has some good insights into it. I have distilled their contents as it pertains to unit test definitions.

#### The Detroit School

The Classical or Detroit school of thought originated with Kent Beck's "[Test Driven Development](https://www.oreilly.com/library/view/test-driven-development/0321146530/)".

**Unit of software.** According to this school, the unit of software to test is a "behavior". This behavior could be implemented in a single class, or a collection of classes. The important property here is that the the code that comprises the unit must be (1) internal to the software, (2) connected with each other in the dependency tree, and (3) not shared by another other part of the software.

Thus, a unit of software cannot include external entities such as databases, log servers, file systems etc. They also cannot include external (but local) libraries such as system time and timers. Importantly, it is _ok_ to include a class that depends on another class via a private non-shared dependency.

**Isolation.** Given the above notion of a "unit" of software, isolation simply means that the test is not dependent on anything outside that unit of software. In practical terms, it means that a unit test needs to replace all external and shared dependencies with [test doubles]({% post_url 2022-05-25-mocks-stubs-and-how-to-use-them %}).

#### The London School

The mockist or London school of thought was popularized by [Steve Freeman](https://www.linkedin.com/in/stevefreeman) ([twitter](https://twitter.com/sf105)) and [Nat Pryce](http://www.natpryce.com/bio.html) in their book "[Growing Object- Oriented Software, Guided by Tests](http://growing-object-oriented-software.com/)".

**Unit of Software.** Given the heavy bias Object-Oriented software, unsurprisingly, the unit of software for a unit test is a single class (in some cases, it can be a single method). This is strictly so. ANy other class that this the 'class under test' depends on cannot be part of the unit being tested.

**Isolation.** What follows from the above notion of a "unit" is that _everything_ that is not the class under test must be replaced by test doubles. If you are instantiating another class inside the class under test, then you must replace that instantiation with an injected instance or a factory that can be replaced with a test double in the tests.

Here is a quick summary of the definitions of a unit tests under the two schools.

| School | Unit | Isolation|  Speed |
|---|---|---|---|
| Classical | Behavior |  mock out shared and external dependencies | 'fast' |
| London | Class  |  out all dependencies (internal, external, shared, etc.) | 'fast' |

### What does this mean?

The school of thought you subscribe to can have a significant impact on your software design and testing. There is nothing I can say here that hasn't already been explained by Martin Fowler in his article "[Mocks aren't stubs](https://martinfowler.com/articles/mocksArentStubs.html)". So, I highly recommend you read it for yourself.