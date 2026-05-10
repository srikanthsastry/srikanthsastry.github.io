---
title: 'My code is bugfree! Why should I unit test?'
published: '2017-11-01T16:33:01-04:00'
tags:
  - 'documentation'
  - 'software engineering'
  - 'software testing'
  - 'unit tests'
abbrlink: 'merits-of-unit-tests-part-1'
lang: ''
series: 'unit-testing'
series_order: 1
series_label: 'Unit Testing'
series_section: 'Merits'
categories:
  - Professional

---

There are multiple reasons to write unit tests. Verification is only one of them, and the least interesting. This is part 1 of a five part series on why you should write unit tests (apart from the obvious): Documentation!

I posted this article on [LinkedIn](https://www.linkedin.com/pulse/my-code-bugfree-why-should-i-unit-tests-srikanth-sastry/) and am reposting it here cuz' this is the authoritative source for it :)

We have all heard this
repeatedly: “You have to have unit tests. Unit tests are how you find
issues in your code and fix them before they hit the trunk.” Ok, so that
 argument sounded a little weak. Here is a much stronger version of the
same argument.

*You have to write unit tests because unit tests are a*[*scientific*](https://en.wikipedia.org/wiki/Scientific_method)
*mechanism to verify that your implementation satisfies the
specification (that is, you code does what you say it does). To
elaborate, your claim of what your code does is a*[*falsifiable*](https://en.wikipedia.org/wiki/Falsifiability)
*hypothesis in that it is possible to conceive of an observation that
could negate your claim. Unit tests are the experiments that can be
performed to test your hypothesis. If all your unit tests pass, then it
is increasingly likely that your claim is correct. (Note that we cannot
claim to have proved correctness; that is an impossible task in the
general case).*

This still an unsatisfying argument at best. What if I were a perfect
 developer who writes perfect code, and everyone around me agrees that I
 write perfect code. Do I still need to write unit tests? Or what about
the cases where visual inspection of the code makes correctness obvious.
 Do I still need to spend precious time writing unit tests?

While verification is an important reason to have unit tests, IMHO,
it is also the least interesting. There are many more reasons to be
rigorous about unit tests.

Let's start with my favorite.

### Documentation

[![](/assets/images/2019/01/a0a8c4ab0bec170a748228f0982da6795e6af515a8048b11c2b4c9e794d7b4f9.jpg)](http://www.quickmeme.com/meme/3t1i87)

Unit tests makes the best [documentation](/garden/tests-as-executable-documentation/) for your code. We were all
hired as software engineers because we can write good software. That
means a lot of us are not very good at technical writing, and for many
of us, English isn't our native tongue. This creates barriers for us in
communicating what our software does so that others can use it well.

We could write wiki/docs describing what our code does, but that has three major issues.

1. The documentation doesn't live anywhere near the code, and so discoverability is difficult
2. English is not the primary language for a lot of us, and technical
writing is not our strong suit, and so the quality of the writing can be
 suspect
3. As the code evolves, the documentation becomes obsolete. The only thing worse than no documentation is wrong documentation!

We could write comments in the code itself. So discoverability is not
 a problem. However, the other two issues still remain. (Raise your hand
 if you have seen comments that are out of sync with the code that it is
 supposed to clarify.)

What we could really use it a mechanism that leverages our strength
(writing software) to create documentation, and automation to ensure
that documentation is never obsolete. Unit tests turn out to be the
perfect tool for this!

Think of each unit test as a how-do example of how to use your code.
So, if anyone wants to use the code that your wrote, all they need to do
 is look at your unit tests, the job is done!

**EXAMPLE**

A great example is the [folly](https://github.com/facebook/folly) library. Let's take folly Futures for instance. The primary header file [Future.h](https://github.com/facebook/folly/blob/master/folly/futures/Future.h) tells you the API, but figuring out how to use it is not straightforward from there. However, go over to the unit tests at [FutureTest.cpp](https://github.com/facebook/folly/blob/master/folly/futures/test/FutureTest.cpp),
 and you will come away knowing how to use Futures for your use case in a
 matter of minutes. For each minute spent by a folly developer to write
these unit tests, it has saved thousands of developers countless hours.

### But wait, there more!

There are many other things that work better when you have unit tests.

- [Refactoring](http://srikanth.sastry.name/the-merits-of-unit-tests-part-2/).
- [Better code design.](https://www.linkedin.com/pulse/merits-unit-tests-part-3-srikanth-sastry/)
- [Debugging prod issues.](http://srikanth.sastry.name/unit-tests-ftw-part-4/)
- [API usability](http://srikanth.sastry.name/merits-of-unit-tests-part-5/).
