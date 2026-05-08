---
title: "AI vs. Open Source, Part 1: The Empty Grant"
date: 2026-05-07
layout: post
categories:
    - Professional
tags:
    - ai
    - open source
    - copyright
    - licensing
    - software engineering
permalink: /ai-vs-open-source-the-empty-grant/
excerpt: >
    AI is dismantling the legal scaffolding that gives open source its freedom and its enforcement.
    Every open source license is a conditional grant of copyright. AI-generated code is not
    copyrightable. The grant is empty.
---

The last decade has seen a slew of changes to the open source licenses of various software: [MongoDB](https://www.mongodb.com/legal/licensing/server-side-public-license/faq) moved from AGPL to SSPL in 2018, [CockroachDB](https://changelog.com/news/why-were-relicensing-cockroachdb-EOaR) went from Apache 2.0 to BSL in 2019 (then relicensed [again](https://github.com/cockroachdb/cockroach/commit/c0274df57a9f8d0086577bcf74c81110db2cea22) in 2024), [Elasticsearch](https://www.elastic.co/blog/why-license-change-aws) followed in 2021, [HashiCorp](https://www.hashicorp.com/en/blog/hashicorp-adopts-business-source-license) switched Terraform and Vault to BSL in 2023, [Sentry](https://blog.sentry.io/introducing-the-functional-source-license-freedom-without-free-riding/) created an entirely new license (FSL) that same year, and [Redis](https://redis.io/blog/redis-adopts-dual-source-available-licensing/) went source-available in 2024. Most of these changes were triggered by cloud vendors offering managed services of these open source software, undercutting the business model of the primary sponsors of those very same software. With LLMs and AI coding agents rising in popularity, those very same open source software are facing new challenges from multiple dimensions.

Right as the Open Source community seems to have figured out its response to the cloud vendor threat, it is finding itself besieged by Generative AI. AI is dismantling the legal scaffolding that gives Open Source its freedom and its enforcement, while simultaneously hollowing out the community that sustains it. This post will focus on the former, and a later post on the latter. 

## Thou shalt share, by law!

Every open source license is a [conditional grant of copyright](/garden/copyright-sole-enforcement-mechanism/). The author holds the copyright, and the license grants permission to use the work only if certain conditions (e.g., derived work must also have the same license) are satisfied. This is the only enforcement mechanism that sustains open source through the chain of derived works. Without it the entire structure collapses.

## AI generated code? No copyright for you!

AI-generated code is not copyrightable. The D.C. Circuit held in [*Thaler v. Perlmutter*](https://law.justia.com/cases/federal/appellate-courts/cadc/23-5233/23-5233-2025-03-18.html) that the Copyright Act requires a human author. The Supreme Court [declined to hear the appeal](https://www.bakerdonelson.com/supreme-court-denies-certiorari-in-thaler-v-perlmutter-ai-cannot-be-an-author-under-the-copyright-act) in March 2026. The U.S. Copyright Office [confirmed](https://Copyright.gov/newsnet/2025/1060.html) that providing prompts to an AI does not constitute sufficient human authorship.

The copyright status of "AI-assisted" code is still a [legal gray area](/garden/ai-assisted-boundary-undefined/). While code written with "AI assistance" is copyrightable, when code crosses from AI-generated to merely AI-assisted remains undefined. Is it sufficient to change a comment in AI-generated code to make it AI-assisted? 

The upshot is that copyright protection is no longer an automatic byproduct of software development ([Fenwick & West](https://www.fenwick.com/insights/publications/when-code-writes-itself-rethinking-ip-strategy-in-the-age-of-ai)). The current licensing framework does not adequately address the complexities that AI introduces ([American Bar Association agrees](https://www.americanbar.org/groups/intellectual_property_law/resources/landslide/2025-spring/future-open-source-age-ai/)).

Code without copyright cannot be licensed. The requirement to share source when making modifications with AI generation becomes unenforceable. Such code falls into a legal void: not public domain (no affirmative dedication), not proprietary (no copyright to assert), not open source (no license that can attach). The license text still sits in the repository. It is an [empty grant](/garden/empty-grant/).

## To free, or not to free

Consider any corporation that writes and maintains code under an open source license. If AI-generated code enters that repository, the license grant over those contributions is void. The codebase becomes unauditable. Some files are copyrighted and licensed, others legally unowned, and yet others become legally contestable "AI-assisted" code.

Every team using Copilot or Claude Code produces ambiguously authored output, and no one chooses "slower but cleanly copyrighted" under quarterly pressure. So the corporation faces a [forced choice](/garden/ai-forces-velocity-or-openness/): ban AI-generated contributions and accept the velocity penalty, or embrace them and close the source. MongoDB, Elastic, HashiCorp, Redis already showed that when the legal basis for openness stops serving the business, the business closes the code. AI-generated code is a larger threat than cloud vendors ever were. Cloud vendors merely underpriced them. AI dissolves the legal mechanism that made their licenses mean anything.

## Why reciprocate when you can replicate?

The legal void around AI-generated code is not the only assault on Open Source. There is a second vector, and that comes from AI's ability to clone functionality with new source code.

Clean-room reimplementation has precedent. [*Sega v. Accolade*](https://en.wikipedia.org/wiki/Sega_Enterprises_Ltd._v._Accolade,_Inc.) established that reverse engineering for interoperability is fair use. And yet, we did not see any widespread reimplementation of open source software into closed source counterparts. The economics of it simply did not make sense. Nobody rewrites Redis to avoid the AGPL when the rewrite takes months of expert labor. [Compliance was cheaper than reimplementation](/garden/ai-collapses-reimplementation-moat/). Until now.

With AI, the cost of generating code has gone down to near zero. Dan Blanchard did an AI-assisted rewrite of the Python `chardet` library using Claude Code. A project that would have taken a team months was completed in days. Inspired by that success, in April 2026, [MALUS.sh](https://www.404media.co/this-ai-tool-rips-off-open-source-software-without-violating-copyright/) launched as "clean room as a service." Feed it any open source project. It produces a functionally equivalent clone stripped of all license obligations. No attribution. No copyleft.

Granted, that is still [legally fraught](https://www.marks-clerk.com/insights/latest-insights/102mp7s-can-ai-legally-clone-open-source-unpacking-clean-room-as-a-service/) because the AI model was trained on open source software, and traditional clean-room doctrine required that the reimplementing team had no access to the original source. Whether the model's transformation of training data into weights constitutes a sufficient "clean room wall" is novel law. No court has ruled.

Regardless, enforcement at scale is near impossible. You cannot sue every MALUS user. You cannot detect every AI-generated clone. The economic bulwark of expensive code writing is gone irrespective of the legal outcome.

## Rebuilding, or double tap?

The responses are already forming.

Joost de Valk (CEO of Yoast) [argues](https://joost.blog/open-source-agency/) that Open Source was successful because the cost of building software was high and the cost of distributing or serving it was low. Now AI is inverting that calculus. Cost of creating software is near zero, whereas the cost of serving it is going up (thanks to data center demand and the RAMpocalypse). The relevance of Open Source can no longer be cost. It must be agency: the capacity to run, inspect, modify, and migrate software without permission. 

Stefano Maffulli (former Executive Director of the Open Source Initiative) [says AI already provides that ability](https://allthingsopen.org/articles/ai-final-frontier-copyleft-second-liberation). The GPL was a legal hack for source code access. The real barrier was always the know-how to exercise the freedom to modify. AI has shattered that barrier. A non-programmer can now reshape software to their needs. Copyleft is obsolete.

Both are answering the right question: what replaces the old foundations? Neither answer is wrong. But both presuppose robust communities that build and maintain the commons: the people, the institutions, the social contract that turns individual contributions into shared infrastructure.

AI is coming for those communities too, and that attack is equally dangerous. The question of what happens to them is the subject of Part 2.
