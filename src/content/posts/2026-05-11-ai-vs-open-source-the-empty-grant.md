---
title: "AI vs. Open Source, Part 1: The Empty Grant"
published: 2026-05-11
tags:
  - 'ai'
  - 'open source'
  - 'copyright'
  - 'licensing'
  - 'software engineering'
abbrlink: 'ai-vs-open-source-the-empty-grant'
image: /assets/images/ai-vs-open-source-empty-grant-cover.jpg
lang: ''
excerpt: >
  AI is dismantling the legal scaffolding that gives open source its freedom and its enforcement.
  Every open source license is a conditional grant of copyright. AI-generated code is not
  copyrightable. The grant is empty.
categories:
  - Professional
series: 'Generative AI vs. Open Source'
series_order: 1

---

The step function increase in AI's ability to generate code is looming over open source. What frontier models can do today is a warning shot, already enough to dissolve the legal scaffolding that makes open source enforceable. Historically, companies with flagship open-source software have relied on relicensing as a weapon to protect their competitive advantage. [MongoDB](https://www.mongodb.com/legal/licensing/server-side-public-license/faq) moved from AGPL to SSPL in 2018, [CockroachDB](https://changelog.com/news/why-were-relicensing-cockroachdb-EOaR) went from Apache 2.0 to BSL in 2019 to a [custom CockroachDB license](https://github.com/cockroachdb/cockroach/commit/c0274df57a9f8d0086577bcf74c81110db2cea22) in 2024, [Elasticsearch](https://www.elastic.co/blog/why-license-change-aws) followed in 2021, [HashiCorp](https://www.hashicorp.com/en/blog/hashicorp-adopts-business-source-license) switched Terraform and Vault to BSL in 2023, [Sentry](https://blog.sentry.io/introducing-the-functional-source-license-freedom-without-free-riding/) created an entirely new license (FSL) that same year, and [Redis](https://redis.io/blog/redis-adopts-dual-source-available-licensing/) went source-available in 2024, mostly in response to cloud vendors offering their code as managed services. That weapon is now obsolete as AI threatens to make licenses completely irrelevant.

## AI generated code? No copyright for you!

Every open source license is a [conditional grant of copyright](/garden/copyright-sole-enforcement-mechanism/). The author holds the copyright, and the license grants permission to use the work only if certain conditions (e.g., attribution, source disclosure, or reciprocal licensing) are satisfied. This is the only enforcement mechanism that sustains open source through the chain of derived works. Without it the entire structure collapses.

