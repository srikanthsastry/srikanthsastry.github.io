---
id: 94
title: 'Wait-Free Stabilizing Dining Using Regular Registers'
date: '2013-01-18T18:28:45-05:00'
author: 'Srikanth Sastry'
layout: post
guid: 'http://sastry.hcoop.net/srikanthwp/?p=94'
permalink: /wait-free-stabilizing-dining-using-regular-registers/
fplayout:
    - default
categories:
    - Research
---

This paper was presented at OPODIS 2012.

<em><strong>Abstract:</strong></em> Dining philosophers is a scheduling paradigm that determines when processes in a distributed system should execute certain sections of their code so that processes do not execute `conflicting' code sections concurrently, for some application-dependent notion of a `conflict'. Designing a stabilizing dining algorithm for shared-memory systems subject to process crashes presents an interesting challenge: classic stabilization relies on all processes continuing to execute actions forever, an assumption which is violated when crash failures are considered. We present a dining algorithm that is both wait-free (tolerates any number of crashes) and is pseudo-stabilizing. Our algorithm works in an asynchronous system in which processes communicate via shared regular registers and have access to the eventually perfect failure detector $\Diamond P$. Furthermore, with a stronger failure detector, the solution becomes wait-free and self-stabilizing. To our knowledge, this is the first such algorithm. Prior results show that $\Diamond P$ is necessary for wait-freedom.