---
id: 312
title: 'Scripts and their undo'
date: '2019-01-11T17:46:42-05:00'
author: 'Srikanth Sastry'
excerpt: 'TL;DR. Scripts are a great way to automate the mundane. But be sure you give yourself a way out --- an undo -- when running them.'
layout: post
guid: 'http://srikanth.sastry.name/?p=312'
permalink: /scripts-and-their-undo/
categories:
    - Professional
tags:
    - script
    - software
    - 'software engineering'
---

<!-- wp:cover {"url":"http://srikanth.sastry.name/wp-content/uploads/2019/01/bash-logo-672x372.png","id":313} -->
<div class="wp-block-cover has-background-dim"><p class="wp-block-cover-text"><strong>TL;DR.</strong> <em>Scripts are a great way to automate the mundane. But be sure you give yourself a way out --- an undo -- when running them.</em></p></div>
<!-- /wp:cover -->

<!-- wp:paragraph -->
<p>Some time ago, I had to carry out a long sequence of manual changes in the deployment of my ‘cloud’ service, and so like a good software engineer, I automated large chunks of these changes with shell scripts. Here I learned the importance of building and ‘undo’ in all your shell scripts that mutate the state of world.</p>
<!-- /wp:paragraph -->

<!-- wp:more {"customText":"Read more"} -->
<!--more Read more-->
<!-- /wp:more -->

<!-- wp:paragraph -->
<p> A bit of background first. I discovered that one of the services in a collection of co-located services was over-provisioned by a lot. But due to interdependence among services and second order effects, I wasn’t sure by how much. A quick way to do this was to shrink the size of this service while monitoring the resource utilization for the service. For multiple reasons, I had to go through a very specific sequence of replica turn downs, and this sequence was accounted for the automation as well.<br> After writing and testing the script, I unleashed it on the deployment, and things seem to be going well.<br> Midway through, an engineer from a partner team pinged me to say that they were having service incident, and they my changes was introduces a lot of noise in their monitoring dashboard making it difficult to debug their issue. So, they asked me to undo my changes, and resume it after they had fixed their issue.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>Well, as it turns out, I did not have an undo script, and worse, I hadn't even thought of an undo short of resetting the entire service (which was scheduled to happen at the end of the day anyway). So, I halted my existing script, and made some quick changes that I thought would effectively undo, and given how short I was on time, I just let it run.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>You can guess what happened. Instead of undoing the changes, a bug in the script caused to be more aggressive about shutting down replicas, and I now had a new service incident on my hands! :)</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>If only I had spent enough time figuring out the undo operation, and had a handy command that executed that, this could have been completely avoided. So, my advice to you is this. When writing and launching a script that mutates the state of the world, please ensure that the script logs (either to stdout, stderr, or a log file) the exact command that can be pasted into your shell prompt to undo all the mutations. You may not have to use it often (or at all(; but when you do, it will definitely be worth the effort.</p>
<!-- /wp:paragraph -->
