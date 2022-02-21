---
id: 185
title: 'Failure Detectors Encapsulate Fairness'
date: '2013-04-18T19:36:58-04:00'
author: 'Srikanth Sastry'
layout: revision
guid: 'http://srikanth.sastry.name/27-revision-v1/'
permalink: '/?p=185'
---

The full version of my OPODIS 2010 paper "Failure Detectors Encapsulate Fairness" (<a href="documents/research/opodis2010.pdf" target="_blank">preprint</a>) has been accepted for publication with the journal Distributed Computing. You can find a <a href="/documents/research/journal/FD_encapsulate_fairness_preprint.pdf" target="_blank">preprint of the paper here [pdf]</a>.

<!--more-->

<em><strong>Abstract: </strong></em>Failure detectors have long been viewed as abstractions for the synchronism present in distributed system models. However, investigations into the exact amount of synchronism encapsulated by a given failure detector have met with limited success. The reason for this is that traditionally, models of partial synchrony are specified with respect to real time, but failure detectors do not encapsulate real time. Instead, we argue that failure detectors encapsulate the fairness in computation and communication. Fairness is a measure of the number of steps executed by one process relative either to the number of steps taken by another process or relative to the duration for which a message is in transit. We argue that failure detectors are substitutable for the fairness properties (rather than real-time properties) of partially synchronous systems. We propose four fairness-based models of partial synchrony and demonstrate that they are, in fact, the ‘weakest system models’ to implement the canonical failure detectors from the Chandra-Toueg hierarchy. We also propose a set of fairness-based models which encapsulate the $Gc$ parametric failure detectors which eventually and permanently suspect crashed processes, and eventually and permanently trust some fixed set of c correct processes.