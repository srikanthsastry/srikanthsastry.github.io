---
id: 461
title: 'When should you build for survival?'
date: '2019-08-21T14:23:48-04:00'
author: 'Srikanth Sastry'
layout: post
guid: 'https://srikanth.sastry.name/?p=461'
permalink: /when-should-you-build-for-survival/
categories:
    - Professional
tags:
    - 'software development process'
    - 'software engineering'
image: /wp-content/uploads/2019/08/Are-You-Succeeding-Blog-thegem-blog-default-1024x512.jpg
---

<!-- wp:image {"align":"center","id":463} -->
<!-- <div class="wp-block-image"><figure class="aligncenter"><img src="https://srikanth.sastry.name/wp-content/uploads/2019/08/Are-You-Succeeding-Blog-thegem-blog-default-1024x512.jpg" alt="" class="wp-image-463"/><!-- <figcaption>source: http://beaconbusinessmarketing.com/success-vs-survival/</figcaption> --> </figure></div> -->
<!-- /wp:image -->

<!-- wp:paragraph -->
Previously, I wrote about [building for survival vs. success]({% post_url 2019-08-15-are-you-building-for-survival-or-excellence %}) building for survival vs. success. Briefly, when building for survival, your only goal to get the product working for the specific usecase, and in contrast, when building for success, you are building to solve a bigger class of problems within the broader context of your solution space. In this post, I will talk about when you should be build for survival, and when for success.
<!-- /wp:paragraph -->

<!-- wp:more -->
<!--more-->
<!-- /wp:more -->

<!-- wp:heading -->
<h2>A Straw Man</h2>
<!-- /wp:heading -->

<!-- wp:image {"align":"center","id":464,"width":349,"height":262} -->
<div class="wp-block-image"><figure class="aligncenter is-resized"><img src="https://srikanth.sastry.name/wp-content/uploads/2019/08/Meet-You-Strawman.jpg" alt="" class="wp-image-464" width="349" height="262"/><!--<figcaption>source: https://prepareforchange.net/wp-content/uploads/2016/06/Meet-You-Strawman.jpg</figcaption>--></figure></div>
<!-- /wp:image -->

<!-- wp:paragraph -->
<p>On the face of it, it seems like an easy answer: "<em>build for survival, when survival is at stake; otherwise, build for success.</em>" But unfortunately, that answer hides a multitude of assumptions, and oversimplifies the real-world within which the software development process operates. So, let's first breakdown the assumptions, and then address the oversimplification.</p>
<!-- /wp:paragraph -->

<!-- wp:heading {"level":3} -->
<h3>The assumptions</h3>
<!-- /wp:heading -->

<!-- wp:paragraph -->
<p>The first assumption here is the notion that we have a common understanding of what it means to say that a project/product's "survival is at stake". And the second assumption is that building for survival in all such cases will actually help. </p>
<!-- /wp:paragraph -->

<!-- wp:heading {"level":4} -->
<h4>Is your survival at stake?</h4>
<!-- /wp:heading -->

<!-- wp:paragraph -->
<p> Let's examine the first assumption: <em>we can agree on what it means for survival to be at stake.</em> Sure, in the extreme cases, we can all agree on this notion (e.g., a startup has a runway of 6 months, and additional funding depends on delivering an alpha in 3 months), but moving past that, things become a lot more subjective. </p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>Consider a new project/product incubating within a well established company such as Facebook or Google. Is it's survival ever at stake? How about a project that involves building/dismantling infrastructure with a fixed, slightly aggressive, deadline; would it's survival be at stake? The answers to the above questions are not always obvious, and they can be different depending on who you ask. They can differ depending on where you are in the organizational hierarchy; it can even differ among developers within the team. </p>
<!-- /wp:paragraph -->

<!-- wp:heading {"level":4} -->
<h4>Ok, so your survival is at stake. So should you build for survival?</h4>
<!-- /wp:heading -->

<!-- wp:paragraph -->
<p>Now on to the second assumption: <em>when survival is at stake, building for survival is actually the right thing to do</em>. Again, there are some obvious cases where this is the right call. What about a case where the survival of your medical diagnostic software is at stake; would building for survival actually be the right thing (given that 'break things' is a corollary of 'move fast')?  How about when you realize that you were a little too optimistic about what the product could accomplish with the limited resources you have; is building for survival still the right thing (ask Microsoft about Windows Vista)?</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>The oversimplification made here is that we only ever have two choices: survival, or success. This is almost never the case. You can almost always negotiate. You can negotiate on deadlines, on scope, on resources, on expectations, and on outcomes. Without taking all of the above into account, the discussion of survival vs success is meaningless. </p>
<!-- /wp:paragraph -->

<!-- wp:heading -->
<h2>So, when should you build for survival vs success?</h2>
<!-- /wp:heading -->

