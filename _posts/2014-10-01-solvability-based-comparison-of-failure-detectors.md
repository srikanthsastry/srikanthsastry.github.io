---
id: 120
title: 'Solvability-based comparison of failure detectors'
date: '2014-10-01T19:38:42-04:00'
author: 'Srikanth Sastry'
layout: post
permalink: /solvability-based-comparison-of-failure-detectors/
categories:
    - Professional
tags:
    - research
---

New paper in NCA 2014, with Josef Widder.

**Abstract:** Failure detectors are oracles that have been introduced to provide processes in asynchronous systems with information about faults. This information can then be used to solve problems otherwise unsolvable in asynchronous systems. A natural question is on the "minimum amount of information" a failure detector has to provide for a given problem. This question is classically addressed using a relation that states that a failure detector D is stronger (that is, provides "more, or better, information") than a failure detector D' if D can be used to implement D'. It has recently been shown that this classic implementability relation has some drawbacks. To overcome this, different relations have been defined, one of which states that a failure detector D is stronger than D' if D can solve all the time-free problems solvable by D'. In this paper we compare the implementability-based hierarchy of failure detectors to the hierarchy based on solvability. This is done by introducing a new proof technique for establishing the solvability relation. We apply this technique to known failure detectors from the literature and demonstrate significant differences between the hierarchies.

A preprint is available on ArXiv; [click here to access it](http://arxiv.org/abs/1407.3286).