AI-generated code is not copyrightable. The D.C. Circuit held in [*Thaler v. Perlmutter*](https://law.justia.com/cases/federal/appellate-courts/cadc/23-5233/23-5233-2025-03-18.html) that the Copyright Act requires a human author. The U.S. Copyright Office [confirmed](https://Copyright.gov/newsnet/2025/1060.html) that providing prompts to an AI does not constitute sufficient human authorship. This is U.S. law; other jurisdictions differ, but the enforcement gap is universal. The copyright status of "AI-assisted" code is still a [legal gray area](/garden/ai-assisted-boundary-undefined/). While code written with "AI assistance" is copyrightable, the line between AI-generated and merely AI-assisted remains undefined. Is it sufficient to change a comment in AI-generated code to make it AI-assisted? No court has drawn that line.

AI-generated code is already at the gate. Open source maintainers are [drowning in "vibe coded" pull requests](https://www.opensourceforu.com/2026/02/github-weighs-pull-request-kill-switch-as-ai-slop-floods-open-source/): AI-generated submissions with minimal human oversight. [Gentoo](https://itsfoss.com/gentoo-linux-bans-ai-code/) has banned AI-generated code contributions outright. [NetBSD](https://www.netbsd.org/developers/commit-guidelines.html) classifies them as tainted code requiring core developer approval. The Linux kernel [allows them but mandates disclosure and full human accountability](https://github.com/torvalds/linux/blob/master/Documentation/process/coding-assistants.rst). Quality is the basis for rejection today. That filter has a shelf life. As the models improve, the quality will improve. The ethical case for rejecting machine-generated contributions becomes harder to make when the code is indistinguishable from human work.

Code without copyright cannot be licensed. The requirement to share source becomes unenforceable for modifications that have no copyright. Such code falls into a legal void: not public domain (no affirmative dedication), not proprietary (no copyright to assert), not open source (no license that can attach). The license text still sits in the repository. It is an [empty grant](/garden/empty-grant/).

## To free, or not to free

Consider any corporation that writes and maintains code under an open source license. If AI-generated code enters that repository, the license grant over those contributions is void. The codebase becomes unauditable. Some files are copyrighted and licensed, others legally unowned, and yet others become legally contestable "AI-assisted" code.

Every team using Copilot or Claude Code produces ambiguously authored output. The corporation is strongly incentivized to close the source rather than maintain an open codebase with no legal protection. The relicensing wave already demonstrated this pattern: when the legal basis for openness stops serving the business, the business closes the code. AI-generated code is a larger threat than cloud vendors ever were. Cloud vendors merely underpriced them. AI dissolves the legal mechanism that made their licenses mean anything.

## Why reciprocate when you can replicate?

Even if all the lawyers in the world agreed on the copyright question, a second problem remains: AI's ability to clone functionality with new source code.

Clean-room reimplementation has precedent. [*Sega v. Accolade*](https://law.justia.com/cases/federal/appellate-courts/ca9/92-15655/92-15655-1992-10-20.html) established that reverse engineering for interoperability is fair use. Yet there was no widespread reimplementation of open source software into closed source counterparts. The economics did not make sense. Rewriting a mature project from scratch took months of expert labor, regardless of what license it carried. [Compliance was cheaper than reimplementation](/garden/ai-collapses-reimplementation-moat/). Until now.

With AI, the cost of generating code has gone down to near zero. [Dan Blanchard rewrote](https://dan-blanchard.github.io/blog/chardet-rewrite-controversy/) the Python `chardet` library with Claude Code in order to sidestep [LGPL](https://heathermeeker.com/2026/04/09/the-chardet-controversy-open-source-and-the-ai-clean-room/). A project that would have taken a team months was completed in days. `chardet` is a proof of concept, not the end state. Software is modular, and that modularity compounds: as individual components are cloned, they become building blocks for cloning progressively larger and more complex systems. This is not a today problem. It is a next-year problem. [MALUS.sh](https://www.404media.co/this-ai-tool-rips-off-open-source-software-without-violating-copyright/) took the concept further, launching as a satirical "clean room as a service." Feed it any open source project. It produces a functionally equivalent clone stripped of all license obligations. No attribution. No copyleft. The satire landed because the tool works.

Granted, that is still [legally fraught](https://www.marks-clerk.com/insights/latest-insights/102mp7s-can-ai-legally-clone-open-source-unpacking-clean-room-as-a-service/) because the AI model was trained on open source software, and traditional clean-room doctrine required that the reimplementing team had no access to the original source. Whether the model's transformation of training data into weights constitutes a sufficient "clean room wall" is novel law. No court has ruled.

Regardless, enforcement at scale is near impossible. You cannot pursue every clone. You cannot detect every AI-generated clone. The economic bulwark of expensive code writing is gone irrespective of the legal outcome. And the cost will only continue to drop. What frontier models clone imperfectly today, the next generation will clone competently. The question is whether actions will follow incentives.

## What remains

Open source has survived every prior threat by adapting its licensing regime. Tivoization got GPLv3. Cloud free-riding got SSPL and BSL. Importantly, the legal machinery worked, because copyright was relevant and valuable. AI is different. The machinery itself is failing. The grant is empty and the moat is collapsing. The onslaught of automated discovery and generation is incentivizing institutions to close their source code.

That would be survivable if the community that built open source could regroup and adapt as it always has. Part 2 examines why that is no longer a safe assumption.
