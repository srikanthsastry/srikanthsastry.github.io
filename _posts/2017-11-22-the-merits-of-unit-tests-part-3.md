---
id: 385
title: 'The merits of unit tests — Part 3'
date: '2017-11-22T16:04:44-05:00'
author: 'Srikanth Sastry'
layout: post
guid: 'http://srikanth.sastry.name/?p=385'
permalink: /the-merits-of-unit-tests-part-3/
categories:
    - Professional
tags:
    - 'software engineering'
    - 'software testing'
---

<!-- wp:paragraph {"backgroundColor":"pale-cyan-blue"} -->
<p class="has-background has-pale-cyan-blue-background-color">Cross posted on <a href="https://www.linkedin.com/pulse/merits-unit-tests-part-3-srikanth-sastry/">LinkedIn</a>.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>Previously, I talked about how unit tests serve purposes other than verifying code functionality; I talked about <a rel="noreferrer noopener" aria-label=" (opens in a new tab)" href="http://srikanth.sastry.name/merits-of-unit-tests-part-1/" target="_blank">unit tests serving as defacto documentation</a>, and <a href="http://srikanth.sastry.name/the-merits-of-unit-tests-part-2/" target="_blank" rel="noreferrer noopener" aria-label=" (opens in a new tab)">unit tests helping you refactor without fear</a>. In this post, I'll talk about yet another benefit to unit tests: writing better software.</p>
<!-- /wp:paragraph -->

<!-- wp:more -->
<!--more-->
<!-- /wp:more -->

<!-- wp:heading -->
<h2>Better software design</h2>
<!-- /wp:heading -->

<!-- wp:paragraph -->
<p>I am not talking about writing bug-free software here. Sure, good 
unit tests help you discover/avoid large classes of bugs, but that's not
 the point. Unit tests also help you enforce good design patterns and 
modularity in your software.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>Unit tests help you with software design in two complementary ways. 
First, they help you establish optimal boundaries of modularity in terms
 of methods, and classes, and second, they help you understand your 
dependencies better and almost force you to use good dependency 
injection hygiene.</p>
<!-- /wp:paragraph -->

<!-- wp:heading {"level":3} -->
<h3>Modularity</h3>
<!-- /wp:heading -->

<!-- wp:image {"id":386} -->
<figure class="wp-block-image"><img src="http://srikanth.sastry.name/wp-content/uploads/2019/01/0-2.jpg" alt="" class="wp-image-386"/></figure>
<!-- /wp:image -->

<!-- wp:paragraph -->
<p>How do you know that your class or method does 'too much', or that it
 has undesirable side-effects? A pretty good way to discover it is to 
start writing unit tests for it. If you find yourself having to test for
 too many different types of inputs, then your methods are doing too 
much. If you find yourself having to test for too many orderings of 
operations, when your methods have too many side effects. It really is 
just as simple as that!</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>For instance, some time ago, I came across a piece of code that 
essentially took a large query, split it up into multiple subqueries, 
sent them off in parallel, collected their responses back, munged them 
and returned the munged response to the caller via a callback. The code 
looked something like this:</p>
<!-- /wp:paragraph -->

