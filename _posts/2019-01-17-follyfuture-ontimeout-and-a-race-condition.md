---
id: 348
title: 'folly:Future, onTimeout(), and a race condition'
date: '2019-01-17T19:38:48-05:00'
author: 'Srikanth Sastry'
layout: post
permalink: /follyfuture-ontimeout-and-a-race-condition/
categories:
    - Professional
tags:
    - c++
    - 'software engineering'
image: /assets/images/2019/01/C-programming-in-a-nutshell-Imgur-450x450.png
---

**TL;DR.** The inability to cancel threads in C++ can result in bizarre semantics even in seemingly straightforward (and almost) declarative code. folly::Future is an interesting case in point.

[Folly Futures](https://github.com/facebook/folly/blob/master/folly/docs/Futures.md) is an Async C++ framework from Facebook. It has an interesting function [onTimeout()](https://github.com/facebook/folly/blob/8757861f41c4b58ac2948ef3dc91aef9cdc8aba0/folly/futures/Future.h#L1545), which essentially allows to stop waiting on a Future forever. So you would typically use it as follows.

```cpp
provider_.getOperationFuture(Request r)
   .then([&](Response response) {
     doFoo();  // Accesses variables in the surrounding scope
   })
   .onTimeout(milliseconds(500), [&]{
     doBar();  // Accesses variables in the surrounding scope
   })
.get();
```

The semantics that I expected from this piece of code was the following:

```
if there is no response within 500 milliseconds, then
   the future throws a timeout, thus executing  doBar()
  else
   the future executes the then() block, thus executing doFoo(
```

Importantly, I was expecting exactly one of the two function doFoo() or doBar() to be executed. And it turns out not be true!

## Race Condition

It turns out that the Future has a background thread running waiting for the response, and this thread is not cancelled upon timeout because:

1. This thread is spawned first, and that in-turn waits on the timeout, and
2. C++ does not support canceling threads.

So, we now have a race condition between the Future's response and timeout, thus potentially causing memory overruns and segfaults. How do you get around this? How do you use folly::Future with the semantics I outlined above?

## Remedies

I found two possible ways for this.

### Swap onTimeout() and then()

```cpp
provider_.getOperationFuture(Request r)
  .onTimeout(milliseconds(500), [&]{
     doBar();  // Accesses variables in the surrounding scope
     return Response::onTimeout();
   })
   .then([&](Response response) {
     if (response == Response::onTimeout()) {
       return;
     }
     doFoo();  // Accesses variables in the surrounding scope
   })
   .get();
```

Essentially, you force the onTimeout block to return a special instance of the Reponse object (called Response::onTimeout() here), this then becomes the input to the then block, and within the then block you can check if the response is valid and proceed accordingly.
Yes, I know it's  ugly.
Worse, what if the Response object is complex enough that you cannot simply build a special instance of it? Or what if every possible instance of the Response object is potentially valid? Then you can go for the next remedy.

### Open up onTimeout()

It is useful to remember that onTimeout() is just syntactic sugar for the following.

```
provider_.getOperationFuture(Request r)
   .within(milliseconds(500))
   .onError([](const TimedOut& e){
      doBar();
     return Response::onTimeout();
   })
   .then(...);
```

So, you can use this to refactor your code to look something like this:

```cpp
provider_.getOperationFuture(Request r)
   .within(milliseconds(500))
   .then([&](Response response) {
     doFoo();  // Accesses variables in the surrounding scope
   })
   .onError([&](const folly::Timeout& ){
     doBar();  // Accesses variables in the surrounding scope
   })
   .get();
```

This essentially, raises an exception after 500 milliseconds of no response, and that exception ensures that the then block is never executed!
 So, yeah, folly::Future can be tricky.
