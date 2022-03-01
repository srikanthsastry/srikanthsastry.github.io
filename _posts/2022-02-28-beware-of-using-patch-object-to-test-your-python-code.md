---
title: Beware of using patch.object to test your Python code
id: 20220228213509
tags:
    - python
    - patch
    - testing
    - 'software engineering'
categories:
    - Professional
permalink: /beware-of-using-patch-object-to-test-your-python-code/
...
![Software Testing](/images/software-testing.jpg)

[Liskov substitution principle](https://en.wikipedia.org/wiki/Liskov_substitution_principle) states that a class and its subclass must be interchangeable without breaking the program. Unfortunately, Python's [`patch.object`](https://docs.python.org/3/library/unittest.mock.html#patch-object) breaks this principle in a big way. In fact, **this can make your tests untrustworthy and become a maintenance headache with failures every time you extended your base class**. Here is a contrived, but concrete example.

<!-- more -->

Say, you decide to build a special class called `ImmutableList` with a factory that looks as follows:
```python
from typing import List, Sequence
class ImmutableList:
  @staticmethod
  def create_list(input: List[int]) -> "ImmutableList":
    return ImmutableList(input)

  def __init__(self, input: List[int]) -> None:
    self._inner_list = tuple(input)

  def get_inner_list(self) -> Sequence[int]:
    self._inner_list
```

Next, your system under test is a class `SUT` that uses an instance of `ImmutableList` as an injected dependency.
```python
class SUT:
  def __init__(self, wrapper: ImmutableList) -> None:
    self.wrapper = wrapper

  def get_wrapper_length(self) -> int:
    return len(self.wrapper.get_inner_list())
```

Now, when testing `SUT`, say, we patch the `get_inner_list()` method with `patch.object`:
```python
from unittest import mock

with mock.patch.object(ImmutableList, 'get_inner_list', return_value=[1, 2, 3]) as mock_method:
  sut = SUT(ImmutableList.create_list([]))
  assert sut.get_wrapper_length() == 3, "FAILURE"
  print("SUCCESS")
```
When you run this test, it does print `SUCCESS`, and therefore, works as intended.

Now, let's say that we found a special case of `ImmutableList` that corresponds to a zero length list, and we implement it as follows:
```python
class ZeroLengthImmutableList(ImmutableList):
  def __init__(self):
    super().__init__([])
  
  def get_inner_list(self) -> Sequence[int]:
    return tuple()
```
Next, we modify the factory method to return this `ZeroLengthImmutableList`, when the input is an empty list, as follows:
```python
  @staticmethod
  def create_list(input: List[int]) -> "ImmutableList":
    if len(input) == 0:
      return ZeroLengthImmutableList()
    return ImmutableList(input)
```

Thus, the two classes look as follows:
```python
class ImmutableList:
  @staticmethod
  def create_list(input: List[int]) -> "ImmutableList":
    if len(input) == 0:
      return ZeroLengthImmutableList()
    return ImmutableList(input)

  def __init__(self, input: List[int]) -> None:
    self._inner_list = input

  def get_inner_list(self) -> Sequence[int]:
    self._inner_list

class ZeroLengthImmutableList(ImmutableList):
  def __init__(self):
    super().__init__([])
  
  def get_inner_list(self) -> Sequence[int]:
    return tuple()
```

Now, let's go back to our test, which is still
```python
from unittest import mock

with mock.patch.object(ImmutableList, 'get_inner_list', return_value=[1, 2, 3]) as mock_method:
  sut = SUT(ImmutableList.create_list([]))
  assert sut.get_wrapper_length() == 3, "FAILURE"
  print("SUCCESS")
```
Since `sut.wrapper` is still an `ImmutableList`, by the Liskov Substitution Principle, `mock.patch.object(ImmutableList, 'get_inner_list', return_value=[1, 2, 3])` should still return `[1, 2, 3]` when `sut.get_wrapper_length()`. However, this does not happen! The above test fails with
```
AssertionError                            Traceback (most recent call last)

<ipython-input-21-1c1b12b89ff3> in <module>()
     23 with mock.patch.object(ImmutableList, 'get_inner_list', return_value=[1, 2, 3]) as mock_method:
     24   sut = SUT(ImmutableList.create_list([]))
---> 25   assert sut.get_wrapper_length() == 3, "FAILURE"
     26   print("SUCCESS")

AssertionError: FAILURE
```
This forces you to change the tests every time you refactor `ImmutableList.create_list` to return a 'better' implementation of `ImmutableList`!