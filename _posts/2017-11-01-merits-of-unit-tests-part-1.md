---
id: 368
title: 'My code is bugfree! Why should I unit test?'
date: '2017-11-01T16:33:01-04:00'
author: 'Srikanth Sastry'
layout: post
guid: 'http://srikanth.sastry.name/?p=368'
permalink: /merits-of-unit-tests-part-1/
categories:
    - Professional
tags:
    - documentation
    - 'software engineering'
    - 'software testing'
    - 'unit test'
---

<!-- wp:paragraph -->
<p>There are multiple reasons to write unit tests. Verification is only one of them, and the least interesting. This is part 1 of a five part series on why you should write unit tests (apart from the obvious): Documentation!</p>
<!-- /wp:paragraph -->

<!-- wp:more -->
<!--more-->
<!-- /wp:more -->

<!-- wp:paragraph {"textColor":"very-dark-gray","backgroundColor":"pale-cyan-blue"} -->
<p class="has-text-color has-background has-very-dark-gray-color has-pale-cyan-blue-background-color">I posted this article on <a href="https://www.linkedin.com/pulse/my-code-bugfree-why-should-i-unit-tests-srikanth-sastry/">LinkedIn</a> and am reposting it here cuz' this is the authoritative source for it :)</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>We have all heard this 
repeatedly: “You have to have unit tests. Unit tests are how you find 
issues in your code and fix them before they hit the trunk.” Ok, so that
 argument sounded a little weak. Here is a much stronger version of the 
same argument.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p><em>You have to write unit tests because unit tests are a </em><a href="https://l.facebook.com/l.php?u=https%3A%2F%2Fen.wikipedia.org%2Fwiki%2FScientific_method&amp;h=ATNU99lLyWx55l8BBlgT8AIDwdfUHBUjrSOtbRUQbP42vH_k7pVzTOXviC2N0Ze44RbFVdkFCWKSsvNoCovWLh8gaOuHG9eEAsu4GKloIbcHKwPbQdRFAdhFdNCPSDHmdBjCaYcBKEXAxhC-i735nThHQPOCEuD39p2iuu6K8bulWw" target="_blank" rel="noreferrer noopener"><em>scientific</em></a><em>
 mechanism to verify that your implementation satisfies the 
specification (that is, you code does what you say it does). To 
elaborate, your claim of what your code does is a </em><a href="https://l.facebook.com/l.php?u=https%3A%2F%2Fen.wikipedia.org%2Fwiki%2FFalsifiability&amp;h=ATPEcKK4eeXOCNWcc8BCYwdplxHx1zCDAuE74Z4TapMJOVwgCqukHCEuH21QaLSEGYvUA1ouxan-XttxS4n2cgnjJBzJY5CWV-quFVTNq18bpJSTq2l3NZyjuw2yd1-O3mWdupeKygwazafitDpYrhAWIt8nLBIlTkuxKG0nTn0oSA" target="_blank" rel="noreferrer noopener"><em>falsifiable</em></a><em>
 hypothesis in that it is possible to conceive of an observation that 
could negate your claim. Unit tests are the experiments that can be 
performed to test your hypothesis. If all your unit tests pass, then it 
is increasingly likely that your claim is correct. (Note that we cannot 
claim to have proved correctness; that is an impossible task in the 
general case).</em></p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>This still an unsatisfying argument at best. What if I were a perfect
 developer who writes perfect code, and everyone around me agrees that I
 write perfect code. Do I still need to write unit tests? Or what about 
the cases where visual inspection of the code makes correctness obvious.
 Do I still need to spend precious time writing unit tests?</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>While verification is an important reason to have unit tests, IMHO, 
it is also the least interesting. There are many more reasons to be 
rigorous about unit tests.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>Let's start with my favorite.</p>
<!-- /wp:paragraph -->

<!-- wp:heading {"level":3} -->
<h3>Documentation</h3>
<!-- /wp:heading -->

