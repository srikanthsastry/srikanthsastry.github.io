---
title: "The Empty Grant"
date: 2026-05-05
layout: post
categories:
    - Professional
tags:
    - ai
    - open-source
    - copyright
    - licensing
    - software-engineering
permalink: /the-empty-grant/
excerpt: >
    Every open source license is a conditional grant of copyright. AI-generated code has no copyright.
    The grant is empty. Two forces, the Gravity Well and the Replicator, are collapsing the legal
    infrastructure that made open source enforceable for four decades.
---

Joost de Valk [put it plainly](https://joost.blog/open-source-agency/): the cost argument for open source is dying. AI reintroduces real marginal costs to software production. GPU-seconds, electricity, cooling water. Frontier model providers run 40-46% gross margins, not the 77% SaaS enjoyed for decades. The thirty-year economic anomaly that let open source compete on price is closing. The replacement argument, de Valk says, must be about agency: the capacity to run, inspect, modify, and migrate software without permission.

He is right that agency must replace cost. But agency depends on infrastructure. And the infrastructure that makes open source legally enforceable is collapsing from two directions at once.

## The Structural Dependency

Every open source license is a conditional grant of copyright. MIT, Apache 2.0, GPL, AGPL: the author holds copyright, the license grants permissions under conditions. Violate the conditions and the grant terminates. Copyright is the enforcement mechanism. It is the only enforcement mechanism. Remove it and the entire structure collapses. Not just copyleft. All of it.

## The Gravity Well

AI-generated code is not copyrightable. The D.C. Circuit held in [*Thaler v. Perlmutter*](https://law.justia.com/cases/federal/appellate-courts/cadc/23-5233/23-5233-2025-03-18.html) that the Copyright Act requires a human author. The Supreme Court [declined to hear the appeal](https://www.bakerdonelson.com/supreme-court-denies-certiorari-in-thaler-v-perlmutter-ai-cannot-be-an-author-under-the-copyright-act) in March 2026. The U.S. Copyright Office [confirmed](https://Copyright.gov/newsnet/2025/1060.html) that providing prompts to an AI does not constitute sufficient human authorship.

Code without copyright cannot be licensed. A license is a grant of rights the author holds. No copyright: no rights to grant. The MIT license requires a copyright notice "in all copies." When there is no copyright, that sentence is unenforceable. The GPL requires derivative works to carry the same license. When the original work has no copyright, there is nothing for the obligation to attach to.

The code falls into a legal category that did not exist before: not public domain (no affirmative dedication), not proprietary (no copyright to assert), not open source (no license that can attach). Unowned and ungovernable.

This creates a structural pull toward closed source. Trade secret is the only form of IP protection that does not depend on copyright. It depends on keeping code secret. A company that generates code with AI and wants any control over it has one option: do not release it. The rational calculus: release the code and get no enforceable license protections; keep it closed and get trade secret protection. No company will choose "unprotectable" over "protected" when the choice is binary.

The boundary between "AI-assisted" and "AI-generated" makes things worse. The Copyright Office says AI assistance does not bar copyrightability but has not defined where assistance ends and generation begins. For anyone building on that code (investors, acquirers, downstream users doing compliance), ambiguity is liability. [Fenwick & West](https://www.fenwick.com/insights/publications/when-code-writes-itself-rethinking-ip-strategy-in-the-age-of-ai): copyright protection is no longer an automatic byproduct of software development. The [American Bar Association agrees](https://www.americanbar.org/groups/intellectual_property_law/resources/landslide/2025-spring/future-open-source-age-ai/): the current licensing framework does not adequately address the complexities that AI introduces.

## The Replicator

The Gravity Well drains the moat from inside: new code cannot carry enforceable license terms. The Replicator drains it from outside: existing licensed code can be functionally cloned without triggering those terms.

Clean-room reimplementation is old law. [*Sega v. Accolade*](https://en.wikipedia.org/wiki/Sega_Enterprises_Ltd._v._Accolade,_Inc.) (1992) established that reverse engineering for interoperability is fair use. What kept it in check was economics. Nobody rewrites Redis to avoid the AGPL when the rewrite takes months of expert labor. The copyleft moat was never purely legal. It was economic: compliance was cheaper than reimplementation.

AI collapsed that cost. In April 2026, [MALUS.sh](https://www.404media.co/this-ai-tool-rips-off-open-source-software-without-violating-copyright/) launched as "clean room as a service." Feed it any open source project. It produces a functionally equivalent clone stripped of all license obligations. No attribution. No copyleft. A real LLC with paying customers. The catalyst: Dan Blanchard's AI-assisted rewrite of the Python `chardet` library using Claude Code. A project that would have taken a team months, completed in days.

The [legal question is genuinely open](https://www.marks-clerk.com/insights/latest-insights/102mp7s-can-ai-legally-clone-open-source-unpacking-clean-room-as-a-service/). Traditional clean-room doctrine required that the reimplementing team had no access to the original source. With AI, the model was trained on the original source. Whether the model's transformation of training data into weights constitutes a sufficient "clean room wall" is novel law. No court has ruled.

But enforcement at scale is impossible regardless. You cannot sue every MALUS user. You cannot detect every AI-generated clone. The economic moat is gone whether or not the legal question resolves favorably.

## The Ownership Split

Two forces. One drains from inside. The other from outside. Together they form a pincer that hollows out the structural foundation open source has relied on for four decades. But the pincer hits different projects in different ways.

**Community-owned projects** (Zig, SQLite, most volunteer-maintained libraries) depend on the legal fence around the commons. Contributors donate code under a license. The license ensures the code stays open, attributions preserved, derivatives compliant. The pincer removes the fence. What remains is the **Naked Commons**: legally unprotected territory where contributors invest effort with no mechanism to ensure that investment is respected. The grant of rights still exists on paper. There is nothing behind it.

**Corporation-sponsored projects** (React, Kubernetes, most Apache and CNCF projects) face a different failure mode. These projects were open-sourced as strategy: attract contributors, build ecosystem adoption, establish de facto standards, commoditize adjacent layers of the stack. The strategic logic depended on a moat. Competitors could use the code, but the sponsoring company controlled the roadmap and the ecosystem.

The Replicator collapses that moat. Clone the project for the cost of tokens. Rebrand it. Ship it. The strategic rationale for openness evaporates. This is the **Phantom Sponsor**: the corporation that open-sourced code for competitive advantage discovers that advantage no longer exists. The sponsorship was never charity. When the strategy fails, the sponsor withdraws. The project discovers what it always was: a corporate project wearing community clothes.

Many projects that appear community-owned are sustained by corporate contributors. When the corporate calculus shifts (and the pincer is shifting it), those contributors disappear. The Phantom Sponsor is not just a corporate-project problem. It is a hidden dependency in projects that do not know they have one.

## The Second Liberation

Stefano Maffulli, former Executive Director of the Open Source Initiative, [sees this differently](https://allthingsopen.org/articles/ai-final-frontier-copyleft-second-liberation). AI is not destroying open source. It is fulfilling the original promise of the free software movement. The GPL was a legal hack for source code access. The real barrier was always the cost of exercising the freedom to modify: the scarce technical knowledge required to fork and reshape software. AI collapses that cost. A non-programmer can now reshape software to their needs. "If the GNU GPL was the legal hack for freedom," Maffulli writes, "AI is the technical one."

He is not wrong. AI does collapse the cost of exercising the freedom to fork. Individual users gain real agency over software. That is a genuine liberation.

But Maffulli is answering only the licensing question: what happens to the framework? It becomes unnecessary, he says. Fine. The question he does not address is what happens to the communities. The people who build and maintain the commons. The institutions that sustain long-lived projects over decades. The social contract that turns individual contributions into shared infrastructure. Liberation and sustainability are independent concerns. You can have one without the other.

That question is the subject of Part 2.
