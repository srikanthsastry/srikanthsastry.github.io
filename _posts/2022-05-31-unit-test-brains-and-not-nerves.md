---
title: "Unit test the brains and not the nerves"
date: 2022-05-31
id: 20220526101440
tags:
  - testing
  - "software engineering"
  - "integration tests"
  - "unit tests"
categories:
  - professional
layout: post
permalink: /unit-test-the-brains-and-not-the-nerves/
excerpt: >
  Unit tests are typically your first line of defense against bugs.
  So, it is tempting to add unit tests for all functionality that your code supports. 
  But that begs the following question. "Why do we need integration and end-to-end tests?"
  Unit tests most benefit the most complex parts of your codebase that often requires the most technical skill and domain knowledge to author, read, and maintain. Integration tests disproportionately benefit the parts of your codebase that communicate with external dependencies.
...
_Note: This is inspired from the book "[Unit Testing: Principles, Practices, and Patterns](https://www.manning.com/books/unit-testing)" by Vladimir Khorikov._

![brain](/images/brain-magnifying-glass.png)

Unit tests are typically your first line of defense against bugs. So, it is tempting to add unit tests for all functionality that your code supports. But that begs the following question. "Why do we need integration and end-to-end tests?"

## Categorizing production code
To better understand the primary motivations for unit tests vs. integration (and end-to-end) tests, it is helpful to categorize your production code into four categories along two dimensions: thinking, and talking.

* _Thinking code._ There are parts of your codebase that are focused mostly on the business logic and the complex algorithmic computations. I refer to these as the thinking code.
* _Talking code._ There are parts of your codebase that are focused mostly on communicating with other dependencies such as key-value stores, log servers, databases, etc. I refer to these as talking code.

Each part of your codebase can be either thinking, talking, or both. Based on that observation, we can categorize each unit of code into one of four categories (in keeping with the biology theme).

| Thinking 	| Talking 	| Category 	   |
|----------	|---------	|------------- |
| Yes      	| No      	| _Brain_    	  |
| No       	| Yes     	| _Nerves_   	 |
| Yes      	| Yes     	| _Ganglia_  	|
| No       	| No      	| _Synapse_  	|


## Testing for each category

Each category needs a distinct approach to testing.

### Brains &rarr; Unit Tests

Brains are one of the most complex parts of your codebase that often requires the most technical skill and domain knowledge to author, read, and maintain. Consequently, they are best tested with unit tests. Furthermore, they also have very few direct external dependencies, and as a result require limited use of test doubles.

### Nerves &rarr; Integration Tests

Nerves have very little logic, but focus mostly on external communication with dependencies.
As a result, there isn't much to unit test here, except perhaps that the protocol translation from the outside world into the brains is happening correctly.
By their very nature, the correctness of nerves cannot be tested hermetically, and therefore, are not at all well suited to be unit tested. Nerves should really be tested in your integration tests, where you hook your production code with real test instances of external dependencies.

### Ganglia &rarr; Refactor

Ganglia are units of code that have both complex business logic and have significant external dependencies. It is very difficult to unit test them thoroughly because such unit tests require heavy use of test doubles which can make the tests less readable and more brittle. You could try to test ganglia through integration tests, but it becomes very challenging to test low probability code paths, which is usually the source of difficult-to-debug issues. Therefore, my suggestion is to refactor such code into smaller pieces of code each of which are either a _brain_ or a _nerve_, and tests each of those as described above.

See Chapter 7 of "[Unit Testing: Principles, Practices, and Patterns](https://www.manning.com/books/unit-testing)" for suggestions on how to refactor your code to make it more testable.

### Synapse &rarr; Ignore

Synapses are trivial pieces of code (often utilities) that have neither complex business logic, nor do they have any external dependencies. My recommendation is to simply not focus on testing them. Adding unit tests for them simply increases the cost of testing and maintenance without really providing any benefit. They are often simple enough to be verified visually, and they exist only to serve either the brains or the nerves, and so will be indirectly tested via unit tests or integration tests.

