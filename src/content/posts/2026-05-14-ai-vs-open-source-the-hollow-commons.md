---
title: "AI vs. Open Source, Part 2: The Hollow Commons"
published: 2026-05-14
tags:
  - 'ai'
  - 'open source'
  - 'community'
  - 'software engineering'
abbrlink: 'ai-vs-open-source-the-hollow-commons'
lang: ''
excerpt: >
  Even if open source finds new legal foundations, the communities that would build and maintain
  them are under assault. AI breaks the iterated game that sustains contributor communities,
  and the commons is hollowing out from within.
categories:
  - Professional
series: 'Generative AI vs. Open Source'
series_order: 2
image: /assets/images/ai-vs-open-source-hollow-commons-cover.jpg
---

A [previous post](/ai-vs-open-source-the-empty-grant/) discussed how AI threatens the legal basis and enforcement of open source. Briefly, copyright makes licenses enforceable, and the cost of reimplementation made compliance rational. But AI-generated code is not copyrightable, and AI has made reimplementation cheap.

Not everyone is convinced this is undercutting open source. The threat may be real, but open source is not out of options.

Joost de Valk [argues](https://joost.blog/open-source-agency/) that open source relevance must shift from cost to agency: the capacity to run, inspect, modify, and migrate software without permission. The cost of creating software is near zero. The cost of serving it is going up (thanks to data center demand and the [RAMpocalypse](https://en.wikipedia.org/wiki/2024%E2%80%93present_global_memory_supply_shortage)). Agency, not cost, is the new value proposition.

Stefano Maffulli [says AI already provides that ability](https://allthingsopen.org/articles/ai-final-frontier-copyleft-second-liberation). The GPL was a legal hack for source code access. The real barrier was always the know-how to exercise the freedom to modify. AI has shattered that barrier. A non-programmer can now reshape software to their needs. Copyleft is obsolete.

Both responses presuppose that the communities which build and maintain the commons will survive long enough to exercise that agency.

## You gotta know when to hold 'em, and know when to fold 'em

Loris Cro, VP of Community at the Zig Software Foundation, observed that treating open source projects as mere code repositories misses the point. New contributors may offer up a rough first PR, but with support, they become trusted committers who enrich the community. Not all new contributors last. The maintainers are making a bet on each first PR. The Zig compiler toolchain was built by contributors who grew through such an iterated game. Cro calls this "[contributor poker](/garden/contributor-poker-review-as-investment/)": you [play the person, not the cards](https://kristoff.it/blog/contributor-poker-and-ai/).

AI-assisted contributions collapse the iterated game into a single-shot game. The human behind an AI-assisted PR does not need to build codebase intuition, and they may not care to maintain the code post-merge. They may not even be able to handle follow-up discussions that require deep understanding. The maintainers' review effort yields no return.

In practice, Zig experienced [drive-by PRs full of hallucinations, 10,000-line first contributions, and contributors who denied LLM use but clearly consulted one in follow-up discussions](https://kristoff.it/blog/contributor-poker-and-ai/). Simon Willison [sharpens the question](https://simonwillison.net/2026/Apr/30/zig-anti-ai/): "if a PR was mostly written by an LLM, why should a project maintainer spend time reviewing it as opposed to firing up their own LLM to solve the same problem?"

This is not about code quality. Even perfect AI-assisted PRs break the model. Community-building requires a human who is an eager participant, not a human proxy for an LLM. The object of the contribution is present, but the subject (a developing engineer with shared mission) is absent.

The pattern is spreading. LLVM's AI policy labels unreviewed AI submissions "[extractive contributions](https://llvm.org/docs/AIToolPolicy.html)" and bans AI from good-first-issue tickets: the ones that exist specifically to onboard new humans. `tldraw` [shut down external pull requests entirely](https://github.com/tldraw/tldraw/issues/7695) after AI-generated submissions overwhelmed its maintainers. Steve Ruizok: "An open pull request represents a commitment from maintainers... For that commitment to remain meaningful, we need to be more selective." When the bet cannot pay off, you fold the table.

## A house divided

When communities ban AI contributions, they protect the social contract. They also create a schism.

Bun, the JavaScript runtime, is built on Zig. Bun's team used AI to achieve a [4x compile speedup](https://www.opensourceforu.com/2026/05/zig-draws-hard-line-on-ai-bun-chooses-fork-over-upstreaming/) via parallel semantic analysis in their Zig fork. They cannot upstream it. Zig's core team [has technical objections](https://ziggit.dev/t/bun-s-zig-fork-got-4x-faster-compilation-times/15183/19) to the approach (the parallelization skips type resolution changes needed for deterministic compilation), but the AI contribution ban forecloses the collaborative path to resolving them.

[The commons splits](/garden/hollow-commons-schism-pattern/). The AI-accelerated fork iterates faster but becomes cleaved from the larger community. The human-maintained branch preserves community integrity but cannot match the pace. The parts are poorer than the whole.

[Gentoo](https://itsfoss.com/gentoo-linux-bans-ai-code/), [QEMU](https://allthingsopen.org/articles/open-source-ai-contributions-assisted-by-git-trailer-standard), [Ghostty](https://github.com/ghostty-org/ghostty/pull/10412), and [`curl`](https://www.neowin.net/news/beloved-tool-curl-is-shutting-down-its-bug-bounty-over-ai-slop-reports/) have imposed their own restrictions, from outright bans to shutting down contribution channels entirely. No two projects have drawn the line in the same place, but every project that bans AI contributions and has AI-using downstream dependents faces the same dynamic. The ban protects the social contract. The protection fractures the commons. The fracture weakens both branches.

## The ouroboros

The AI models undermining open source were [trained on open source](/garden/oss-ouroboros-training-data-trap/). GitHub Copilot was built on all publicly available code on GitHub: the vast majority open source, under licenses that never contemplated this use. The models learned to replicate open source code without license obligations. Whether this training constitutes fair use is [actively litigated](https://dockets.justia.com/docket/circuit-courts/ca9/24-7700) and unresolved.

The loop tightens. In March 2026, GitHub [announced](https://thenewstack.io/github-copilot-interaction-data/) it would train AI models on Copilot interaction data by default: not just the original repositories, but the prompts developers write and the suggestions they accept. Individual users can opt out. The default is opt-in. Each cycle feeds the next.

`curl` is the loop made personal. Daniel Stenberg's project trained the models. The models then generated [slop bug reports](https://www.itpro.com/software/open-source/curl-open-source-bug-bounty-program-scrapped) about `curl` itself, flooding the bug bounty program with fabricated vulnerabilities until Stenberg [shut it down](https://www.neowin.net/news/beloved-tool-curl-is-shutting-down-its-bug-bounty-over-ai-slop-reports/). The project's own contribution to the commons was weaponized against it.

The more code the community produces, the more it feeds the models undermining its sustainability. If it produces less code, it only diminishes itself. Today's landscape offers no equilibrium where open source thrives without a threat from the AI models trained on it.

De Valk and Maffulli are right that open source must find new foundations. But foundations require builders. A new legal framework needs communities to implement and maintain it. Communities need a legal framework that makes sustained contribution rational. Each depends on the other. Both are eroding simultaneously. The code keeps flowing. The commons is hollowing out.
