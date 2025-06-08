---
layout: post
title: "Let Sleeping Engineers Lie: Why Your Alerts Should Match Your SEVs"
date: 2025-06-07
categories:
  - professional
tags:
  - alerts
  - monitoring
  - SEV
author: Srikanth Sastry
permalink: /sync-your-alerts-to-your-sev-criteria/
...
![](/images/sleepy-engineer-cursing-laptop.png)
At work, I had a customer team that was all-in on being *“customer first.”* To them, that meant fixing issues *before* they became SEVs. Admirable! Except their plan was to fire alerts well *before* their SLOs were even close to being breached.

You can probably guess where this is going.

It’s 4 AM. I’m in REM sleep, dreaming of a world where on-call rotations don’t exist, when my phone buzzes. I’m being paged. A message follows:  
**“Your service has a latency spike. Please look into it.”**

No *“hi,”* no context — just pure panic vibes.

I drag myself to a laptop, check the graphs, and yes — there *was* a latency spike. But it had already resolved itself, and our SLOs were fine. I double-checked *their* SEV criteria. Still green. So why the 4 AM fire drill?

Turns out, they’d set up their alerts to go off at the *slightest* hint of trouble. Basically, their alerts were the technical equivalent of a chihuahua: loud, jumpy, and guaranteed to wake the whole neighborhood.

Their on-call had no idea what to do with the alert, saw my service mentioned, and did the classic move:  
> *“When in doubt, escalate!”*

So now *I’m* awake, trying to make sense of a 15-minute latency blip that fixed itself. I asked:  
**“Is this a SEV? Have we breached any SLOs? What’s the user impact?”**  
Cue awkward silence.

Here’s what actually happened:  
- The latency spike lasted about 30 minutes.  
- The system auto-healed.  
- The affected service was user-facing, but this was deep in the off-hours.  
- Total estimated user impact: somewhere between *“negligible”* and *“none.”*

We could’ve all just slept through it and looked at it with fresh eyes in the morning. Instead, two engineers got pulled into zombie mode to stare at graphs that improved all by themselves. It was like debugging a ghost.

### Moral of the story:
If your alert is going to wake someone up at 4 AM, it better be for something that *actually* matters. If there's no SEV, no SLO breach, and no clear user impact — maybe let sleeping engineers lie.