---
title: 'The merits of unit tests — Part 3'
published: '2017-11-22T16:04:44-05:00'
tags:
  - 'software engineering'
  - 'software testing'
abbrlink: 'the-merits-of-unit-tests-part-3'
lang: ''
series: 'unit-testing'
series_order: 3
series_label: 'Unit Testing'
series_section: 'Merits'
---

Cross posted on [LinkedIn](https://www.linkedin.com/pulse/merits-unit-tests-part-3-srikanth-sastry/).

Previously, I talked about how unit tests serve purposes other than verifying code functionality; I talked about [unit tests serving as defacto documentation](http://srikanth.sastry.name/merits-of-unit-tests-part-1/), and [unit tests helping you refactor without fear](http://srikanth.sastry.name/the-merits-of-unit-tests-part-2/). In this post, I'll talk about yet another benefit to unit tests: writing better software.

## Better software design

I am not talking about writing bug-free software here. Sure, good
unit tests help you discover/avoid large classes of bugs, but that's not
 the point. Unit tests also help you enforce good design patterns and
modularity in your software.

Unit tests help you with [software design](/garden/testability-drives-design/) in two complementary ways.
First, they help you establish optimal boundaries of modularity in terms
 of methods, and classes, and second, they help you understand your
dependencies better and almost force you to use good [dependency
injection](/garden/testability-forces-dependency-injection/) hygiene.

### Modularity

![](/assets/images/2019/01/0-2.jpg)

How do you know that your class or method does 'too much', or that it
 has undesirable side-effects? A pretty good way to discover it is to
start writing unit tests for it. If you find yourself having to test for
 too many different types of inputs, then your methods are doing too
much. If you find yourself having to test for too many orderings of
operations, when your methods have too many side effects. It really is
just as simple as that!

For instance, some time ago, I came across a piece of code that
essentially took a large query, split it up into multiple subqueries,
sent them off in parallel, collected their responses back, munged them
and returned the munged response to the caller via a callback. The code
looked something like this:

```java
public class QueryManager {
   void sendRequest(Query query, Callback queryCallback) {
     List<Subquery> subqueries = splitQuery(query);
     for (Subquery subquery : subqueries) {
       sendQuery(subquery, new Subquery.Callback() {
           @Override
           public onSuccess(Response response) {
             // Do some processing. ...
             if (allResponses()) {
               queryCallback.finalResult();
              } else {
                queryCallback.incrementalResult();
              }
            }
            @Override
            public onFailure(Error e) {
              // Do some error handling. ...
              if (allResponses()) {
                queryCallback.finalResult();
              }
            }
          });
     }
   }
     // Other methods. ...
}
```

This code makes for an interesting case study on multiple fronts, and  I will come back to it in a later post. For now, it is sufficient to  state that I wanted to make changes to this code, but it was pretty  thorny because (you guessed it!) it has no unit tests.

Naturally, the first step is to write unit tests for this class, and
that was when I realized why there were no unit tests here. This class
is incredibly tricky to unit test. Getting the subqueries to respond
under various conditions and ordering resulted in a combinatorial
explosion of test cases making the task intractable. This was very
strong code smell.

As you have probably figured out already, this was a classic case of a
 single class doing too much. The primary culprit was the anonymous
class that implemented the Subquery.Callback interface. It should really
 have been its own class with its own unit tests.

After I pulled out that anonymous class into its own class, it became
 a lot easier to unit test both the Subquery.Callback and the
QueryManager individually, and with that, the code became much more
modular, easier to read, and much easier to maintain.

### Dependency

![](/assets/images/2019/01/0-3.jpg)

If your code does not do a decent job of [injecting its dependencies](https://en.wikipedia.org/wiki/Dependency_injection)
 from outside, you are gonna have a bad time! Having good unit tests
will actually keep you from getting into this pitfall pretty
effectively. Consider the following contrived example. You have a piece
of code that writes to an external service, and your code throttles the
rate of writes because going over your approved rate/quota can be pretty
 expensive. So, your code could look something like this:

```cpp
class RateLimiter {
   void writeToExternalService(const vector<Entries>& stuff) {
     auto service = new ExternalService(ConnectionParameters foo);
     for (auto entry : stuff) {
       waitUntilQuotaAvailable();
       service.write(entry);
     }
   }
}
```

Remember how I said that going over the rate/quota is bad? How do you
 verify that it will not happen? Well, you could set up an elaborate
testbed that has an ExternalService simulator, and you can run your code
 through all sorts of inputs and verify that the simulator says that the
 rate limiting is work. But that's expensive, and if you choose to go
with a different external service, then well, good luck with that!

Instead, you could try to unit test it. But how? You need to have
access to the ExternalService to do that, which we have already
established is expensive! Well, this is where unit testing it will force
 you into healthy dependency injection. For this contrived example, you
can inject the dependency as follows.

```cpp
class RateLimiter {
   void writeToExternalService(
       const vector<Entries>& stuff,
       ExternalService service) {
     for (auto entry : stuff) {
       waitUntilQuotaAvailable();
       service.write(entry);
     }
   }
}
```

Your unit tests could do this:

```
TEST(AwesomeTestCase, testWrite) {
   vector<Entries> stuff = generateLotsOfStuff();
   RateLimits limit;  // Set your limits here.
   ExternalService svc = MockExternalService(limit);
   RateLimiter rateLimiter = new RateLimiter(limit);
   rateLimiter.writeToExternalService(stuff, svc);
   ASSERT_TRUE(svc.writesWithinLimits());
}
```

And you can put your implementation through the wringer without breaking a sweat.
