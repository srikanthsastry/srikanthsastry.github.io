---
title: "Tests should be isolated from each other; not coupled"
date: 2022-07-03
id: 20220703131628
tags:
  - "unit tests"
  - "software engineering"
categories:
  - Professional
layout: post
permalink: /tests-should-be-isolated-not-coupled/
image: /images/carabiners-connected.jpg
...
<!-- ![](/images/carabiners-connected.jpg) -->
Almost [by definition]({% post_url 2022-06-18-defining-unit-tests-two-schools-of-thought %}) unit tests should be _isolated_ from its (external, shared) dependencies. But, equally importantly, unit tests should also be isolated _from each other_. When one test starts to affect another test, the two tests are said to be _coupled_. Alternatively, if changes to one test _can_ negatively impact the correctness of another test, then the two tests are said to be _coupled_.

Coupled tests are problematic in two ways. 

1. _Tests become less readable._ Reading the code for a single unit test does not necessarily communicate what the test does. We also need to understand the 'coupling' between that test and other tests to grok what a single test does. This coupling can be subtle and not easy to follow.
2. _Tests become less [accurate]({% post_url 2022-06-13-unit-test-attributes-and-their-trade-offs %})._ When one test affects another, it becomes difficult to make changes to a single test in isolation. For instance, if a diff makes changes to the some production and test code, and then a test fails, then it is not always clear why the test failed. The failure could due to a bug, or an artifact the coupled tests. Thus, your tests are no longer trustworthy, and therefore, less accurate.

Coupling can happen in many ways. The obvious ones include (1) using the same shared dependency (like when you use the same temp file name in all tests), and (2) relying on the post-condition of one test as a precondition of another test. Such cases are also obvious to detect, and to fix. There are two more following ways in which tests can be coupled; but these are more subtle, and more prevalent.

1. Precondition setting in test fixtures
2. Parameterized tests for heterogeneous tests 

The rest of this note is focused on the above two anti-patterns of test coupling.

## Coupling through test fixtures

Say, your SUT has a dependency called `Helper`, and initially, for the two tests in your unit tests for the SUT, you initialize your `Helper` stub with contents `valueA`, and `valueB`. Since both tests share the same initial state, you include the initialization code in the `SetUp` of the unit tests.

```python
class SUTTestCase(unittest.TestCase):
    def setUp(self):
        self.helper = StubHelper()
        self.helper.add_contents([valueA, valueB])
        self.sut = SUT(self.helper)
        
    def test_behavior1(self) -> None:
        ...  # Assumes self.helper set with contents=[valueA, valueB]
    
    def test_behavior2(self) -> None:
        ...  # Assumes self.helper set with contents=[valueA, valueB]
```

Next, you modify SUT to add features to it. In order to test those features, the `Helper` stub needs to include `controllerA`. But these are useful only in the new tests being added. However, looking at the unit test you already have, it is easiest to to simply add `controllerA` to `self.helper`. So, your unit tests look as follows:

```python
class SUTTestCase(unittest.TestCase):
    def setUp(self):
        self.helper = StubHelper()
        self.helper.add_contents([valueA, valueB])
        self.helper.add_controller(controllerA)
        self.sut = SUT(self.helper)
        
    def test_behavior1(self) -> None:
        ...  # Assumes self.helper set with contents=[valueA, valueB]
             # But this test assumes nothing about self.helper's controller

    def test_behavior2(self) -> None:
        ...  # Assumes self.helper set with contents=[valueA, valueB]
             # But this test assumes nothing about self.helper's controller

    def test_behavior3(self) -> None:
        ...  # Assumes self.helper set with contents=[valueA, valueB], and controller=controllerA

    def test_behavior4(self) -> None:
        ...  # Assumes self.helper set with contents=[valueA, valueB], and controller=controllerA
```

Then you discover a gap in testing that requires the initial state of the `Helper` stub to have just the content `valueA` and include `controllerA`. Now, when adding this new unit test to suite, the simplest way to do this would be to remove `valueB` from `self.helper` at the start of the new test. So, now, your test suite looks as follows:

```python
class SUTTestCase(unittest.TestCase):
    def setUp(self):
        self.helper = StubHelper()
        self.helper.add_contents([valueA, valueB])
        self.helper.add_controller(controllerA)
        self.sut = SUT(self.helper)
        
    def test_behavior1(self) -> None:
        ...  # Assumes self.helper set with contents=[valueA, valueB]
             # But this test assumes nothing about self.helper's controller

    def test_behavior2(self) -> None:
        ...  # Assumes self.helper set with contents=[valueA, valueB]
             # But this test assumes nothing about self.helper's controller

    def test_behavior3(self) -> None:
        ...  # Assumes self.helper set with contents=[valueA, valueB], and controller=controllerA

    def test_behavior4(self) -> None:
        ...  # Assumes self.helper set with contents=[valueA, valueB], and controller=controllerA

    def test_behavior5(self) -> None:
        # Assumes self.helper set with contents=[valueA, valueB] (because of other tests' setup)
        self.helper.remove_content(valueB)
        # Now assumes self.helper set with contents=[valueA]
        ...  
```

Let pause here and inspect the state of the unit test. The tests are coupled. Why? Because modifying one test ends up affecting other tests. In the example above, if we replace `self.helper.add_contents([valueA, valueB])` with `self.helper.add_contents(valueA)` for tests `test_behavior1` and `test_behavior2`, it will result in a failure in `test_behavior5` because `self.helper.remove_content(valueB)` will end up throwing an error!

Furthermore, for anyone reading these tests, it is not entirely clear that `test_behavior1`, and `test_behavior2` need `self.helper` to be initialized with values `[valueA, valueB]`, but do not need for `controllerA` in `self.helper`. The preconditions for `test_behavior1` and `test_behavior2` are coupled with the preconditions for `test_behavior3`.

