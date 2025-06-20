---
title: "TDD for Bug Fixes"
date: 2025-06-11
layout: post
categories: 
  - Professional
tags:
  - test driven development
  - tdd
  - bug fixing
  - testing
permalink: /tdd-for-bug-fixes/
image: /images/bug-stabbing-software-engineer-in-the-back.png
...

<!-- ![](/images/bug-stabbing-software-engineer-in-the-back.png) -->

I have seen way too many 'senior' engineers get bug fixing wrong. It is common to see an engineer sent a pull request titled "bug fix: <something>" and the PR has changes to the functional code that fixes the bug and a correspond test case that shows that the bug is fixed. If that sounds reasonable, THINK AGAIN — you’ve walked right into the classic trap! 

**If you are sending PRs for bug fixes with functional code change and an added test case in the same PR/commit, then you are doing it wrong!**

The crux of the problem is the following: HOW DO YOU *KNOW* YOU’RE SMASHING THAT BUG? HOW CAN YOU BE SURE YOUR TEST ISN’T A DUD?! Your answer better not be *VIBE CHECKS* or just *STARING REALLY HARD*! If you are having to deploy your entire service/library and run an end-to-end test to demonstrate correctness, then you are doing too much, and you still haven't demonstrated that the unit test actually captures the previously errneous behavior.


There is this shiny little concept called [Test Driven Development (TDD)](https://en.wikipedia.org/wiki/Test-driven_development) that is mighty useful here. You can peruse the wikipedia link to figure out what TDD is exactly. This note will show you how to use TDD for bug fixes.

Here are simple steps to fixing bugs using TDD:

0. 🕵️ Discover the bug. BAM! There it is! Your nemesis!

1. 🧪 Create a PR that creates a new unit test that exposes the unit test. YAWZA!

2. 🔧 Create a second PR on top the first PR that makes the functional code change and changes the expectation on the unit test accordingly. That should squash the bug! KAPOW!

3. 💰 Justice is served! PROFIT!

![](/images/tdd-bug-lifecycle.png)

Still not sure? Let's demonstrate this with an example. Say, there is a bug that you discovered and know how to fix it. 

First, you create a PR that demonstrates the bug by invoking your SUT with the offending input, and sets the expected value to be _incorrect_ so that the test case actually *passes* with this incorrect value; thus demonstrating the bug.

```python
class TestSUT(unittest.TestCase):
    ...
    def test_bug_b12345(self) -> None:
        '''
        Test to expose bug b12345
        '''
        # Arrange
        sut = SUT(...)
        
        # Act
        actual = sut.test_method(input="bad-input")

        # Assert
        self.assertEqual(actual, "bad buggy output")
        # The assertion above demonstartes the bug b12345
        # The right expected value should be "correct output".
        # self.assertEqual(actual, "correct output")
        
```

You can send that PR out for review and merge it in. Now you have a solid proof that you have found a bug, and reproduced it.

Next, you have a new PR that fixes that bug. If you bug fix is correct, then the test `test_bug_b12345` should not start failing. The output of `sut.test_method(input="bad-input")` should be `"correct output"` and not `"bad buggy output"`. So, you now modify the unit test `test_bug_b12345` in that same PR that looks as follows:
```diff
    def test_bug_b12345(self) -> None:
        '''
        Test to expose bug b12345
        '''
        # Arrange
        sut = SUT(...)
        
        # Act
        actual = sut.test_method(input="bad-input")

        # Assert
-       self.assertEqual(actual, "bad buggy output")
-       # The assertion above demonstartes the bug b12345
-       # The right expected value should be "correct output".
-       # self.assertEqual(actual, "correct output")
+       self.assertEqual(actual, "correct output")
```

Now your test should pass. This second PR is conclusive proof that your diff now fixes the bug! So, merge it in. Deploy with confidence. **BOOM — PROFIT!**