<!-- wp:image {"id":370,"align":"center","linkDestination":"custom"} -->
<div class="wp-block-image"><figure class="aligncenter"><a href="http://www.quickmeme.com/meme/3t1i87" target="_blank" rel="noreferrer noopener"><img src="http://srikanth.sastry.name/wp-content/uploads/2019/01/a0a8c4ab0bec170a748228f0982da6795e6af515a8048b11c2b4c9e794d7b4f9.jpg" alt="" class="wp-image-370"/></a></figure></div>
<!-- /wp:image -->

<!-- wp:paragraph -->
<p>Unit tests makes the best documentation for your code. We were all 
hired as software engineers because we can write good software. That 
means a lot of us are not very good at technical writing, and for many 
of us, English isn't our native tongue. This creates barriers for us in 
communicating what our software does so that others can use it well.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>We could write wiki/docs describing what our code does, but that has three major issues.</p>
<!-- /wp:paragraph -->

<!-- wp:list {"ordered":true} -->
<ol><li>The documentation doesn't live anywhere near the code, and so discoverability is difficult</li><li>English is not the primary language for a lot of us, and technical 
writing is not our strong suit, and so the quality of the writing can be
 suspect</li><li>As the code evolves, the documentation becomes obsolete. The only thing worse than no documentation is wrong documentation!</li></ol>
<!-- /wp:list -->

<!-- wp:paragraph -->
<p>We could write comments in the code itself. So discoverability is not
 a problem. However, the other two issues still remain. (Raise your hand
 if you have seen comments that are out of sync with the code that it is
 supposed to clarify.)</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>What we could really use it a mechanism that leverages our strength 
(writing software) to create documentation, and automation to ensure 
that documentation is never obsolete. Unit tests turn out to be the 
perfect tool for this!</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>Think of each unit test as a how-do example of how to use your code. 
So, if anyone wants to use the code that your wrote, all they need to do
 is look at your unit tests, the job is done!</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p><strong>EXAMPLE</strong></p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>A great example is the <a href="https://github.com/facebook/folly" target="_blank" rel="noreferrer noopener">folly</a> library. Let's take folly Futures for instance. The primary header file <a href="https://github.com/facebook/folly/blob/master/folly/futures/Future.h" target="_blank" rel="noreferrer noopener">Future.h</a> tells you the API, but figuring out how to use it is not straightforward from there. However, go over to the unit tests at <a href="https://l.facebook.com/l.php?u=https%3A%2F%2Fgithub.com%2Ffacebook%2Ffolly%2Fblob%2Fmaster%2Ffolly%2Ffutures%2Ftest%2FFutureTest.cpp&amp;h=ATNiTV-rdTNS1lEjxiC29ETboF-w94bQpQhXUxFugGI897McF_YyCo-jvJX_kzLzDyVSjokYlYY9wbhcS4dJsTQlrgkVGXW8Fw7BBKx537cGoHDELiJcF4gBHMQq2CzZXV158ToPWPV0j0Xbt4WNDiLY13bFtRv7cWPEgKLJZsHe0Q" target="_blank" rel="noreferrer noopener">FutureTest.cpp</a>,
 and you will come away knowing how to use Futures for your use case in a
 matter of minutes. For each minute spent by a folly developer to write 
these unit tests, it has saved thousands of developers countless hours.</p>
<!-- /wp:paragraph -->

<!-- wp:heading {"level":3} -->
<h3>But wait, there more!</h3>
<!-- /wp:heading -->

<!-- wp:paragraph -->
<p>There are many other things that work better when you have unit tests.</p>
<!-- /wp:paragraph -->

<!-- wp:list -->
<ul><li><a rel="noreferrer noopener" aria-label="Refactoring (opens in a new tab)" href="http://srikanth.sastry.name/the-merits-of-unit-tests-part-2/" target="_blank">Refactoring</a>.</li><li><a rel="noreferrer noopener" href="https://www.linkedin.com/pulse/merits-unit-tests-part-3-srikanth-sastry/" target="_blank">Better code design.</a></li><li><a rel="noreferrer noopener" aria-label=" (opens in a new tab)" href="http://srikanth.sastry.name/unit-tests-ftw-part-4/" target="_blank">Debugging prod issues.</a></li><li><a href="http://srikanth.sastry.name/merits-of-unit-tests-part-5/">API usability</a>.</li></ul>
<!-- /wp:list -->