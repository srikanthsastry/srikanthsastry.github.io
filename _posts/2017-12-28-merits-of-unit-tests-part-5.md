---
id: 392
title: 'Merits of unit tests &#8212; part 5'
date: '2017-12-28T16:25:49-05:00'
author: 'Srikanth Sastry'
layout: post
permalink: /merits-of-unit-tests-part-5/
categories:
    - Professional
tags:
    - 'software engineering'
    - 'software testing'
---

Cross posted on [LinkedIn](https://www.linkedin.com/pulse/merits-unit-tests-part-5-srikanth-sastry/).

This is the fifth, and final, post in my series of notes on unit tests. So far, we've talked about how unit tests help us in [documenting our code](http://srikanth.sastry.name/merits-of-unit-tests-part-1/), [reliably refactor software](http://srikanth.sastry.name/the-merits-of-unit-tests-part-2/), [build better code](http://srikanth.sastry.name/the-merits-of-unit-tests-part-3/), and even [help debugging in prod](http://srikanth.sastry.name/unit-tests-ftw-part-4/).  In this post, we'll discuss how unit tests (more precisely, the act of  writing unit tests) help us improve the usability of our code.

## Usability

It is fairly accurate to state that the simpler and more usable your
API is, the less likely it is to be misunderstood, misused, and abused.
Also, simpler API constrains your possible code paths making it more
testable and less bug-prone. I claim that the very act of making unit
tests will help you write more usable code/API. (Of course, this assumes
 an earnest effort in writing good quality unit tests, which can be a
topic of discussion in its own right).

The reason for my claim is simple, by writing extensive unit tests
that account for all your use cases, you effectively [become your own
first customer](/garden/tests-as-first-customer/). This forces you you to wear your customer's hat and
really probe the user experience of your API. In fact, it is not
uncommon for me to iterate on my APIs multiple times simply because I am
 not happy with how difficult it is to set up and execute my unit tests.

> by writing extensive unit tests that account for all your use cases, you effectively become your own first customer

Let's take a fictional example of a class that does the following: It
 retrieves either a URL, or the content of the URL for a given handle
that could potentially need to be authenticated as a specific user, and
it can do so periodically. Here is a first crack at the API and usage
for it.

```python
class UrlRetriever {
   // Unauthenticated, one-time
   UrlRetriever(Handle handle);
   // Authenticated, one-time
   UrlRetriever(String user, Handle handle);
   // Authenticated, periodic
   UrlRetriever(String user, Handle handler, int periodInSeconds);
   // Unauthenticated, periodic
   UrlRetriever(Handle handler, int periodInSeconds);

   String getUrl();
   Blob getContents();
   void getContentsPeriodically(Callback cb);
   void getUrlPeriodically(Callback cb)
}
```

When you start writing unit tests for this, you start seeing issues
with usability. For example, you have to consider all possible
constructions of UrlRetriever with getUrl() or getContents() call.
Worse, what happens if the UrlRetriever is constructed without a
periodInSeconds argument, and someone invokes getContentsPeriodically()
on it? Sure, it is nonsensical, but you still need a test case for it,
right? Which means, the clients could potentially misuse the class in
this fashion, in part because the usability of this API is poor.

Making an honest attempt at writing unit tests can actually help you
detect such usability issues! Consider the next iteration for the same
use case, informed (or constrained) by the unit tests.

```python
class UrlRetriever {
   UrlRetriever(Handle handle);
   AuthenticatedUrlRetriever withAuth(String user);
   String getUrl();
   Blob getContents();
   void getPeriodically(ContentCallback cb, int periodInSeconds);
   void getPeriodically(UrlCallback cb, int periodInSeconds);
}
class AuthenticatedUrlRetriever inherits UrlRetriever {
   // Does not make sense to authenticate with another user.
   AuthenticatedUrlRetriever withAuth(String user) throws exception;
}
```

You will see that writing unit tests for it is much easier, and
furthermore, there is less chance of misusing this API. Both of this is
true because the API is more usable. The clients can use it in multiple,
 but limited/tractable. Here is how it ends up looking in the unit
tests.

```
// one-time unauthenticated
url = UrlRetriever(handle).getUrl();
 // periodic unauthenticated (1)
 // -- MyCallback inherits UrlCallback.
urlCallback = new MyCallback();
UrlRetriever(handle).getPeriodically(urlCallback, 30);
  // periodic unauthenticated (2)
 // -- MyCallback inherits ContentCallback.
contentCallback = new MyCallback(); UrlRetriever(handle).getPeriodically(contentCallback, 30);
  // Authenticated
foo = UrlRetriever(handle).withAuth(user);
 //  -- one-time
blob = foo.getContents();
 //  -- periodic
foo.getPeriodically(contentCallback, 60);
```

Much better eh? :)
