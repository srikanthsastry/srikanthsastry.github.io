---
title: 'Reuse Code, Not Objects'
published: '2021-07-16T22:01:41-04:00'
tags:
  - 'design pattern'
  - 'software engineering'
abbrlink: 'reuse-code-not-objects'
lang: ''
---

We all know of the importance of [code reuse](https://en.wikipedia.org/wiki/Code_reuse) and [DRY](https://en.wikipedia.org/wiki/Don%27t_repeat_yourself) code. It is important to remember that this applies to code, and *not* to [objects](/garden/reuse-code-not-objects/)!
A common anti-pattern I see in stateful classes is something along the following lines:

```java
class SomeStatefulClass {
  private ResponseType responseType;
  private final ErrMessages errMessages;

  public SomeStatefulClass() {
    this.ResponseType = null;
    this.errMessages = new ErrMessages();
  }

  public void init() {
    errMessages.clear();
  }

  public Response process(Request request) {
    try {
      // Process the request.
      // Update stats.
      // Update otherState.
      Response response = computeResponse();
      responseType = computeResponseType();
      return response;
    } catch (Exception e) {
      this.errMessages.append(e);
    }
    return null;
  }

  public LogMessages getErrMessages() {
    return this.errMessages;
  }

  public ResponseType getResponseType() {
    return responseType;
  }
}
```

This design pattern is a major code smell. Ironically, such classes are prone to be *misused through reuse*. A common example of this is reusing the object within a loop:

```java
public void process(List<Request> requests) {
  final SomeStatefulClass statefulObject
      = new SomeStatefulClass();
  Response response;
  for (Request request: requests) {
    statefulObject.init();
    response = statefulObject.process(request);
    appendResponse(response, statefulObject.getResponseType());

  }
}
```

The issue here is subtle, but dangerous. Consider what happens if one of the requests in the list of requests passed to `process()` causes `statefulObject`to throw an exception inside `computeResponse()`. Dutifully, this exception is caught by `process()` and it returns `null`. However, note that the value of `responseType` in `statefulObject` was never modified by processing of this request, and therefore, it still hold the `ResponseType` of the previous request! Therefore, the line `appendResponse(response, statefulObject.getResponseType());` is now passing in a null response and the response type of the previous request!

These types of bugs are subtle and a pain to track down.

And this happened because we chose to reuse the `statefulObject`. If we were to use a new instance each time, this would not really be an issue.

**Moral: If feasible, do not reuse objects; create new instances and throw them away when done!**