It also results in test incompleteness in that, if we introduce a bug that causes `behavior1` to fail when `self.helper.add_controller(controllerA)` is not set, we might not catch that bug because we have initialized the test for `behavior1` with `self.helper.add_controller(controllerA)`.

### How to decouple such tests?

Use the `setUp` method to simply set up your dependencies, but not to enforce any precondition. Instead, make setting preconditions part of the _arrange_ step of each unit test. You can even encapsulate the precondition setting into a function (with the right parameters) so that the _arrange_ section does not get too bloated, and yet the test code is readable. Consider the following refactoring of the tests:

```python
class SUTTestCase(unittest.TestCase):
    def setUp(self):
        self.helper: Optional[StubHelper] = None
        self.sut = SUT(self.helper)
        
    def prepare_helper(self, contents:List[Value], controller: Optional[Controller]=None) -> None:
        self.helper = StubHelper()
        self.helper.add_contents(contents)
        if controller:
            self.helper.add_controller(controller)
        
    def test_behavior1(self) -> None:
        # Assumes self.helper is a fresh object.
        self.prepare_helper(contents=[valueA, valueB])
        ...

    def test_behavior2(self) -> None:
        # Assumes self.helper is a fresh object.
        self.prepare_helper(contents=[valueA, valueB])
        ...    

    def test_behavior3(self) -> None:
        # Assumes self.helper is a fresh object.
        self.prepare_helper(contents=[valueA, valueB], controller=controllerA)
        ...

    def test_behavior4(self) -> None:
        # Assumes self.helper is a fresh object.
        self.prepare_helper(contents=[valueA, valueB], controller=controllerA)
        ...

    def test_behavior5(self) -> None:
        # Assumes self.helper is a fresh object.
        self.prepare_helper(contents=[valueA], controller=controllerA)
        ...
```

## Coupling in parameterized tests

[Parameterized tests](https://dl.acm.org/doi/10.1145/1095430.1081749) are a collection of tests that run the same verification, but with different inputs. While this is a very useful feature (available in almost all unit test frameworks), it is also very easy to abuse. A few common ways I have seen it abused is in conjunction with [DRYing](https://srikanth.sastry.name/dry-unit-tests-are-bad/), and the use 'if' checks, and that often results in coupling all the tests denoted by the parameterized list. Consider the following illustration:

```python
class TestOutput(typing.NamedTuple):
    status: StatusEnum
    return_value: typing.Optional[int]
    exception: typing.Optional[Exception]
    ...

class TestSequence(unittest.TestCase):
  
    @parameterized.expand([
        [test_input1, expected_output1],
        [test_input2, expected_output2],
        ...
    ])
    def test_something(self, test_input: str, expected_output: TestOutput) -> None:
        self._run_test(test_input, expected_output)
    
    def _run_test(self, test_input: str, expected_output: TestOutput) -> None:
        sut = SUT(...)
        prepare_sut_for_tests(sut, test_input)
        output = sut.do_something(test_input)
        test_output = make_test_output(output, sut)
        self.assertEquals(expected_output, test_output)

```

The above illustration tests the method `do_something` for various possible inputs. However, note that the outputs (as illustrated in the class `TestOutput` can have a `status`, a `return_value`, or an `exception`). This means that every instantiation (for each parameter) has to content with the possibility of different types of outputs even though any single test only should have to verify against a single type of output. This couples all the tests verifying `do_something`, this making it difficult to read and understand. Adding a new test case here becomes tricky because any changes to either `prepare_sut_for_tests`, or `make_test_output` now affects all the tests!

### How to decouple parameterized tests?

There are some fairly straightforward ways to decouple such tests. First, is that we should be very conservative about how we organize these tests. For example, we can group all positive tests and group all negative tests separately; similarly, we can further subgroup the tests based on the type of assertions on the output. In the above example, we can have three subgroups: positive tests that verify only output status, positive tests that verify return value, and negative tests that verify exception. Thus you now have three parameterized test classes that look something like this:
```python
class TestDoSomething(unittest.TestCase):
  
    @parameterized.expand([
        [test_status_input1, expected_status_output1],
        [test_status_input2, expected_status_output2],
        ...
    ])
    def test_something_status_only(
        self, 
        test_input: str, 
        expected_output: StatusEnum
    ) -> None:
        # Arrange
        sut = SUT(...)
        ...  # More 'arrange' code
        
        # Act
        output = sut.do_something(test_input)
        output_status = output.status
        
        # Assert
        self.assertEquals(expected_output, output_status)
        
    @parameterized.expand([
        [test_return_value_input1, expected_return_value_output1],
        [test_return_value_input2, expected_return_value_output2],
        ...
    ])
    def test_something_return_value_only(
        self, 
        test_input: str, 
        expected_output: int
    ) -> None:
        # Arrange
        sut = SUT(...)
        ...  # More 'arrange' code
        
        # Act
        output = sut.do_something(test_input)
        output_status = output.status
        output_value = output.value
        
        # Assert
        self.assertEquals(SomeEnum.SUCCESS, output_status)
        self.assertEquals(expected_output, output_value)

    @parameterized.expand([
        [test_return_value_input1, expected_error_code_output1],
        [test_return_value_input2, expected_error_code_output2],
        ...
    ])
    def test_something_throws_exception(
        self,
        test_input: str,
        expected_error_code: int
    ) -> None:
        # Arrange
        sut = SUT(...)
        ...  # More 'arrange' code
        
        # Act
        with self.assertRaises(SomeSUTException) as exception_context:
            sut.do_something(test_input)
        exception = exception_context.exception
        
        # Assert
        self.assertEquals(excepted_error_code, exception.error_code)
```