---
title: DRY unit tests are bad... mkay
id: 20220517094546
tags:
    - testing
    - 'software engineering'
categories:
    - Professional
permalink: /dry-unit-tests-are-bad/
layout: post
excerpt: >
  "Don't Repeat Yourself" (DRY) is arguably one of the most important principles in software engineering.
  It is considered a truism among many. 
  A consequence of such dogmatic allegiance to DRYness is that we see a lot of DRY unit tests; this is where
  the utility of the DRY principle breaks downs and starts causing more problems that it solves.
...
![DRY](/images/squeeze-cloth.jpg)

["Don't Repeat Yourself" (DRY)](https://en.wikipedia.org/wiki/Don%27t_repeat_yourself) is arguably one of the most important principles in software engineering. It is considered a truism among many. A consequence of such dogmatic allegiance to DRYness is that we see a lot of DRY unit tests; this is where the utility of the DRY principle breaks downs and starts causing more problems that it solves.

## So, what's wrong with DRY Unit Tests?
Presumably, we are all convinced of the benefits of DRYing your code (interested readers can go [the Wikipedia page](https://en.wikipedia.org/wiki/Don%27t_repeat_yourself)). It does have some downsides, and so you have the notion of the [DAMP](http://blog.jayfields.com/2006/05/dry-code-damp-dsls.html)/[MOIST](https://startup-cto.net/moist-code-why-code-should-not-be-completely-dry/)/[AHA](https://kentcdodds.com/blog/aha-programming) principle. Interestingly, the reasons why DRYness doesn't always work out in production code are different from why it is a bad idea to write DRY unit tests. I see five ways in which (a) test code is different from production code and (b) it contributes to why test code should not be DRY.

1. Tests (conceptually) do not yield well to common abstractions.
2. Test code's readability always takes precedence over performance, but not so for production code.
3. Production code enjoys the safety net of test code, but test code has no such backstop.
4. DRY production code can speed up developer velocity, but DRY test code hinders developer velocity.
5. Complex changes to production code can be reviewed faster with pure green/pure red test code changes, but complex changes to test code cannot be reviewed easily. 

Let's explore each one in more detail.

### DRYness and Abstraction
![Abstract](/images/triangles-abstract.png)
In practice, DRYing out code results in building abstractions that _represents a collection of semantically identical operations_ into common procedure. If done prematurely, then DRYing can result in poorer software. In fact, premature DRYing is the motivation for advocating the [AHA](https://kentcdodds.com/blog/aha-programming) principle. While that argument against DRYness works well in production code, it does not apply for test code.

Test code is often a collection of procedures, and each procedure steps the System-Under-Test (SUT) through a distinct user journey and compares the SUT's behavior against pre-defined expectations. Thus, almost by design, test code does not yield itself semantically similar abstractions. The mistake that I have seen software engineers make is to mistake syntactic similarly for semantic similarity. Just because the tests' 'Arrange' sections look similar does not mean that they are doing semantically the same thing in both places; in fact, they are almost certainly doing semantically different things because otherwise, the tests are duplicates of each other!

By DRYing out such test code, you are effectively forcing abstractions where none exist, and that leads to the same issues that DRYness leads to in production code (See [\[1\]](https://kentcdodds.com/blog/aha-programming), [\[2\]](https://sandimetz.com/blog/2016/1/20/the-wrong-abstraction), [\[3\]](https://evhaus.medium.com/using-dry-wet-damp-code-6ab3c8245bb2), [\[4\]](https://startup-cto.net/moist-code-why-code-should-not-be-completely-dry/) for examples).

### Readability
![Abstract](/images/glasses-letters-clear.jpg)
Most code is read more often than is written/edited. Unsurprisingly, it is important to favor code readability, even in production code. However, in production code, if this comes at a steep cost in performance and/or efficiency, then it is common (and prudent) to favor performance over readability. Test code, on the other hand, is less subject to the (potential) tension between readability and performance. Yes, unit tests need to be 'fast', but given the minuscule amount of data/inputs that unit tests process, speed is not an issue with hermetic unit tests. The upshot here is that there is no practical drawback to keeping test code readable. 

DRYing out test code directly affects its readability. Why? Remember that we read unit tests to understand the expected behavior of the system-under-test (SUT), and we do so in the context of a user journey. So, a readable unit test needs to explain the user journey it is executing, the role played by the SUT in realizing that user journey, and what a successful user journey looks like. This is reflected in the [Arrange-Act-Assert](https://java-design-patterns.com/patterns/arrange-act-assert/) structure of the unit test. When you DRY out your unit tests, you are also obfuscating at least one of those sections in your unit test. This is better illustrated with an example.

A common DRYing in unit tests I have seen looks as follows:
```python
class TestInput(typing.NamedTuple):
    param1: str
    param2: typing.Optional[int]
    ...

class TestOutput(typing.NamedTuple):
    status: SomeEnum
    return_value: typing.Optional[int]
    exception: typing.Optional[Exception]
    ...

class TestCase(typing.NamedTuple):
    input: TestInput
    expected_output: TestOutput
        
class TestSequence(unittest.TestCase):
    
    @parameterized.expand([
        [test_input1, expected_output1],
        [test_input2, expected_output2],
        ...
    ])
    def test_somethings(self, test_input: TestInput, expected_output: TestOutput) -> None:
        self._run_test(test_input, expected_output)
        
    def _run_test(self, test_input: TestInput, expected_output: TestOutput) -> None:
        sut = SUT(...)
        prepare_sut_for_tests(sut, test_input)
        output = sut.do_something(test_input.param2)
        test_output = make_test_output(output, sut)
        self.assertEquals(expected_output, test_output)
```
On the face of it, it looks like DRY organized code. But for someone reading this test to understand what SUT does, it is very challenging. They have no idea why the set of `test_input`s were chosen, what is the material difference among the inputs, what user journeys do each of those test cases represent, what are the preconditions that need to be satisfied for running `sut.do_something()`, why is the expected output the specified output, and so on.

Instead, consider a non-DRY alternative.
```python
class TestSequence(unittest.TestCase):
    
    def test_foo_input_under_bar_condition(self):
        """
        This test verifies that when condition bar is true, then calling `do_something()`
        with input foo results in sigma behavior
        """
        sut = SUT()
        ensure_precondition_bar(sut, param1=bar1, param2=bar2)
        output = sut.do_something(foo)
        self.assertEquals(output, sigma)
```
This code tests one user journey and is human readable at a glance by something who does not have in-depth understanding of SUT. We can similarly define all the other test cases with code duplication and greater readability, with negligible negative impact.

### Who watches the watchmen?
![colink., CC BY-SA 2.0 &lt;https://creativecommons.org/licenses/by-sa/2.0&gt](https://upload.wikimedia.org/wikipedia/commons/thumb/0/0c/Watchmen_graffiti_1.jpg/2560px-Watchmen_graffiti_1.jpg)
*[[Original Image](https://www.flickr.com/photos/67458569@N00/7099293919) posted to [Flickr](https://en.wikipedia.org/wiki/Flickr "en:Flickr") by colink. License: [Creative Commons ShareAlike](https://creativecommons.org/licenses/by-sa/2.0/)]*

Production code has the luxury of being fine tuned, optimized, DRY'd out, and subject to all sorts of gymnastics mostly because production code is defended by tests and test code. For instance, to improve performance, if you replaced a copy with a reference, and accidentally mutated that reference inside a function, you have a unit test that can catch such unintended mutations. However, test code has no such backstop. If you introduce a bug in your test code, then only a careful inspection by a human will catch it. The upshot is the following: the less simple/obvious the test code is, the more likely it is that a bug in that test code will go undetected, at least for a while. If a buggy test is passing, then it means your production code has a bug that is undetected. Conversely, if a test fails then, it might just denote a bug in the test code. If this happens, you lose confidence in your test suite, and nothing good can come from that.

DRY code inevitably asks the reader to jump from one function to another and requires the reader to keep the previous context when navigating these functions. In other words, it increases the cognitive burden on the reader compared to straight line duplicated code. That makes it difficult to verify the correctness of the test code quickly and easily. So, when you DRY out your test code, you are increasing the odds that bugs creep into your test suite, and developers lose confidence in the tests, which in turn significantly reduces the utility if your tests.

### Developer Velocity
![Woman developer](/images/woman-developer-frustrated.jpg)

Recall from the previous section that while tests might have duplicate code, they do not actually represent semantic abstractions replicated in multiple places. If you do mistake them for common semantic abstractions and DRY them out, then eventually there will an addition to the production code whose test breaks this semantic abstraction. At this point, the developer who is adding this feature will run into issues when trying to modify the existing test code to add the new test case. For instance, consider a class that is hermetic, stateless, and does not throw exceptions. It would not be surprising to organize DRY tests for this class that assumes that exceptions are never thrown. Now there is a new feature added to this class that requires an external dependency, and now can throw exceptions. Added a new test case into the DRY'd out unit test suite will not be easy or straightforward. The sunk cost fallacy associated with the existing test framework makes it more likely that the developer will try to force-fit the new test case(s) into existing framework. As a result:

1. It slows the developer down because they now have to grok the existing test framework, think of ways in which to extend it for a use case that it was not designed for, and make those changes without breaking existing tests.
2. Thanks to poor abstractions, you have now incurred more technical debt in your test code.

### Code Reviews
![Developers doing code reviews](/images/black-women-developers.jpg)

DRY'd out tests not only impede developer velocity, they also make it less easy to review code/diffs/pull requests. This is a second order effect of DRYing out your test code. Let's revisit the example where we are adding a new feature to an existing piece of code, and this is a pure addition in behavior (not modification to existing behavior). If the tests were not DRY'd out, then adding tests for this new feature would involve just adding new test cases, and thus, just green lines in the generated diff. In contrast, recall from the previous subsection that adding tests with DRY test code is likely going to involve modifying existing code and then adding new test cases. In the former case, reviewing the tests is much easier, and as a result, reviewing that the new feature is behaving correctly is also that much easier. Reviewing the diff in the latter case is cognitively more taxing because not only does the reviewer need to verify that the new feature is implemented correctly, they also have to verify that the changes to the test code is also correct, and is not introducing new holes for bugs to escape testing. This can significantly slow down code reviews in two ways (1) it requires more time to review the code, and (2) because it requires longer to review the code, the reviewers are more likely to delay even starting the code review.
