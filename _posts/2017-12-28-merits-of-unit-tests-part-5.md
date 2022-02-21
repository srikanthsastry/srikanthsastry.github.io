---
id: 392
title: 'Merits of unit tests &#8212; part 5'
date: '2017-12-28T16:25:49-05:00'
author: 'Srikanth Sastry'
layout: post
guid: 'http://srikanth.sastry.name/?p=392'
permalink: /merits-of-unit-tests-part-5/
categories:
    - Professional
tags:
    - 'software engineering'
    - 'software testing'
---

<!-- wp:paragraph {"backgroundColor":"pale-cyan-blue"} -->
<p class="has-background has-pale-cyan-blue-background-color">Cross posted on <a href="https://www.linkedin.com/pulse/merits-unit-tests-part-5-srikanth-sastry/">LinkedIn</a>.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>This is the fifth, and final, post in my series of notes on unit tests. So far, we've talked about how unit tests help us in <a rel="noreferrer noopener" aria-label="documenting our code (opens in a new tab)" href="http://srikanth.sastry.name/merits-of-unit-tests-part-1/" target="_blank">documenting our code</a>, <a rel="noreferrer noopener" aria-label="reliably refactor software (opens in a new tab)" href="http://srikanth.sastry.name/the-merits-of-unit-tests-part-2/" target="_blank">reliably refactor software</a>, <a rel="noreferrer noopener" aria-label="build better code (opens in a new tab)" href="http://srikanth.sastry.name/the-merits-of-unit-tests-part-3/" target="_blank">build better code</a>, and even <a href="http://srikanth.sastry.name/unit-tests-ftw-part-4/" target="_blank" rel="noreferrer noopener" aria-label="help debugging in prod (opens in a new tab)">help debugging in prod</a>.  In this post, we'll discuss how unit tests (more precisely, the act of  writing unit tests) help us improve the usability of our code.</p>
<!-- /wp:paragraph -->

<!-- wp:more -->
<!--more-->
<!-- /wp:more -->

<!-- wp:heading -->
<h2>Usability</h2>
<!-- /wp:heading -->

<!-- wp:paragraph -->
<p>It is fairly accurate to state that the simpler and more usable your 
API is, the less likely it is to be misunderstood, misused, and abused. 
Also, simpler API constrains your possible code paths making it more 
testable and less bug-prone. I claim that the very act of making unit 
tests will help you write more usable code/API. (Of course, this assumes
 an earnest effort in writing good quality unit tests, which can be a 
topic of discussion in its own right).</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>The reason for my claim is simple, by writing extensive unit tests 
that account for all your use cases, you effectively become your own 
first customer. This forces you you to wear your customer's hat and 
really probe the user experience of your API. In fact, it is not 
uncommon for me to iterate on my APIs multiple times simply because I am
 not happy with how difficult it is to set up and execute my unit tests.</p>
<!-- /wp:paragraph -->

<!-- wp:quote -->
<blockquote class="wp-block-quote"><p>
  by writing extensive unit tests that account for all your use cases, you effectively become your own first customer 
</p></blockquote>
<!-- /wp:quote -->

<!-- wp:paragraph -->
<p>Let's take a fictional example of a class that does the following: It
 retrieves either a URL, or the content of the URL for a given handle 
that could potentially need to be authenticated as a specific user, and 
it can do so periodically. Here is a first crack at the API and usage 
for it.</p>
<!-- /wp:paragraph -->

<!-- wp:preformatted -->
<pre class="wp-block-preformatted">class UrlRetriever {<br>   // Unauthenticated, one-time<br>   UrlRetriever(Handle handle);<br>   // Authenticated, one-time<br>   UrlRetriever(String user, Handle handle);<br>   // Authenticated, periodic<br>   UrlRetriever(String user, Handle handler, int periodInSeconds);<br>   // Unauthenticated, periodic<br>   UrlRetriever(Handle handler, int periodInSeconds);<br>   <br>   String getUrl();<br>   Blob getContents();<br>   void getContentsPeriodically(Callback cb);<br>   void getUrlPeriodically(Callback cb)<br>} </pre>
<!-- /wp:preformatted -->

<!-- wp:paragraph -->
<p>When you start writing unit tests for this, you start seeing issues 
with usability. For example, you have to consider all possible 
constructions of UrlRetriever with getUrl() or getContents() call. 
Worse, what happens if the UrlRetriever is constructed without a 
periodInSeconds argument, and someone invokes getContentsPeriodically() 
on it? Sure, it is nonsensical, but you still need a test case for it, 
right? Which means, the clients could potentially misuse the class in 
this fashion, in part because the usability of this API is poor. </p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>Making an honest attempt at writing unit tests can actually help you 
detect such usability issues! Consider the next iteration for the same 
use case, informed (or constrained) by the unit tests.</p>
<!-- /wp:paragraph -->

<!-- wp:preformatted -->
<pre class="wp-block-preformatted">class UrlRetriever {<br>   UrlRetriever(Handle handle);<br>   AuthenticatedUrlRetriever withAuth(String user);<br>   String getUrl();<br>   Blob getContents();<br>   void getPeriodically(ContentCallback cb, int periodInSeconds);<br>   void getPeriodically(UrlCallback cb, int periodInSeconds); <br>} <br>class AuthenticatedUrlRetriever inherits UrlRetriever {<br>   // Does not make sense to authenticate with another user.<br>   AuthenticatedUrlRetriever withAuth(String user) throws exception;<br>} </pre>
<!-- /wp:preformatted -->

<!-- wp:paragraph -->
<p>You will see that writing unit tests for it is much easier, and 
furthermore, there is less chance of misusing this API. Both of this is 
true because the API is more usable. The clients can use it in multiple,
 but limited/tractable. Here is how it ends up looking in the unit 
tests. </p>
<!-- /wp:paragraph -->

<!-- wp:preformatted -->
<pre class="wp-block-preformatted">// one-time unauthenticated <br>url = UrlRetriever(handle).getUrl();<br> // periodic unauthenticated (1)<br> // -- MyCallback inherits UrlCallback.<br>urlCallback = new MyCallback(); <br>UrlRetriever(handle).getPeriodically(urlCallback, 30);<br>  // periodic unauthenticated (2)<br> // -- MyCallback inherits ContentCallback. <br>contentCallback = new MyCallback(); UrlRetriever(handle).getPeriodically(contentCallback, 30);<br>  // Authenticated<br>foo = UrlRetriever(handle).withAuth(user);<br> //  -- one-time<br>blob = foo.getContents();<br> //  -- periodic <br>foo.getPeriodically(contentCallback, 60); </pre>
<!-- /wp:preformatted -->

<!-- wp:paragraph -->
<p>Much better eh? :)</p>
<!-- /wp:paragraph -->