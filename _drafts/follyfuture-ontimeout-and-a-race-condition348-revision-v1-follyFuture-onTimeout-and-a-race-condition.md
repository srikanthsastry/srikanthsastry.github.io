---
id: 367
title: 'folly:Future, onTimeout(), and a race condition'
date: '2019-01-17T19:38:48-05:00'
author: 'Srikanth Sastry'
layout: revision
guid: 'http://srikanth.sastry.name/348-revision-v1/'
permalink: '/?p=367'
---

<!-- wp:image {"id":365,"align":"center","width":338,"height":338} -->
<div class="wp-block-image"><figure class="aligncenter is-resized"><img src="http://srikanth.sastry.name/wp-content/uploads/2019/01/C-programming-in-a-nutshell-Imgur-450x450.png" alt="" class="wp-image-365" width="338" height="338"/></figure></div>
<!-- /wp:image -->

<!-- wp:paragraph -->
<p><strong>TL;DR.</strong> The inability to cancel threads in C++ can result in bizarre semantics even in seemingly straightforward (and almost) declarative code. folly::Future is an interesting case in point.</p>
<!-- /wp:paragraph -->

<!-- wp:more -->
<!--more-->
<!-- /wp:more -->

<!-- wp:paragraph -->
<p><a href="https://github.com/facebook/folly/blob/master/folly/docs/Futures.md">Folly Futures</a> is an Async C++ framework from Facebook. It has an interesting function <a href="https://github.com/facebook/folly/blob/8757861f41c4b58ac2948ef3dc91aef9cdc8aba0/folly/futures/Future.h#L1545">onTimeout()</a>, which essentially allows to stop waiting on a Future forever. So you would typically use it as follows.</p>
<!-- /wp:paragraph -->

<!-- wp:preformatted -->
<pre class="wp-block-preformatted">provider_.getOperationFuture(Request r)<br>   .then([&amp;](Response response) {<br>     doFoo();  // Accesses variables in the surrounding scope<br>   })<br>   .onTimeout(milliseconds(500), [&amp;]{<br>     doBar();  // Accesses variables in the surrounding scope<br>   })   <br>.get();</pre>
<!-- /wp:preformatted -->

<!-- wp:paragraph -->
<p>The semantics that I expected from this piece of code was the following: </p>
<!-- /wp:paragraph -->

<!-- wp:preformatted -->
<pre class="wp-block-preformatted">if there is no response within 500 milliseconds, then<br>   the future throws a timeout, thus executing  doBar()<br>  else<br>   the future executes the then() block, thus executing doFoo(</pre>
<!-- /wp:preformatted -->

<!-- wp:paragraph -->
<p>Importantly, I was expecting exactly one of the two function doFoo() or doBar() to be executed. And it turns out not be true!</p>
<!-- /wp:paragraph -->

<!-- wp:heading -->
<h2>Race Condition</h2>
<!-- /wp:heading -->

<!-- wp:paragraph -->
<p>It turns out that the Future has a background thread running waiting for the response, and this thread is not cancelled upon timeout because: </p>
<!-- /wp:paragraph -->

<!-- wp:list {"ordered":true} -->
<ol><li>This thread is spawned first, and that in-turn waits on the timeout, and</li><li>C++ does not support canceling threads.</li></ol>
<!-- /wp:list -->

<!-- wp:paragraph -->
<p>So, we now have a race condition between the Future's response and timeout, thus potentially causing memory overruns and segfaults. How do you get around this? How do you use folly::Future with the semantics I outlined above? </p>
<!-- /wp:paragraph -->

<!-- wp:heading -->
<h2>Remedies</h2>
<!-- /wp:heading -->

<!-- wp:paragraph -->
<p>I found two possible ways for this.</p>
<!-- /wp:paragraph -->

<!-- wp:heading {"level":3} -->
<h3>Swap onTimeout() and then()</h3>
<!-- /wp:heading -->

<!-- wp:preformatted -->
<pre class="wp-block-preformatted">provider_.getOperationFuture(Request r)<br>  .onTimeout(milliseconds(500), [&amp;]{<br>     doBar();  // Accesses variables in the surrounding scope<br>     return Response::onTimeout();<br>   })<br>   .then([&amp;](Response response) {<br>     if (response == Response::onTimeout()) {<br>       return;<br>     }<br>     doFoo();  // Accesses variables in the surrounding scope<br>   })<br>   .get();</pre>
<!-- /wp:preformatted -->

<!-- wp:paragraph -->
<p>Essentially, you force the onTimeout block to return a special instance of the Reponse object (called Response::onTimeout() here), this then becomes the input to the then block, and within the then block you can check if the response is valid and proceed accordingly. 
Yes, I know it's  ugly.
Worse, what if the Response object is complex enough that you cannot simply build a special instance of it? Or what if every possible instance of the Response object is potentially valid? Then you can go for the next remedy.</p>
<!-- /wp:paragraph -->

<!-- wp:heading {"level":3} -->
<h3>Open up onTimeout()</h3>
<!-- /wp:heading -->

<!-- wp:paragraph -->
<p>It is useful to remember that onTimeout() is just syntactic sugar for the following. </p>
<!-- /wp:paragraph -->

<!-- wp:preformatted -->
<pre class="wp-block-preformatted">provider_.getOperationFuture(Request r)<br>   .within(milliseconds(500))<br>   .onError([](const TimedOut&amp; e){<br>      doBar();<br>     return Response::onTimeout();<br>   })<br>   .then(...);</pre>
<!-- /wp:preformatted -->

<!-- wp:paragraph -->
<p>So, you can use this to refactor your code to look something like this: </p>
<!-- /wp:paragraph -->

<!-- wp:preformatted -->
<pre class="wp-block-preformatted">provider_.getOperationFuture(Request r)<br>   .within(milliseconds(500))<br>   .then([&amp;](Response response) {<br>     doFoo();  // Accesses variables in the surrounding scope<br>   })<br>   .onError([&amp;](const folly::Timeout&amp; ){<br>     doBar();  // Accesses variables in the surrounding scope<br>   })<br>   .get();</pre>
<!-- /wp:preformatted -->

<!-- wp:paragraph -->
<p>This essentially, raises an exception after 500 milliseconds of no response, and that exception ensures that the then block is never executed!
 So, yeah, folly::Future can be tricky.</p>
<!-- /wp:paragraph -->