<!-- wp:paragraph -->
<p>While you have to evaluate every situation independently and holistically to determine which approach is the right one to take, here are some rule-of-thumb symptoms that suggest that you should be building for survival.</p>
<!-- /wp:paragraph -->

<!-- wp:heading {"level":3} -->
<h3>You are resource constrained, and failure is an option</h3>
<!-- /wp:heading -->

<!-- wp:image {"align":"center","id":465,"width":234,"height":156} -->
<div class="wp-block-image"><figure class="aligncenter is-resized"><img src="https://srikanth.sastry.name/wp-content/uploads/2019/08/product-resource-graphic01.png" alt="" class="wp-image-465" width="234" height="156"/><!-- <figcaption>source: https://www.triskellsoftware.com/wp-content/uploads/2016/01/product-resource-graphic01.png</figcaption> --></figure></div>
<!-- /wp:image -->

<!-- wp:paragraph -->
<p>When you are resource constrained, then there is a good chance that you cannot afford the time/effort/resources that a principled approach to software development demands. Recall, that in such a case, I talked about renegotiating the original parameters and expectations. However, they are not always negotiable. (<em>E.g.</em>, you might have only a few months' of runway, and your investor might not be willing to fund you in case of milestone slippage.) In such cases, failure becomes a better option than renegotiation (almost vacuously). Here, building of survival makes sense.</p>
<!-- /wp:paragraph -->

<!-- wp:heading {"level":3} -->
<h3>Your environment is highly uncertain</h3>
<!-- /wp:heading -->

<!-- wp:image {"align":"center","id":466,"width":349,"height":349} -->
<div class="wp-block-image"><figure class="aligncenter is-resized"><img src="https://srikanth.sastry.name/wp-content/uploads/2019/08/Uncertainty-Reigns-Supreme-for-Fixed-Income-Investors-in-2015-e1505506674364.png" alt="" class="wp-image-466" width="349" height="349"/> <!-- <figcaption>source: https://blogs.cfainstitute.org/investor/2015/09/08/uncertainty-reigns-supreme-for-fixed-income-investors-in-2015/</figcaption> --> </figure></div>
<!-- /wp:image -->

<!-- wp:paragraph -->
<p>High uncertainty is often a good trigger to build for survival. High uncertainty often requires you to 'fail fast'. If you are working on experimental technology, or on nascent problem spaces, there really isn't much to grok without actually building something and test things out. In other cases, it might not be possible to know if you are solving the right problem; this happens often when your customers tend to "know it when they see it".</p>
<!-- /wp:paragraph -->

<!-- wp:heading {"level":3} -->
<h3>Your survival is more important than stakeholders' risks</h3>
<!-- /wp:heading -->

<!-- wp:image {"align":"center","id":467,"width":376,"height":349} -->
<div class="wp-block-image"><figure class="aligncenter is-resized"><img src="https://srikanth.sastry.name/wp-content/uploads/2019/08/stakeholders.png" alt="" class="wp-image-467" width="376" height="349"/> <!-- <figcaption>source: https://corporatefinanceinstitute.com/resources/knowledge/finance/stakeholder/</figcaption> --> </figure></div>
<!-- /wp:image -->

<!-- wp:paragraph -->
<p>This one is less obvious. It could well be the case that your survival is at stake, you are resource constrained, and there is no negotiating. However, there still are situations when you should not build for survival. One big situation is when the stakeholders' risks trump your survival.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>The most egregious example I can think of is in medical technology. If you software you are building is for (say) medical diagnosis, and a wrong diagnosis can mean the difference between life and death of a patient, then you should never, ever, ever build for survival. From here, you can extrapolate to all other situations where your stakeholders' risk outweighs yours.</p>
<!-- /wp:paragraph -->

<!-- wp:heading {"level":3} -->
<h3>You are solving a one-time problem</h3>
<!-- /wp:heading -->

<!-- wp:image {"align":"center","id":468} -->
<div class="wp-block-image"><figure class="aligncenter"><img src="https://srikanth.sastry.name/wp-content/uploads/2019/08/Throw-away-Prototyping-Model.jpg" alt="" class="wp-image-468"/> <!-- <figcaption>source: https://prototypeinfo.com/evolutionary-prototyping-and-throw-away-prototyping/</figcaption>  --> </figure></div>
<!-- /wp:image -->

<!-- wp:paragraph -->
<p>This one is tricky, because solutions to one-time problems have a nasty tendency of sticking around a lot longer than they should. However, in principle, if you are writing software that is going to be used just once, and then discarded, then you should consider building for survival. However, please ensure that that software will NOT persist past it's primary use. Incidentally, if your work involves building prototypes and proof-of-concept works, then you are almost definitely building for survival.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>There are multiple ways to enforce this: (1) do not put it into version control at all, (2) put the code in a new repo that is nuked on a timer, (3) prevent importing modules from this codebase to anywhere else, <em>etc</em>.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>Can you think of any other situations where building for survival is warranted? Let me know in the comments.</p>
<!-- /wp:paragraph -->