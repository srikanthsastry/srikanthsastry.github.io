---
id: 391
title: 'Unit tests FTW! — Part 4'
date: '2019-01-22T16:24:53-05:00'
author: 'Srikanth Sastry'
layout: revision
guid: 'http://srikanth.sastry.name/390-revision-v1/'
permalink: '/?p=391'
---

<!-- wp:paragraph {"backgroundColor":"pale-cyan-blue"} -->
<p class="has-background has-pale-cyan-blue-background-color">Cross posted on <a href="https://www.linkedin.com/pulse/unit-tests-ftw-part-4-srikanth-sastry/">LinkedIn</a></p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>In the previous three  parts of this series, I have talked about how unit tests are useful in a  lot more than just verifying that your code works. We've talked its  uses for <a rel="noreferrer noopener" aria-label="documentation (opens in a new tab)" href="http://srikanth.sastry.name/merits-of-unit-tests-part-1/" target="_blank">documentation</a>, <a rel="noreferrer noopener" aria-label="refactoring and code health (opens in a new tab)" href="http://srikanth.sastry.name/the-merits-of-unit-tests-part-2/" target="_blank">refactoring and code health</a>, and <a rel="noreferrer noopener" aria-label="writing better software (opens in a new tab)" href="http://srikanth.sastry.name/the-merits-of-unit-tests-part-3/" target="_blank">writing better software</a>. Next, we'll see how unit tests helps you debug issues in production. </p>
<!-- /wp:paragraph -->

<!-- wp:more -->
<!--more-->
<!-- /wp:more -->

<!-- wp:heading {"level":3} -->
<h3>Debugging </h3>
<!-- /wp:heading -->

<!-- wp:paragraph -->
<p>A single unit test is supposed to test a single code path within your
 class. I don't always follow this maxim, but it is nevertheless a very 
good rule of thumb. Given that the number of code paths within a given 
code if often increases exponentially with the size of the code, unit 
tests are often a lot more lines of code than the actual production code
 itself. This is a good thing when it comes to debugging.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>If your unit tests cover sufficiently many code paths (which any good
 unit test suite should do), then when an issue arises in production, 
and you narrow it down to your code, then you know that the offending 
code path could not have been the several code paths that your unit 
tests already covered. This pruning makes your debugging a lot simpler 
than before.</p>
<!-- /wp:paragraph -->

<!-- wp:quote -->
<blockquote class="wp-block-quote"><p>
  Unit tests can prune the possible set of offending code paths to make debugging tractable, 
</p></blockquote>
<!-- /wp:quote -->

<!-- wp:paragraph -->
<p><strong>EXAMPLE</strong></p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>Let's go back to the example I gave you in <a href="https://www.linkedin.com/pulse/merits-unit-tests-part-3-srikanth-sastry/" target="_blank" rel="noreferrer noopener">Part 3</a>.
 Here is that piece of code. Recall that it takes a large query, splits 
it up into multiple subqueries, sends them off in parallel, collects 
their responses back, munges them and returns the munged response to the
 caller via a callback </p>
<!-- /wp:paragraph -->

<!-- wp:preformatted -->
<pre class="wp-block-preformatted">public class QueryManager {<br>   void sendRequest(Query query, Callback queryCallback) {<br>     List&lt;Subquery> subqueries = splitQuery(query);<br>     for (Subquery subquery : subqueries) {<br>       sendQuery(subquery, new Subquery.Callback() {<br>           @Override<br>           public onSuccess(Response response) {<br>             // Do some processing. ...<br>             if (allResponses()) {<br>               queryCallback.finalResult();<br>              } else {<br>                queryCallback.incrementalResult();<br>              }<br>            }<br>            @Override<br>            public onFailure(Error e) {<br>              // Do some error handling. ... <br>              if (allResponses()) {<br>                queryCallback.finalResult();<br>              }<br>            }<br>          });<br>     }<br>   }<br>     // Other methods. ... <br>} </pre>
<!-- /wp:preformatted -->

<!-- wp:paragraph -->
<p>I ran into this code because of an issue that we were seeing in production. </p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>Every so often the logs showed a really really long query that timed 
out, but it did manage to serve the response back to the user. Digging 
into it some more, I managed to narrow it down to this class. But beyond
 that, things were a mystery. Recall that in my last post I mentioned 
how there were no unit tests here, and the code actually needed 
refactoring to pull out the anonymous class. We pick up the story here 
after all that.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>Once I had all the unit tests put in, I discovered that the root cause for the bug is actually a race condition.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>The unit tests had ruled out sufficiently many code paths to lead me 
to a strong suspicion that it was a race condition in the allresponses()
 function causing two overlapping 'last' responses to both trigger the 
incrementalResult() callback function, and so the finalResult() method 
was never invoked. </p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>Once you have a candidate cause, reproducing and verifying it becomes
 pretty straightforward (not necessarily easy or simple, but 
straightforward), and the rest is just mundane software engineering. </p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>See, unit tests are more than a one trick pony! :)</p>
<!-- /wp:paragraph -->