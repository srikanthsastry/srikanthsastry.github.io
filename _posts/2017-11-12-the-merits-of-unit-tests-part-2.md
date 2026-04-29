---
id: 374
title: 'The merits of unit tests — Part 2'
date: '2017-11-12T19:04:46-05:00'
author: 'Srikanth Sastry'
layout: post
permalink: /the-merits-of-unit-tests-part-2/
categories:
    - Professional
tags:
    - 'software engineering'
    - 'software testing'
    - 'unit test'
---

In the [previous post](http://srikanth.sastry.name/merits-of-unit-tests-part-1/),  we saw how unit tests can serve as a reliable source of documentation  for your code. There is a lot more that unit tests can do for you. In this post I'll talk about a fairly obvious, but often ignored, benefit  to unit testing: Refactoring.

I posted this article on [LinkedIn](https://www.linkedin.com/pulse/merits-unit-tests-part-2-srikanth-sastry/) and am reposting it here cuz’ this is the authoritative source for it :)

### Refactoring

Refactoring is a less than pleasant, nevertheless, essential part of
developing and maintaining high quality software. No matter how well
designed your software is, over time a few things happen to it.

1. The assumptions you made about the environment change, and that triggers unanticipated changes to your code.

![Boss: Did I remember to tell you before you finished the coding that the user's specifications changed? Dilbert: AAAIII-YIIIII-YIIII-YIII!!! Boss: So, no-ish? Dilbert: BAM! BAM! BAM!](/assets/images/2019/01/dt_c110516-1024x319.gif)

*You started with the assumption that every account will have a
unique username, but with the introduction of shared family-accounts,
this may not be true anymore.*

2. New/junior engineers make changes to the code that run antithetical to the original design.

![](/assets/images/2019/01/0.jpg)

*While you were out on vacation, your colleague's intern made a
less-than well thought out change to add an session expiry feature to
your code with a bunch of if-checks that see if the session has not
already expired. By the the time you returned from your vacation, this
code has been in production for two weeks, and you have more important
things to do.*

3. The software is co-opted for something that it was never intended for in the first place.

![](/assets/images/2019/01/0-1.jpg)

*That awesome geo-spatial indexing service that you wrote for
indexing cities became so popular that it is now being used to index
stores in malls across the country, and to accommodate that, the schema
now includes fields such as 'store name', 'floor number', etc. which
make no sense in your original use case; it has just been shoehorned
here.*

Every time any of those things happen, you accrue some tech debt, and
 eventually the tech debt gets so high that it start impeding your
ability to make future changes. This is the point at which you have to
redesign your software to reflect the new world it is in.

In my experience, one of the most delicate things about [refactoring](/garden/tests-as-refactoring-safety-net/)
such code is that you often have to rewrite the software but keep all of
 its existing behavior intact. Any failure to do so will start
triggering failures in the system-at-large. Having good unit tests can
be an indispensable asset. If, throughout the evolution of your
software, there has been a diligent effort to keep the unit tests up to
date and with sufficient code/path coverage, the task of refactoring
becomes a lot easier.

> The rule of thumb is simply “As long as the unit tests pass, every iteration of your refactor is (most likely) correct.”

![](http://upload.wikimedia.org/wikipedia/commons/0/0b/TDD_Global_Lifecycle.png)

Good unit tests can save you multiple days or even weeks of making
incremental changes and testing them out in production in a gingerly
fashion in ensure that nothing breaks.
