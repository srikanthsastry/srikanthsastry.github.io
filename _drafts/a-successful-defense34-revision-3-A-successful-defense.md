---
id: 104
title: 'A successful defense'
date: '2013-04-16T19:26:33-04:00'
author: 'Srikanth Sastry'
layout: revision
guid: 'http://sastry.hcoop.net/srikanthwp/?p=104'
permalink: '/?p=104'
---

I successfully defended my dissertation titled "A Prescription For Partial Synchrony" on January 21st, 2011. The dissertation was approved and accepted by the Thesis Office on February 2nd, 2011.

<strong><em>Abstract:</em></strong>

Algorithms in message-passing distributed systems often require <em>partial synchrony</em> to tolerate crash failures. Informally, partial synchrony refers to systems where timing bounds on communication and computation may exist, but the knowledge of such bounds is limited. Traditionally, the foundation for the theory of partial synchrony has been <em>real time</em>: a time base measured by counting events external to the system, like the vibrations of Cesium atoms or piezoelectric crystals.

Unfortunately, algorithms that are correct relative to many real-time based models of partial synchrony may not behave correctly in empirical distributed systems. For example, a set of popular theoretical models, which we call M*, assume (eventual) upper bounds on message delay and relative process speeds, regardless of message size and absolute process speeds. Empirical systems with bounded channel capacity and bandwidth cannot realize such assumptions either natively, or through algorithmic constructions. Consequently, empirical deployment of the many M*-based algorithms risks anomalous behavior.

As a result, we argue that real time is the wrong basis for such a theory. Instead, the appropriate foundation for partial synchrony is {\em fairness}: a time base measured by counting events internal to the system, like the steps executed by the processes. By way of example, we redefine M* models with fairness-based bounds and provide algorithmic techniques to implement fairness-based M* models on a significant subset of the empirical systems. The proposed techniques use <em>failure detectors</em> --- system services that provide hints about process crashes --- as intermediaries that preserve the fairness constraints native to empirical systems. In effect, algorithms that are correct in M* models are now proved correct in such empirical systems as well.

Demonstrating our results requires solving three open problems. (1) We propose the first unified mathematical framework based on Timed I/O Automata to specify empirical systems, partially synchronous systems, and algorithms that execute within the aforementioned systems. (2) We show that crash tolerance capabilities of popular distributed systems can be denominated exclusively through fairness constraints. (3) We specify exemplar system models that identify the set of weakest system models to implement popular failure detectors.

I thank my advisors Scott Pike and Jennifer Welch for all their help, support, and guidance.

A copy of my dissertation (in PDF format) can be accessed <a title="Srikanth Sastry's Dissertation titled &quot;A Prescription For Partial Synchrony&quot;" href="documents/research/srikanthSastryDissertation.pdf">here</a>.