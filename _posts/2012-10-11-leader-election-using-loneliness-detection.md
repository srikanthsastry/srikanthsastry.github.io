---
id: 29
title: 'Leader Election Using Loneliness Detection'
date: '2012-10-11T19:23:04-04:00'
author: 'Srikanth Sastry'
layout: post
guid: 'http://sastry.hcoop.net/srikanthwp/?p=29'
permalink: /leader-election-using-loneliness-detection/
fplayout:
    - default
categories:
    - Research
---

My recent work titled "Leader Election Using Loneliness Detection" is accepted for presentation at the 25th International Symposium on DIStributed Computing (DISC) in Rome, and in the journal Distributed Computing. Briefly, the work focuses on the 'gap in the computational power' in single-hop wireless systems when the information about message loss in the system is varied.

<!--more-->

We assume that the cause of message loss in wireless networks is collision, which happens when multiple nodes in the system transmit concurrently. We consider two models --- weak collision detection (WCD) and strong collision detection (SCD) --- which differ only with respect to the information that they provide about message loss. Specifically, when message collision occurs, in WCD systems, all the nodes that are not transmitting (and therefore listening) receive information about the collision whereas the transmitting processes do not receive any such information, and in SCD systems, all the nodes (both transmitting and receiving nodes) receive information about the collision. Intuitively, it makes sense to argue that SCD systems are more `powerful' than WCD systems because SCD systems provide more information about message collision than WCD systems; however, that does not answer the question: How much more powerful are SCD systems than WCD systems; how can the 'gap' be characterized? Alternatively, we may ask: how do we quantify the amount of information that is provided to transmitting processes when they are notified of a message collision?

We showed that the 'gap' between SCD and WCD systems is captured by the answer to the question: Is there exactly one node in the system? In other words, if WCD systems were to be augmented with an oracle that provides the answer to the foregoing question, then such a system would be able to solve all the problems solvable in SCD systems with the same time and message complexity (modulo a constant factor). We call such an oracle a Loneliness Detector (or LD, for short). We showed that LD can be implemented in WCD systems in O(log u - log n) time deterministically (where u is an upper bound on the number of nodes in the system and n is the actual number of nodes in the system) and in O(1) time with high probability. We then used LD to compare the time complexity of solving leader election in SCD and WCD systems. We showed that in both SCD and WCD systems, leader election may be solved in O(log u) time deterministically and in O(loglog n + log(1/epsilon)) time probabilistically, where epsilon is the error probability. We also provided matching lower bounds for each of the upper bounds presented, thus demonstrating the efficiency of our algorithms.

<em><strong>Abstract:</strong></em>
<blockquote>We consider the problem of leader election (LE) in single-hop radio networks with synchronized time slots for transmitting and receiving messages. We assume that the actual number n of processes is unknown, while the size u of the ID space is known, but is possibly much larger. We consider two types of collision detection: strong (SCD), whereby all processes detect collisions, and weak (WCD), whereby only non-transmitting processes detect collisions. We introduce loneliness detection (LD) as a key subproblem for solving LE in WCD systems. LD informs all processes whether the system contains exactly one process or more than one. We show that LD captures the difference in power between SCD and WCD, by providing an implementation of SCD over WCD and LD. We present two algorithms that solve deterministic and probabilistic LD in WCD systems with time costs of O(log u/n ) and O(min(log u/n , log(1/epsilon)/n)), respectively, where epsilon is the error probability. We also provide matching lower bounds. We present two algorithms that solve deterministic and probabilistic LE in SCD systems with time costs of O(log u) and O(min(log u, log log n + log( 1/epsilon ))), respectively, where epsilon is the error probability. We provide matching lower bounds.</blockquote>
The full version of the paper may be <a href="http://hdl.handle.net/1721.1/66224">found here [link]</a>.