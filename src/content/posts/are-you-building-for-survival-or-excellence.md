---
title: 'Are you building for Survival or Excellence?'
published: '2019-08-15T15:53:45-04:00'
tags:
  - 'software development process'
  - 'software engineering'
abbrlink: 'are-you-building-for-survival-or-excellence'
lang: ''
---

In my experience, the approach to building a software artifact often falls into one of two types: *[building for survival](/garden/survival-vs-excellence-modes/)*, or *building for success*.

When building for survival, your only goal to get the product working for the specific usecase(s) that will save your skin. In contrast, when building for success, you are building to solve more than just the immediate problem; you are building to set up building blocks that is incidentally used to solve the immediate problem, but can also be adapted to solve a larger class of problems within the same context.

This post is not about when to choose what approach. Instead, it is about what each of the two approaches look like, and what purposes they serve. [A subsequent post will talk about when I think each approach is appropriate.](https://srikanth.sastry.name/when-should-you-build-for-survival/)

In theory, specific circumstances should determine which of these two approaches ought to be used. Unfortunately, all too often, the developer's temperament determines the approach, and this IMHO is a mistake. I have seen consequences of such mistakes last through multiple years and impact the morale of multiple teams and engineers.

## Building for survival

![Source: https://www.flickr.com/photos/bandrews/6028945055](/assets/images/2019/08/6028945055_2271b47a5b_m.jpg)

Building for survival often translates to 'being fast', taking shortcuts, and solving for the immediate use case. However, remember that when you do this, your software incurs a debt that will have to be paid eventually. Every incremental functional change you make on top of it incurs interest on the existing debt. Refusal to address it makes it incredibly difficult for your software to evolve and improve. This has a direct impact in your team’s morale. Ask any team that is left supporting ‘legacy’ code, or has some ‘black box’, ‘sacred cow’ modules that no understands, but is business critical.

### What does building for survival look like?

How do you know you are now in the regime of building for survival? There are many clues to look for. I'll list three.

- Typically, when building for survival, your deadlines are sacred. Think about everything that you or your company has had to do to meet GDPR deadlines. The odds are that all of that was done in the mode of *building for survival*.
- The second clue is that you deem it more important that some specific usecase work end-to-end, than that things are done the 'right' way (the discussion of what is a 'right' way is a topic for a whole other discussion). You see this often in early stage startups where they have an alpha customer who has promised to your product/service for some specific purpose, and your next round of funding is contingent upon demonstrating the utility of your product/service with that (isolated) context.
- The third, and perhaps the strongest, clue is that to (the collective) you, the end product is more important than the software development process. If your engineering culture is to 'get things done' by 'hook or crook', then you are most definitely building for survival.

### What does building for survival get you?

You survive, period. It gets you to where you want to be, and within a reasonable amount of time, with potentially steep discounting of the future. There really isn't much beyond that to show for.

### What it doesn't give you

It is important to realize the trade-off you are making when building for survival, and not be under illusions.

- For starts, do not mistake hitting your milestones under this approach to *success*. Sure, you may have succeeded in getting where you want to be, but that's not the end of the story.
- Presumably, the software you just delivered is not going to be abandoned imminently. So, what you need is a path forward, and that is exactly what this approach will not provide. Building for survival does not necessarily tell you how and where to go next. It shines no light on the landscape of possibilities that could have been unlocked.
- It doesn't tell you what else can your artifact be used for, or it fits into the larger ecosystem. In the pursuit of 'moving fast', the odds are they you have built in so many assumptions into your code that even cognitively extricating the underlying technological innovation from the business logic and the business logic from the use cases becomes challenging.

## Building for Success

![source: https://medium.com/deliberate-data-science/deliberate-data-science-intro-eac1b1a06568](/assets/images/2019/08/1ijN1lAVtTBPmh2hCwDWozw.png)

Building for success is a much more deliberate process that includes grokking the true context of the problem you are solving, and being critical of everything you choose to build. But it is important to be sure that you actually have such a luxury; otherwise, your software will likely become part of the vast graveyard of failed projects, products, and companies.

### What does building for success look like?

There are lots of ways building for success is different from building for survival.

- You deliberate before execution. You ask questions such as:
    - What is the problem we are solving?
    - Are we solving the right problem?
    - Is our proposal the right way to solve the problem?
- You deconstruct the problem to understand the larger context and nature of the sub-problems you are solving. You tease out the incidental nature of how these sub-problems combine versus the essential nature of the overall problem to be solved.
- Your execution is heavily informed by the aforementioned analysis. You apply the deconstruction and analysis to each sub-problem recursively until the actual act of writing the code becomes a rote exercise. The 'magic' and 'innovation' in your execution is really in how you compose such 'simple pieces of code' to solve your non-trivial problem across layers of abstractions (which are translated directly from your deconstructions).
- The code paths within your subsystems and modules are constrained to the supported use cases, but that is the result of intentional plumbing across the data flow. Addition of new use cases and flows is often a matter of easily understandable and incremental changes.
- Your control flow mimics your data flow within the system. (Unless there is a very good reason for it not to be the case.)

### What does building for success give you

Despite it not being the 'fast' way to build software. There is a lot of be said for Building for Success.

- The deliberation process before you build should result in a decent understanding of the context within which you are solving your problem. This often means, your team and the software is now in a much better position to solve more problems faster. Effectively you have expanded your 'pie'.
- Almost always, problems do not occur/manifest in isolation. They are part of a larger landscape of issues, utilities, and benefits. Deconstructing the problem through this lens will help you build a solution that is more likely to have reusable and sustainable components and modules that will lower the incremental effort associated with the evolution of your systems and their adaptation to solve proximate and associated problem.
- A well thought out design allows you to shard your development across multiple developers. This will help in three ways:
    1. You can 'move fast' with concurrent execution.
    2. Each developer can work on multiple workstreams, and is less likely to be completely stuck.
    3. Your software's [bus factor](https://en.wikipedia.org/wiki/Bus_factor) is much improved with more engineers on the code.
- You can pivot better and faster because a lot of what you wrote is reusable and reconfigurable. You can [migrate from one upstream dependency to another](https://srikanth.sastry.name/object-composition-for-service-migration/) much more smoothly. A good composition-based design allows you to make disruptive changes without actually disrupting :)

### What it doesn't give you

You will not have a quick start. You will be a little slower starting from square one. It will take time to start putting together code that actually does something real and concrete.

You are vulnerable to analysis paralysis. The bar for action is much higher when building for success. It takes a certain type of decisiveness, and ability to [disagree and commit](https://en.wikipedia.org/wiki/Disagree_and_commit), to be able to flourish under this approach.
