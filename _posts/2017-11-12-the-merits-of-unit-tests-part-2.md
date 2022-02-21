---
id: 374
title: 'The merits of unit tests — Part 2'
date: '2017-11-12T19:04:46-05:00'
author: 'Srikanth Sastry'
layout: post
guid: 'http://srikanth.sastry.name/?p=374'
permalink: /the-merits-of-unit-tests-part-2/
categories:
    - Professional
tags:
    - 'software engineering'
    - 'software testing'
    - 'unit test'
---

<!-- wp:paragraph -->
<p>In the <a href="http://srikanth.sastry.name/merits-of-unit-tests-part-1/">previous post</a>,  we saw how unit tests can serve as a reliable source of documentation  for your code. There is a lot more that unit tests can do for you. In this post I'll talk about a fairly obvious, but often ignored, benefit  to unit testing: Refactoring.</p>
<!-- /wp:paragraph -->

<!-- wp:more -->
<!--more-->
<!-- /wp:more -->

<!-- wp:paragraph {"textColor":"very-dark-gray","backgroundColor":"pale-cyan-blue"} -->
<p class="has-text-color has-background has-very-dark-gray-color has-pale-cyan-blue-background-color">I posted this article on <a href="https://www.linkedin.com/pulse/merits-unit-tests-part-2-srikanth-sastry/">LinkedIn</a> and am reposting it here cuz’ this is the authoritative source for it :)</p>
<!-- /wp:paragraph -->

<!-- wp:heading {"level":3} -->
<h3>Refactoring</h3>
<!-- /wp:heading -->

<!-- wp:paragraph -->
<p>Refactoring is a less than pleasant, nevertheless, essential part of 
developing and maintaining high quality software. No matter how well 
designed your software is, over time a few things happen to it.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>1. The assumptions you made about the environment change, and that triggers unanticipated changes to your code.</p>
<!-- /wp:paragraph -->

<!-- wp:image {"id":375,"linkDestination":"custom"} -->
<figure class="wp-block-image"><a href="http://dilbert.com/strip/2011-05-16" target="_blank" rel="noreferrer noopener"><img src="http://srikanth.sastry.name/wp-content/uploads/2019/01/dt_c110516-1024x319.gif" alt="Boss: Did I remember to tell you before you finished the coding that the user's specifications changed? Dilbert: AAAIII-YIIIII-YIIII-YIII!!! Boss: So, no-ish? Dilbert: BAM! BAM! BAM! " class="wp-image-375"/></a></figure>
<!-- /wp:image -->

<!-- wp:paragraph -->
<p><em>You started with the assumption that every account will have a 
unique username, but with the introduction of shared family-accounts, 
this may not be true anymore.</em></p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>2. New/junior engineers make changes to the code that run antithetical to the original design.</p>
<!-- /wp:paragraph -->

<!-- wp:image {"id":376} -->
<figure class="wp-block-image"><img src="http://srikanth.sastry.name/wp-content/uploads/2019/01/0.jpg" alt="" class="wp-image-376"/></figure>
<!-- /wp:image -->

<!-- wp:paragraph -->
<p><em>While you were out on vacation, your colleague's intern made a 
less-than well thought out change to add an session expiry feature to 
your code with a bunch of if-checks that see if the session has not 
already expired. By the the time you returned from your vacation, this 
code has been in production for two weeks, and you have more important 
things to do.</em></p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>3. The software is co-opted for something that it was never intended for in the first place.</p>
<!-- /wp:paragraph -->

<!-- wp:image {"id":377,"linkDestination":"custom"} -->
<figure class="wp-block-image"><a href="http://www.gorillafabrication.com/modifications/16-repurposed-trucks-and-cars/" target="_blank" rel="noreferrer noopener"><img src="http://srikanth.sastry.name/wp-content/uploads/2019/01/0-1.jpg" alt="" class="wp-image-377"/></a></figure>
<!-- /wp:image -->

<!-- wp:paragraph -->
<p><em>That awesome geo-spatial indexing service that you wrote for 
indexing cities became so popular that it is now being used to index 
stores in malls across the country, and to accommodate that, the schema 
now includes fields such as 'store name', 'floor number', etc. which 
make no sense in your original use case; it has just been shoehorned 
here.</em></p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>Every time any of those things happen, you accrue some tech debt, and
 eventually the tech debt gets so high that it start impeding your 
ability to make future changes. This is the point at which you have to 
redesign your software to reflect the new world it is in.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>In my experience, one of the most delicate things about refactoring 
such code is that you often have to rewrite the software but keep all of
 its existing behavior intact. Any failure to do so will start 
triggering failures in the system-at-large. Having good unit tests can 
be an indispensable asset. If, throughout the evolution of your 
software, there has been a diligent effort to keep the unit tests up to 
date and with sufficient code/path coverage, the task of refactoring 
becomes a lot easier.</p>
<!-- /wp:paragraph -->

<!-- wp:pullquote {"className":"is-style-default"} -->
<figure class="wp-block-pullquote is-style-default"><blockquote><p>
  The rule of thumb is simply “As long as the unit tests pass, every iteration of your refactor is (most likely) correct.” 
</p></blockquote></figure>
<!-- /wp:pullquote -->

<!-- wp:image {"id":379,"align":"center","linkDestination":"custom"} -->
<div class="wp-block-image"><figure class="aligncenter"><a href="http://upload.wikimedia.org/wikipedia/commons/0/0b/TDD_Global_Lifecycle.png" target="_blank" rel="noreferrer noopener"><img src="http://srikanth.sastry.name/wp-content/uploads/2019/01/refactoringg-884x1024.png" alt="" class="wp-image-379"/></a></figure></div>
<!-- /wp:image -->

<!-- wp:paragraph -->
<p>Good unit tests can save you multiple days or even weeks of making 
incremental changes and testing them out in production in a gingerly 
fashion in ensure that nothing breaks.</p>
<!-- /wp:paragraph -->