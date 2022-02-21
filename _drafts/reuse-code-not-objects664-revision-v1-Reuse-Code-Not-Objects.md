---
id: 671
title: 'Reuse Code, Not Objects'
date: '2021-07-17T14:16:10-04:00'
author: 'Srikanth Sastry'
layout: revision
guid: 'https://srikanth.sastry.name/664-revision-v1/'
permalink: '/?p=671'
---

<!-- wp:image {"id":666} -->
<figure class="wp-block-image"><img src="https://srikanth.sastry.name/wp-content/uploads/2021/07/pexels-photo-5218009-edited.jpeg" alt="" class="wp-image-666"/></figure>
<!-- /wp:image -->

<!-- wp:paragraph -->
<p>We all know of the importance of <a href="https://en.wikipedia.org/wiki/Code_reuse">code reuse</a> and <a href="https://en.wikipedia.org/wiki/Don%27t_repeat_yourself">DRY</a> code. It is important to remember that this applies to code, and <em>not</em> to objects!<br>A common anti-pattern I see in stateful classes is something along the following lines:</p>
<!-- /wp:paragraph -->

<!-- wp:code -->
<pre class="wp-block-code"><code>class SomeStatefulClass {
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
}</code></pre>
<!-- /wp:code -->

<!-- wp:paragraph -->
<p>This design pattern is a major code smell. Ironically, such classes are prone to be <em>misused through reuse</em>. A common example of this is reusing the object within a loop:</p>
<!-- /wp:paragraph -->

<!-- wp:code -->
<pre class="wp-block-code"><code>public void process(List&lt;Request&gt; requests) {
  final SomeStatefulClass statefulObject
      = new SomeStatefulClass();
  Response response;
  for (Request request: requests) {
    statefulObject.init();
    response = statefulObject.process(request);
    appendResponse(response, statefulObject.getResponseType());
    
  }
}</code></pre>
<!-- /wp:code -->

<!-- wp:paragraph -->
<p>The issue here is subtle, but dangerous. Consider what happens if one of the requests in the list of requests passed to <code>process()</code> causes <code>statefulObject</code>to throw an exception inside <code>computeResponse()</code>. Dutifully, this exception is caught by <code>process()</code> and it returns <code>null</code>. However, note that the value of <code>responseType</code> in <code>statefulObject</code> was never modified by processing of this request, and therefore, it still hold the <code>ResponseType</code> of the previous request! Therefore, the line <code>appendResponse(response, statefulObject.getResponseType());</code> is now passing in a null response and the response type of the previous request!<br />These types of bugs are subtle and a pain to track down.<br />And this happened because we chose to reuse the <code>statefulObject</code>. If we were to use a new instance each time, this would not really be an issue.<br />Moral: If feasible, do not reuse objects; create new instances and throw them away when done!</p>
<!-- /wp:paragraph -->