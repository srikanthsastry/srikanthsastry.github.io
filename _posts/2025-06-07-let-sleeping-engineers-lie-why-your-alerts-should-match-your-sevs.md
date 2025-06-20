---
layout: post
title: "Let Sleeping Engineers Lie: Why Your Alerts Should Match Your SEVs"
date: 2025-06-07
categories:
  - Professional
tags:
  - alerts
  - monitoring
  - SEV
author: Srikanth Sastry
permalink: /sync-your-alerts-to-your-sev-criteria/
image: /images/sleepy-engineer-cursing-laptop.png
...
<!-- ![](/images/sleepy-engineer-cursing-laptop.png) -->
At work, I had a customer team that aspired to be *“customer first.”* To them, that meant fixing issues *before* they became SEVs. That was all and good, except that the way they went about it was to fire alerts well *before* their SLOs were close to being breached. Of course, I knew nothing about it until I was the receiving end of their 'aspiration'.


It’s 4 AM, and I am in deep sleep. Suddenly, my phone, overriding all silencing setting starts ringing like there is no tomorrow. Naturally, I was being paged. I wake up bleary eyed, acknowledge the page, and join the team channel. Helpfully, the customer team oncall has message for me: **“Your service has a latency spike. Please look into it.”**

I drag myself to a laptop, check the graphs, and yes — there *was* a p99 latency spike, it lasted about half hour, and is already waning. Our SLOs were fine; our latency SLOs at these latency levels don't breach for another 30 minutes. I double-checked *their* SEV criteria, and they are also still green! So why the 4 AM fire drill?

Turns out, they’d set up their alerts to go off when their p99 latency went above the normal limits for 30 minutes, but their SLO wouldn't be breached until the elevated p99 persisted for 60 minutes. A twitcy alert if you ask me!

Their on-call had no idea what to do with the alert, saw my service mentioned, and did the classic move:  
> *“When in doubt, escalate!”*

So now *I’m* awake, trying to make sense of a 30-minute p99 latency increase that is fixing itself. I asked: 

> **“Where's the SEV'?**

I imagine the scene something like this.
![](/images/where-sev-where-impact.jpg)

Silence. Five minutes later, "Here is the SEV number..." The SEV was created two minutes ago. Facepalm!

Here’s what actually happened:  
- The latency spike lasted about 30 minutes.  
- The system auto-healed.  
- The affected service was user-facing, but this was deep in the off-hours.  
- Total estimated user impact: somewhere between *“negligible”* and *“none.”*

We could’ve all just slept through it and looked at it with fresh eyes in the morning. Instead, two engineers got pulled into zombie mode to stare at graphs that improved all by themselves. It was like debugging a ghost.

### Moral of the story:
If your alert is going to wake someone up at 4 AM, it better be for something that *actually* matters. If there's no SEV, no SLO breach, and no clear user impact — maybe let sleeping engineers lie.