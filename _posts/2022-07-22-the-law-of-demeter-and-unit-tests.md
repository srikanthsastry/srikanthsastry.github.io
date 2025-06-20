---
title: "The Law of Demeter and unit tests"
date: 2022-07-22
id: 20220722094246
tags:
  - "unit tests"
  - "software engineering"
categories:
  - Professional
layout: post
permalink: /law-of-demeter-and-unit-tests/
image: /images/demeter-sketch-bw.jpg
...
<!-- ![](/images/demeter-sketch-bw.jpg) -->
The [Law of Demeter](https://en.wikipedia.org/wiki/Law_of_Demeter) essentially says that each unit should only talk to its 'immediate friends' or 'immediate dependencies', and in spirit, it is pointing to the principle that each unit only have the information it needs to meet its purpose. In that spirit, the Law of Demeter takes two forms that are relevant to making your code more testable: (1) object chains, and (2) fat parameters.

## Object Chains

This is the more classic violation of the Law of Demeter[^1]. This happens when a class `C` has a dependency `D`, and `D` has method `m` that returns an instance of another class `A`. The violation happens when `C` accesses `A` and calls a method in `A`. Note that only `D` is the 'immediate' collaborator/dependency of `C`, and not `A`. The Law of Demeter says that `C` should not be accessing the method in `A`.

```python
# A violation of the Law of Demeter looks as follows.
## Example 1:
c.d.m().methodInA()

## Example 2:
d: D = c.d
a: A = d.m()
a.methodInA()
```

What is the problem with violating the Law of Demeter?  Consider the following production code:
```python
class UpdateKVStore:
    def __init__(self, client: KVStoreClient) -> None:
        self.client = client
        
    def update_value(new_content: Content) -> Status:
        transaction: KVStoreClient.Transaction = self.client.new_transaction()
        if transaction.get_content() == new_content:
            # Nothing to update
            transaction.end()
            return Status.SUCCESS_UNCHANGED
        mutation_request: KVStoreClient.MutationRequest = (
            transaction.mutation_request().set_content(new_content)
        )
        mutation = mutation_request.prepare()
        status: KVStoreClient.Mutation = mutation.land()
        return status
```

Now how would you unit test this? The test doubles for testing this code will look something like this
```python
mock_client = MagicMock(spec=KVStoreClient)
mock_transaction = MagicMock(spec=KVStoreClient.Transaction)
mock_mutation_request = MagicMock(spec=KVStoreClient.MutationRequest)
mock_mutation = MagicMock(spec=KVStoreClient.Mutation)

mock_client.new_transaction.return_value = mock_transaction
mock_transaction.mutation_request.return_value = mock_mutation_request
mock_mutation_request.prepare.return_value = mock_mutation
```

Now you can see how much the class `UpdateKVStore` and its unit tests need to know about the internals of the `KVStoreClient`. Any changes to how the `KVStoreClient` implements the transaction will cascade into test failures on all its clients! That's a recipe for a [low accuracy](https://srikanth.sastry.name/unit-test-attributes-and-their-trade-offs/) test suite.

There are a few ways to address this. Instead, if `KVStoreClient` could be recast as a `Transaction` factory, and then encapsulate all operations associated with the transactions within the `Transaction` class, then `UpdateKVStore` can be modified as follows:

```python
class UpdateKVStore:
    def __init__(self, client: KVStoreClient) -> None:
        self.client = client  # Now a Factory class for Transaction.
        
    def update_value(new_content: Content) -> Status:
        transaction: KVStoreClient.Transaction = self.client.new_transaction()
        if transaction.get_content() == new_content:
            # Nothing to update
            transaction.end()
            return Status.SUCCESS_UNCHANGED
        status = transaction.update_and_land(new_content)
        return status
```

When testing the new `UpdateKVStore`, you only need to replace the `KVStoreClient` and the `Transaction`, both of which are (explicit or implicit) direct dependencies, with test doubles. This makes the code much easier and straightforward to test.

##  Fat Parameters

While the anti-pattern of 'fat parameters' does follow directly from the Law of Demeter, it does follow from the spirit of passing in only the information that the class needs to perform its function. So, what are fat parameters? They are data objects that as passed in as an argument to a class, and they contain more information than what is needed by the class.

For instance, say you have a class `EmailDispatcher` whose method `setRecipient` only needs a customer name and email address. The method signature for `setRecipient` should only require the name and email, and not the entire `Customer` object that contains a whole lot more.

```python
@dataclass(frozen=True)
class Customer:
    ... # data class members.
    def getFullName(self):
        ...
    def getEmail(self):
        ...
    def getPhysicalAddress(self):
        ...
    def getPostalCode(self):
        ...
    def getCountry(self):
        ...
    def getState(self):
        ...
    def getCustomerId(self):
        ...
    # and so on.
    
 class EmailDispatcher:
     ...
     def setRecipient(name: str, email: str):
         ...
     def setRecipientWithFatParameter(customer: Customer):
         ...
     def sendMessage(self, message: Message):
         ...
```

In the pseudocode above, the class `EmailDispatcher` has two methods `setRecipient` and `setRecipientWithFatParameter`. The former uses only the information it needs, and the latter passed in the entire `Customer` object as a fat parameter.

The convenience of passing in the entire `Customer` object is straightforward. It allows gives you a simple method signature. It makes it easier for the method to evolve to use richer information about the customer without needing to change its API contract. It allows you to define a common `Dispatcher` interface with multiple `Dispatcher`s that use different properties of the `Customer` class. 

However, when it comes to unit testing, such fat parameters present a problem. Consider how you would test the `EmailDispatcher`'s `setRecipientWithFatParameter` method. The tests will need to create fake `Customer` objects. So, your fake `Customers` might look like this:
```python
fakeCustomer = Customer(
    first_name="bob",
    last_name="marley", 
    email="bob@doobie.com", 
    address=Address(
        "420 High St.", 
      "", 
      "Mary Jane", 
      "Ganga Nation", 
      "7232"
    ), 
    id=12345, 
    postal_code="7232", 
    ...
)
```

When someone reads this unit test, do they know what is relevant here? Does it matter that the second parameter of `address` is empty string? Should the last parameter of `address` match the value of `postal_code`? While we might be able to guess it in this case, it gets more confusing in cases where the fat parameter is encapsulating a much more complicated entity, such as a database table. 

When refactoring or making changes to the `EmailDispatcher`, if the unit test fails, then figuring out why the test failed becomes a non-trivial exercise, and could end up slowing you down a lot more than you expected. All this just leads to high maintenance costs for tests, low readability [^2], poor DevX, and limited benefits.

[^1]: You can read about it [here](https://wouterdekort.com/2012/03/27/unit-testing-hell-or-heaven/), [here](https://hermanradtke.com/2010/01/17/unit-testing-and-the-law-of-demeter.html/), [here](https://wiki.c2.com/?LawOfDemeterMakesUnitTestsEasier), and [here](https://testing.googleblog.com/2008/07/breaking-law-of-demeter-is-like-looking.html), and really just search for "Law of Demeter" on the Internet

[^2]: For more details on why we should care about readability, see the section on Readability [here](https://srikanth.sastry.name/dry-unit-tests-are-bad/).