<!-- wp:preformatted -->
<pre class="wp-block-preformatted">public class QueryManager {<br>   void sendRequest(Query query, Callback queryCallback) {<br>     List&lt;Subquery> subqueries = splitQuery(query);<br>     for (Subquery subquery : subqueries) {<br>       sendQuery(subquery, new Subquery.Callback() {<br>           @Override<br>           public onSuccess(Response response) {<br>             // Do some processing. ...<br>             if (allResponses()) {<br>               queryCallback.finalResult();<br>              } else {<br>                queryCallback.incrementalResult();<br>              }<br>            }<br>            @Override<br>            public onFailure(Error e) {<br>              // Do some error handling. ... <br>              if (allResponses()) {<br>                queryCallback.finalResult();<br>              }<br>            }<br>          });<br>     }<br>   }<br>     // Other methods. ... <br>} </pre>
<!-- /wp:preformatted -->

<!-- wp:paragraph -->
<p>This code makes for an interesting case study on multiple fronts, and  I will come back to it in a later post. For now, it is sufficient to  state that I wanted to make changes to this code, but it was pretty  thorny because (you guessed it!) it has no unit tests.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>Naturally, the first step is to write unit tests for this class, and 
that was when I realized why there were no unit tests here. This class 
is incredibly tricky to unit test. Getting the subqueries to respond 
under various conditions and ordering resulted in a combinatorial 
explosion of test cases making the task intractable. This was very 
strong code smell.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>As you have probably figured out already, this was a classic case of a
 single class doing too much. The primary culprit was the anonymous 
class that implemented the Subquery.Callback interface. It should really
 have been its own class with its own unit tests.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>After I pulled out that anonymous class into its own class, it became
 a lot easier to unit test both the Subquery.Callback and the 
QueryManager individually, and with that, the code became much more 
modular, easier to read, and much easier to maintain.</p>
<!-- /wp:paragraph -->

<!-- wp:heading {"level":3} -->
<h3>Dependency</h3>
<!-- /wp:heading -->

<!-- wp:image {"id":387} -->
<figure class="wp-block-image"><img src="http://srikanth.sastry.name/wp-content/uploads/2019/01/0-3.jpg" alt="" class="wp-image-387"/></figure>
<!-- /wp:image -->

<!-- wp:paragraph -->
<p>If your code does not do a decent job of<a href="https://en.wikipedia.org/wiki/Dependency_injection" target="_blank" rel="noreferrer noopener"> injecting its dependencies</a>
 from outside, you are gonna have a bad time! Having good unit tests 
will actually keep you from getting into this pitfall pretty 
effectively. Consider the following contrived example. You have a piece 
of code that writes to an external service, and your code throttles the 
rate of writes because going over your approved rate/quota can be pretty
 expensive. So, your code could look something like this:</p>
<!-- /wp:paragraph -->

<!-- wp:preformatted -->
<pre class="wp-block-preformatted">class RateLimiter {<br>   void writeToExternalService(const vector&lt;Entries>&amp; stuff) {<br>     auto service = new ExternalService(ConnectionParameters foo);<br>     for (auto entry : stuff) {<br>       waitUntilQuotaAvailable();<br>       service.write(entry);<br>     }<br>   }<br>} </pre>
<!-- /wp:preformatted -->

<!-- wp:paragraph -->
<p>Remember how I said that going over the rate/quota is bad? How do you
 verify that it will not happen? Well, you could set up an elaborate 
testbed that has an ExternalService simulator, and you can run your code
 through all sorts of inputs and verify that the simulator says that the
 rate limiting is work. But that's expensive, and if you choose to go 
with a different external service, then well, good luck with that!</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>Instead, you could try to unit test it. But how? You need to have 
access to the ExternalService to do that, which we have already 
established is expensive! Well, this is where unit testing it will force
 you into healthy dependency injection. For this contrived example, you 
can inject the dependency as follows.</p>
<!-- /wp:paragraph -->

<!-- wp:preformatted -->
<pre class="wp-block-preformatted">class RateLimiter {<br>   void writeToExternalService(<br>       const vector&lt;Entries>&amp; stuff, <br>       ExternalService service) {<br>     for (auto entry : stuff) {<br>       waitUntilQuotaAvailable();<br>       service.write(entry);<br>     }<br>   }<br>} </pre>
<!-- /wp:preformatted -->

<!-- wp:paragraph -->
<p>Your unit tests could do this:</p>
<!-- /wp:paragraph -->

<!-- wp:preformatted -->
<pre class="wp-block-preformatted">TEST(AwesomeTestCase, testWrite) {<br>   vector&lt;Entries> stuff = generateLotsOfStuff();<br>   RateLimits limit;  // Set your limits here.<br>   ExternalService svc = MockExternalService(limit);<br>   RateLimiter rateLimiter = new RateLimiter(limit); <br>   rateLimiter.writeToExternalService(stuff, svc);<br>   ASSERT_TRUE(svc.writesWithinLimits()); <br>} </pre>
<!-- /wp:preformatted -->

<!-- wp:paragraph -->
<p>And you can put your implementation through the wringer without breaking a sweat.</p>
<!-- /wp:paragraph -->