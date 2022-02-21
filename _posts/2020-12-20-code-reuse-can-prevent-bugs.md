---
id: 646
title: 'Code reuse can prevent bugs'
date: '2020-12-20T13:43:09-05:00'
author: 'Srikanth Sastry'
layout: post
guid: 'https://srikanth.sastry.name/?p=646'
permalink: /code-reuse-can-prevent-bugs/
image: /wp-content/uploads/2020/12/arrow-2756728_1280-740x430.png
categories:
    - Professional
tags:
    - 'software engineering'
---

<!-- wp:paragraph -->
<p>I am as surprised as you are at the title. The statement does seem like "Duh!", but much to my embarrassment, I have seen enough code in many code bases to need to reiterate this.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>The latest example was the following bug that I spotted. First some background. The caller to this function can choose any subset of a given set of 'modes' or 'features'. The caller represents this via a bit-mask. So 1 represents feature 1, 2 represents feature 2, 4 represents feature 3, 8 represents feature 4, and so on. So, if the caller requests with bit-mask 3, then it represents features 1 and 2, and bit-mask 10 represents features 2 and 4.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>The following piece of code is support to filter out requests depending on the requested set of 'modes/'features'.</p>
<!-- /wp:paragraph -->

<!-- wp:code -->
<pre class="wp-block-code"><code>if ((bitMask &amp; ModeEnum.FEATURE_FOO.getValue()) == 0) {
  // FEATURE_FOO has already taken care off the by some other module. So do nothing here.
  return null;
}

/* Some more code here */

if ((bitMask &amp; ModeEnum.FEATURE_BAR.getValue()) == 0) {
  // For now, we process the request only if caller explicitly specified FEATURE_BAR.
  return null;
}
/* more code to process the request with FEATURE_BAR. */</code></pre>
<!-- /wp:code -->

<!-- wp:paragraph -->
<p>The code above has a bug because the comment inside the first if-check does not match the if-check's logic. The intent was to skip processing the request if FEATURE_FOO is enabled. Instead, it does the exact opposite. </p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>The naive way to fix it would be to replace </p>
<!-- /wp:paragraph -->

<!-- wp:code -->
<pre id="block-9dae83e5-31d7-43ad-952e-2674f85d9963" class="wp-block-code"><code>if ((bitMask &amp; ModeEnum.FEATURE_FOO.getValue()) == 0) {</code></pre>
<!-- /wp:code -->

<!-- wp:paragraph -->
<p>with</p>
<!-- /wp:paragraph -->

<!-- wp:code -->
<pre id="block-9dae83e5-31d7-43ad-952e-2674f85d9963" class="wp-block-code"><code>if ((bitMask &amp; ModeEnum.FEATURE_FOO.getValue()) != 0) {</code></pre>
<!-- /wp:code -->

<!-- wp:paragraph -->
<p>However, this misses the more important point of why this bug occurred in the first place. The simple answer to that question is that this bug occurred because the author ignored the <a href="https://en.wikipedia.org/wiki/Code_reuse">principle of code reuse</a>. By putting that principle into practice, a cleaner way to write this code (and therefore fix this bug and prevent similar bugs in the future) is as follows.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>We first encapsulate the logic to detecting various modes via this function</p>
<!-- /wp:paragraph -->

<!-- wp:code -->
<pre class="wp-block-code"><code>boolean hasRequestedFeature(int bitMask, ModeEnum feature) {
  return (bitMask &amp; feature.getValue()) != 1;
}</code></pre>
<!-- /wp:code -->

<!-- wp:paragraph -->
<p>With that function in place, the new code looks as follows</p>
<!-- /wp:paragraph -->

<!-- wp:code -->
<pre class="wp-block-code"><code>if (!hasRequestedFeature(bitMask, ModeEnum.FEATURE_FOO)) {
  // FEATURE_FOO has already taken care off the by some other module. So do nothing here.
  return null;
}

/* Some more code here */

if (hasRequestedFeature(bitMask, ModeEnum.FEATURE_BAR)) {
  // For now, we process the request only if caller explicitly specified FEATURE_BAR.
  return null;
}
/* more code to process the request with FEATURE_BAR. */</code></pre>
<!-- /wp:code -->

<!-- wp:paragraph -->
<p>This make the code more readable, and as long as we reuse the <code>hasRequestedFeature()</code> function, such bitwise operation fragility will not reoccur in the code.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>Is this obvious? I think so. Was it necessary to belabor the point? Empirical evidence seems to scream "YES!".</p>
<!-- /wp:paragraph -->