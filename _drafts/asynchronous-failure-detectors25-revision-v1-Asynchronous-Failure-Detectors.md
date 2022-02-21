---
id: 184
title: 'Asynchronous Failure Detectors'
date: '2013-04-18T19:37:21-04:00'
author: 'Srikanth Sastry'
layout: revision
guid: 'http://srikanth.sastry.name/25-revision-v1/'
permalink: '/?p=184'
---

My latest work on a modeling framework for a special variant of failure detectors is accepted at the 31st Annual ACM SIGACT-SIGOPS Symposium on Principles of Distributed Computing. <a title="Asynchronous Failure Detectors" href="/documents/research/AFD-podc2012.pdf">A preprint of the submission is available [here]</a>.

<strong>Update:</strong> <a title="Asynchronous Failure Detectors: Tech Report" href="http://hdl.handle.net/1721.1/76716" target="_blank">The full version is available as a tech report [here].</a>

<!--more-->

<em><strong>Abstract: </strong></em>Failure detectors — oracles that provide information about process crashes — are an important abstraction for crash tolerance in distributed systems. Although current failure-detector theory provides great generality and expressiveness, it also poses significant challenges in developing a robust hierarchy of failure detectors. We address some of these challenges by proposing a variant of failure detectors called asynchronous failure detectors and an associated modeling framework. Unlike the traditional failure-detector framework, our framework eschews real time completely. We show that asynchronous failure detectors are sufficiently expressive to include several popular failure detectors. Additionally, we show that asynchronous failure detectors satisfy many desirable properties: they are self-implementable, guarantee that stronger asynchronous failure detectors solve more problems, and ensure that their outputs encode no information other than process crashes. We introduce the notion of a failure detector being representative of a problem to capture the idea that some problems encode the same information about process crashes as their weakest failure detectors do. We show that a large class of problems, called finite problems, do not have representative failure detectors.