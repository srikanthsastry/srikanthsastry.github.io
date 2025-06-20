---
title: 'Do not index on test coverage metrics'
id: 20220429105300
layout: post
permalink: /do-not-index-in-test-coverage/
tags:
    - testing
    - software
    - Python
    - 'software engineering'
categories:
    - Professional

excerpt: >
  We live in a data driven world.
  The temptation, therefore, is to measure everything. Even the quality of your unit tests, and there where the trouble usually begins. For an detailed explanation of why indexing on the test coverage metrics is a bad idea, I highly recommend Jason Rudolph's collection of posts on this topic (https://jasonrudolph.com/blog/testing-anti-patterns-how-to-fail-with-100-test-coverage/). To drive home the point more explicitly (and motivate you to actually go read Jason's posts), here are some illustrative explanations.
image: /images/chart-coverage.png
...

<!-- ![Coverage Chart](/images/chart-coverage.png) -->

We live in a data driven world, and as the saying goes "[…] What is not measured, cannot be improved. […]"
> What is not defined cannot be measured. What is not measured, cannot be improved. What is not improved, is always degraded. 
>
>    – William Thomson Kelvin

The temptation, therefore, is to measure everything. Even the quality of your unit tests, and there where the trouble usually begins. For an detailed explanation of why indexing on the test coverage metrics is a bad idea, I highly recommend Jason Rudolph's collection of posts on this topic [here](https://jasonrudolph.com/blog/testing-anti-patterns-how-to-fail-with-100-test-coverage/). To drive home the point more explicitly (and motivate you to actually go read Jason's posts), here are some illustrative explanations.

There are many coverage metrics including function coverage, statement coverage, line coverage, branch coverage, condition coverage, etc. Here, we will only look at line coverage and branch coverage, because those are the most popular.

## Line coverage
Let's start with *line coverage*, which is the number of lines of code executed by tests vs. the total number of lines of code. The most common target for the line coverage metric is 80%. That is, 80% of your code should be executed by your tests. While that might seem like a good idea, indexing on this metric can actually take you away from good quality test coverage! How? Consider the following (contrived example).

```python
def has_three_digits(value: int) -> bool:
    strlen = len(str(value))
    if strlen == 3:
        return True
    return False

class TestHasThreeDigits(unittest.TestCase):
    def test_has_three_digits_234(self) -> None:
        output_value = has_three_digits(234)
        self.assertTrue(output_value)
```
Clearly `TestHasThreeDigits` inadequate as a test suite for testing `has_three_digits`. Tests only the True case, and misses the False cases completely!
The line coverage of the test suite is 3/4 = 75%. You could say that the test coverage is less than 80%, and therefore not adequate. Here, it appears that the line coverage metric does indeed point of inadequate testing. However, this confidence in the metric is severely misplaced! Consider the following refactoring of `has_three_digits`
```python
def has_three_digits(value: int) -> bool:
    value_as_str = str(value)
    strlen = len(value_as_str)
    if strlen == 3:
        return True
    return False
```
Now, `TestHasThreeDigits` line coverage magically improves to 4/5 = 80%, and as per the 80% target, the metrics seems to suggest adequate coverage! In fact, you can play this game some more and refactor `has_three_digits` to 
```python
def has_three_digits(value: int) -> bool:
    value_as_str = str(value)
    strlen = len(value_as_str)
    return (strlen == 3)
```
Now, with the same test suite `TestHasThreeDigits` now has 100% coverage! Recall that semantically the test still do the same thing; they still test only the True case, and ignore the False case completely.

## Branch coverage
An easy retort to the above example is that line coverage is not a sufficiently nuanced metric, and what you really need is *branch coverage*, which is the number of branches executed by the tests vs. the number of branches in the code.

Looking at the branch coverage of `TestHasThreeDigits`, we can see that it has a 50% branch coverage, which is inadequate. Well, here's an easy way to improve that.
```python
class TestHasThreeDigits(unittest.TestCase):
    def test_has_three_digits_true(self) -> None:
        true_output_value = has_three_digits(234)

    def test_has_three_digits_false(self) -> None:
        false_output_value = has_three_digits(23)
```
See, now the test suite has 100% branch coverage! However, not that it has no assertions at all. So, despite having 100% line and branch coverage, this test suite is completely useless! (This is a form of [incidental coverage anti-pattern](https://jasonrudolph.com/blog/2008/06/17/testing-anti-patterns-incidental-coverage/).)

Here is a more nuanced example:
```python
class HasThreeDigits:
    def __init__(self) -> None:
        self.counter = 0
        
    def test(x: int) -> bool:
        self.counter += 1
        return (len(str(x)) == 3)
    
class TestHasThreeDigits(unittest.TestCase):
    def test_has_three_digits_234(self) -> None:
        output_value = has_three_digits(234)
        self.assertTrue(output_value)

    def test_has_three_digits_23(self) -> None:
        output_value = has_three_digits(23)
        self.assertFalse(output_value)
```
The code coverage is 100%, branch coverage is 100%. But `self.counter` is never verified!
## Wait, there's more!
Coverage metrics only consider the code the are under your project, and ignore all external libraries. However, your code is correct only if you are satisfying the preconditions of your external library calls, and test coverage metrics do not capture any of that. Here is an illustration with an contrived example.
```python
from external.lib import convert_to_num

def has_three_digits(value: str) -> bool:
    v = convert_to_num(value)
    return v is not None and v > -1000 and v < 1000
```
The above code is expected return True if `value` is and integer with 3 digits. Here is test suite.
```python
class TestHasThreeDigits(unittest.TestCase):
    def test_has_three_digits_234(self) -> None:
        output_value = has_three_digits('234')
        self.assertTrue(output_value)

    def test_has_three_digits_23(self) -> None:
        output_value = has_three_digits('23')
        self.assertFalse(output_value)

    def test_has_three_digits_minus_23(self) -> None:
        output_value = has_three_digits('-23')
        self.assertFalse(output_value)

    def test_has_three_digits_minus_234(self) -> None:
        output_value = has_three_digits('-234')
        self.assertTrue(output_value)

    def test_has_three_digits_ten_times_ten(self) -> None:
        output_value = has_three_digits('10*10')
        self.assertTrue(output_value)
```
The test suite looks reasonable. You line and branch coverage is a 100%, and so nothing in the metrics suggestg anything is amiss. Except that we have said nothing about how `convert_to_num` is implemented. It is easy to imagine some preconditions for the input to `convert_to_num`; for instance, it throws a ValueError exception if you pass in an input of the form `3/0`. Now, you can see how the test suite is not adequate! (`has_three_digits('10/0')` will throw an exception). But your test coverage metrics will never be able to help here. 
