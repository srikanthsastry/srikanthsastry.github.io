---
title: Mocks, Stubs, and how to use them
id: 20220525095914
tags:
    - testing
    - 'software engineering'
    - 'test doubles'
    - mocks
    - stubs

excerpt: >
  Test doubles are the standard mechanism to isolate your System-Under-Test (SUT) from external dependencies in unit tests.
  Unsurprisingly, it is important to use the right test double for each use case for a maintainable and robust test suite.
  However, I have seen a lot of misuse of test doubles, and suffered through the consequences of it enough number of times
  to want to write down some (admittedly subjective) guidelines on when an how to use test doubles. 
categories:
    - Professional
permalink: /mocks-stubs-andhow-to-use-them/
layout: post
---

![Photo by Polina Kovaleva from Pexels](/images/masquerade-masks.jpg)
_Photo by [Polina Kovaleva](https://www.pexels.com/@polina-kovaleva?utm_content=attributionCopyText&utm_medium=referral&utm_source=pexels) from [Pexels](https://www.pexels.com/photo/close-up-of-masquerade-masks-on-purple-background-8404608/?utm_content=attributionCopyText&utm_medium=referral&utm_source=pexels)_

[Test doubles](https://en.wikipedia.org/wiki/Test_double) are the standard mechanism to isolate your System-Under-Test (SUT) from external dependencies in unit tests. Unsurprisingly, it is important to use the right test double for each use case for a maintainable and robust test suite. However, I have seen a lot of misuse of test doubles, and suffered through the consequences of it enough number of times to want to write down some (admittedly subjective) guidelines on when an how to use test doubles. 

Briefly, test doubles are [replacements for a production object used for testing](https://martinfowler.com/bliki/TestDouble.html). Depending on who you ask, there are multiple different categorizations of test doubles; but two categories that appears in all of these categorizations are [mocks](https://en.wikipedia.org/wiki/Mock_object) and [stubs](https://en.wikipedia.org/wiki/Test_stub). So I will focus on on these two. I have seen mocks and stubs often conflated together. The problem is made worse by all the test-double frameworks' terminology: they are often referred to as 'mocking' frameworks, and the test doubles they generate are all called 'mocks'. 

## Mocks

![woman wearing an emoji mask](/images/woman-wearing-emoji-mask.jpg)

_Image by [Andii Samperio](https://pixabay.com/users/5697702-5697702/?utm_source=link-attribution&amp;utm_medium=referral&amp;utm_campaign=image&amp;utm_content=2428737) from [Pixabay](https://pixabay.com/?utm_source=link-attribution&amp;utm_medium=referral&amp;utm_campaign=image&amp;utm_content=2428737)_


Mocks are objects that are used to verify 'outbound' interactions of the SUT with external dependencies. This is different from the notion of 'mocks' that 'mocking frameworks' generate. Those 'mocks' are more correctly the superclass of test doubles.
Examples where mocks are useful include the SUT logging to a log server, or sending an email, or filing a task/ticket in response to a given input/user journey. This becomes clearer with an illustration.

```python
from unittest.mock import MagicMock

class TestSUT(unittest.TestCase):
    def test_log_success(self) -> None:
        mock_log_server = MagicMock(spec=LogServerClass, autospec=True)
        mock_log_server.log = MagicMock(return_value=True)
        sut = SUT(log_server=mock_log_server)
        
        sut.test_method(input="foo")
        
        # This is ok!
        mock_log_server.log.assert_called_once_with(message="foo")

```

Note that in the above illustration, we verify that the message is sent to the the log server exactly once. This is an important part of the SUT's specification. It the SUT were to start logging multiple messages/records for the request, then it could pollute the logs or even overwhelm the log server. Here, even though logging appears to be a side effect of `test_method`, this side effect is almost certainly part of SUT's specification, and needs to be verified correctly. Mocks play a central role in such verifications.

## Stubs

![Robot imitating family](/images/robot-imitating-family.jpg)

Unlike mocks, stubs verify 'inbound' interactions from external dependencies to the SUT. Stubs are useful when replacing external dependencies that 'send' data to the SUT in order for the SUT to satisfy its specification. Examples include key value stores, databases, event listeners, etc. The important note here is that the outbound interaction to the stub _should not be asserted_ in the tests; that's an anti pattern (it results in over-specification)! Here is an illustration.

```python
from unittest.mock import MagicMock

class TestSUT(unittest.TestCase):
    def test_email_retrieval(self) -> None:
        stub_key_value_store = MagicMock(spec=KeyValueStoreClass, autospec=True)
        stub_key_value_store.get = MagicMock(return_value="user@special_domain.com")
        sut = SUT(key_value_store=stub_key_value_store)
        
        email_domain = sut.get_user_email_domin(username="foo")
        
        # This is ok!
        self.assertEquals("special_domain.com", email_domain)
        
        # THIS IS NOT OK!
        stub_key_value_store.get.assert_called_once_with(username="foo")

```
In the above illustration, we create a stub for the key value store (note that this is a stub even thought the object is a 'mock' class) that returns `"user@special_domain.com"` as a canned response to a `get` call. The test verifies that the SUT's `get_user_email_domain` is called, it returns the correct email domain. What is important here is that we _should not_ assert that there was a `get` call to the stub. Why? Because the call to the key value store is an implementation detail. Imagine a refactor that causes a previous value to be cached locally. If the unit tests were to assert on calls to the stubs, then such refactors would result in unit test failures, which undermines the utility, maintainability, and robustness of unit tests.

### Fakes, instead of stubs

A small detour here. When using a stub, always consider if you can use a fake instead. There are multiple definitions of a fake, and the one I am referring to is the following. A fake is a special kind of stub that implements the same API as the production dependency, but the implementation is much more lightweight. This implementation may be correct only within the context of the unit tests where it is used. Let's reuse the previous illustration of using a stub, and replace the stub with a fake. Recall that we stubbed out the `get` method of `KeyValueStoreClass` to return the canned value `"user@special_domain.com"`. Instead, we can implement a fake `KeyValueStoreClass` that uses a `Dict` as follows.

```python
from unittest.mock import MagicMock
from typing import Dict

# We assume a simplistic API for KeyValueStoreClass with just
# update and get methods.
class KeyValueStoreClass:
    def update(self, k: str, v: str) -> None:
        ...
    def get(self, k: str) -> str:
        ...

class FakeKeyValueStoreClassImpl:
    def __init__(self):
        self.kvs: Dict[str, str] = {}
    
    def update(self, k:str, v:str) -> None:
        self.kvs[k] = v

    def get(self, k: str) -> str:
        return self.kvs[k]


class TestSUT(unittest.TestCase):
    def test_email_retrieval(self) -> None:
        FakeKeyValueStoreClass = MagicMock(return_value=FakeKeyValueStoreClassImpl())
        fake_key_value_store = FakeKeyValueStoreClass()
        fake_key_value_store.update(k="foo", v="user@special_domain.com")
        sut = SUT(key_value_store=fake_key_value_store)
        
        email_domain = sut.get_user_email_domin(username="foo")
        
        self.assertEquals("special_domain.com", email_domain)
```

The advantage of using a fake is that the test becomes much more robust and is more resistant to refactoring. It also becomes more extensible. When using a stub, if we wanted to test a different user journey, we would need to inject a new return value for `KeyValueStoreClass.get` method. We would in one of two ways:  (1) resetting the mock, which is a bad anti-pattern, or (2) initialize the stub to return a preconfigured list of canned values, in order, which makes the test more brittle (consider what happens if the SUT chooses to call `get` for the same key twice vs. calls `get` for different keys once each). Using a fake sidesteps these issues.

## But my dependency has both inbound and outbound interactions!

![Photograph of man double exposure](/images/man-double-exposed-photo.jpg)

Despite all your efforts to separate out the test cases that need stubs and the ones that need mocks, you will inevitably find yourself needing to test a scenario in which you need to verify both inbound and outbound interactions with an external dependency. How do we address that? 

First, if you need to assert on the outbound interaction of the same call that is stubbed, then you really don't need that test. Just use a stub/fake and do not assert on the outbound interaction. Next, the only legitimate case of needing to verify both inbound and outbound interactions is if they are on distinct APIs of the same dependency. For example, the SUT could be reading from a file, and you need to test that (1) the contents of the file were read correctly, and (2) the file object was closed after the file was read. In this case, it is perfectly ok to stub the file `read` method while mocking the `close` method. Here is an illustration.
```python
from unittest.mock import MagicMock, patch

class TestSUT(unittest.TestCase):
    def test_file_read(self) -> None:
        file_mock_stub_combo = MagicMock()
        # Using this as a stub by injecting canned contents of the file
        file_mock_stub_combo.__iter__.return_value = ["1234"]
        
        # Next, we treat the file open call as a mock.
        with patch("builtins.open",
                   return_value=file_mock_stub_combo, 
                   create=True
                  ) as mock_file:
            sut = SUT(filename="foo")
            file_contents = sut.get_contents()
            
            # Assertions on call to file open.
            # Treating the 'open' call as a mock.
            mock_file.assert_called_once_with("foo")
        
            # Assertion on the contents returned.
            # Treating the `read` as a stub.
            self.assertEquals("1234", file_contents)
        
            # Assertion on the outbound interaction of file close.
            # Treating the 'close' call as a mock.
            file_mock_stub_combo.close.assert_called_once()
```

