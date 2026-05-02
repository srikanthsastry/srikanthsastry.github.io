---
title: "Deliverance from Directive Governance"
date: 2026-05-03
layout: post
categories:
    - Professional
tags:
    - governance
    - directive-governance
    - tech-industry
    - organizational-theory
    - subsidiarity
permalink: /deliverance-from-directive-governance/
image: /assets/images/deliverance-from-directive-governance-cover.png
excerpt: >
    Directive governance is structurally wrong for software and a structural ratchet keeps it in place. The escape is subsidiarity, decisions made at the lowest competent level, sustained by missionary culture that resists re-centralization under pressure.
---


This is the third post in the series about [directive governance](/garden/directive-governance/). The [first post](/cargo-cult-governance/) diagnosed the problem with governance in the tech industry as directive governance applied where it doesn't belong. Directive governance is top-down governance: decisions flow down, information travels up. It works in Pharma and manufacturing because three [preconditions](/garden/directive-governance-preconditions/) hold. (1) Information can be compressed without losing signal. (2) Metrics are good proxies for what the organization cares about. And (3) execution is distinct from decision-making. [None of this holds](/garden/essential-complexity-makes-software-ungovernable/) for software.

The [second post](/directive-governance-situationship/) explained why companies tend to not change the governance model, despite benefits to decentralizing decision making. In essence, it persists because a structural [ratchet](/garden/crisis-centralization-ratchet/) centralizes quickly during crisis and decentralizes almost never.

So, what's a gal like you supposed to do in such a cruel world! First off, there is no easy way out. But there *is* a way out; read on to find out.

## Quick fixes that don't fix

Let's dispatch three shortcuts that folks might resort to: AI, flattening, and rock star CEO. As standalone shortcuts, none of them escape the root cause: decisions are made where the information is not.

**AI fixes the information flow.** The argument is that AI can now summarize engineering discussions, design docs, and Slack threads with high fidelity. The stronger version: AI doesn’t just compress, it reasons across codebases, surfacing dependencies no single human sees. Either way, directive governance is now viable.

But here’s the rub. [Essential complexity](/garden/essential-complexity-makes-software-ungovernable/) in software engineering is irreducible ([Brooks](https://en.wikipedia.org/wiki/No_Silver_Bullet)). "We chose this abstraction boundary because of how three subsystems will need to evolve independently over the next two years" cannot be compressed into something a VP can evaluate across hundreds of systems under her purview. The judgment calls that matter most: which trade-offs to accept, which boundaries will hold as requirements shift. That context lives in the team, not in the model. AI gives you a better summary of what is measurable. It does not make the unmeasurable measurable. Worse: if leadership believes the information flow is fixed, they centralize harder. Confidence goes up. Accuracy stays flat.

**Flatten the org.** This one also seems to be in vogue. Just remove the hierarchy and information can flow freely to the top, and decisions are better explained to the bottom. If only! [Jo Freeman diagnosed in 1970](https://www.jofreeman.com/joreen/tyranny.htm) what every flat organization discovers: [eliminating formal hierarchy does not eliminate hierarchy](/garden/structurelessness-hides-hierarchy/). It eliminates *accountable* hierarchy. Valve's flat structure [concealed informal cliques](https://www.pcgamer.com/valves-flat-structure-contains-hidden-layer-of-powerful-management-claims-ex-employee/). Spotify's squad model [never worked at Spotify](https://www.jeremiahlee.com/posts/failed-squad-goals/). You replace a visible, broken pipeline with an invisible, unaccountable one.

**Get a better CEO.** This argument is essentially Confucian in that it concedes we will always have kings, and so we should make sure we have a "good king". Dressing it up for the 21st century, it goes "Jobs did it. Nadella did it. Bezos built it from scratch. The problem is personnel, not structure."

This doesn't go far enough. A good leader is necessary, but not sufficient. Jobs is the strongest case: Apple under his leadership was extraordinary. Apple after Jobs coasts on the momentum of his decisions, increasingly centralized, increasingly directive. The stock goes up and to the right. The pace of category-defining products has slowed. The kingdom did not survive the king. And the leaders who *did* build something lasting all made structural changes, not just better decisions. [Marquet](https://en.wikipedia.org/wiki/David_Marquet) took the [worst-performing submarine in the fleet](https://davidmarquet.com/turn-the-ship-around-book/) and turned it around by replacing "permission to" with "I intend to." Nadella spent a decade restructuring how decisions get made at Microsoft. In every case, the escape was structural, not personal.

## The deliverance: subsidiarity

What is the alternative to directive governance? Turns out, the alternative has already been done. No, not by [The Simpsons](https://en.wikipedia.org/wiki/Simpsons_Already_Did_It); by [the Catholic Church](https://en.wikipedia.org/wiki/Subsidiarity_%28Catholicism%29)!

The principle can be traced back to Christian philosophers [Thomas Aquinas](https://en.wikipedia.org/wiki/Thomas_Aquinas) and [Johannes Althusius](https://en.wikipedia.org/wiki/Johannes_Althusius), and the principle is called *subsidiarity*. In 1931, Pope Pius XI formalized it in [*Quadragesimo Anno*](https://www.vatican.va/content/pius-xi/en/encyclicals/documents/hf_p-xi_enc_19310515_quadragesimo-anno.html):

> "It is an injustice and at the same time a grave evil and disturbance of right order to assign to a greater and higher association what lesser and subordinate organizations can do."

I have co-opted it as follows.

**[Subsidiarity](/garden/subsidiarity/): decisions should be made at the lowest level competent to make them. Higher levels sit behind, providing context, guardrails, and intervening only when lower levels cannot handle the issue.**

[This is not flattening](/garden/subsidiarity-is-not-flat-organization/). Subsidiarity preserves hierarchy but changes what it is *for*. The function shifts from directing to enabling. Accountability still aggregates upward. Decisions stay where information lives.

The [existence proofs](/cargo-cult-governance/) from the first post are all instances of subsidiarity. Toyota's andon cord, Amazon's two-pizza teams, Berkshire Hathaway's 30-person headquarters, the US Army's mission command. None of them invented something new.

## Subsidiarity needs missionaries

Subsidiarity implemented as a reorg will not survive the first crisis. The ratchet will compress it back. That is the Spotify illusion from the [previous post](/directive-governance-situationship/): structure without substance.

What separates the existence proofs from the illusions is [**missionary culture**](/garden/delegation-mimicry-without-cultural-substrate/): an organization where every member is motivated by advancing the mission and views others as partners in that endeavor. Decisions are defended based on how they impact the mission. Not based on which VP cares about the project. Not based on which metrics will move.

Subsidiarity alone does not produce this. An SRE team with full decision-making freedom might internalize their role (keep the fleet humming) without caring about the organization's mission to "connect people" or "organize the world's information." That is functional, but fragile. When the next crisis hits, a team that owns its role but not the mission has no reason to resist centralization. The ratchet finds less resistance.

Missionaries are different. When a top-down decision runs counter to the mission, they push back. They challenge it, acting as a governor on the ratchet of centralization. If you have internalized the mission, a directive that violates it feels viscerally wrong.

Netflix's stock crashed 70% in 2022. They did not re-centralize. Their [2024 culture revision](https://www.hrgrapevine.com/us/content/article/2024-06-26-netflix-announces-rare-revision-of-iconic-culture-playbook) doubled down on "context not control." The people making decisions were not waiting for permission. They had a shared understanding of what Netflix exists to do, and a stock crash did not change that. The mission was the coordination mechanism. Not the reporting chain.

Amazon's leadership principles are how an L5 engineer decides what to build without asking a VP. [Marquet's](https://en.wikipedia.org/wiki/David_Marquet) "I intend to" model on the USS Santa Fe worked because every sailor understood the submarine's mission well enough to propose action without waiting for orders.

Without missionary culture, subsidiarity is just another structural change that snaps back under pressure. With it, subsidiarity is self-reinforcing: every decision made locally, grounded in the mission, builds the muscle that makes the next local decision possible.

## The stencil

This is not a playbook. It is a diagnostic you can superimpose on your own organization.

Are you reaching for AI, flatter org charts, or the right leader? Those are fig leaves. Where are decisions actually made (not what the org chart says, but the actual flow)? When decisions are justified, what is the grammar: "leadership wants X" or "this serves our mission because Y"?

You probably cannot fix your organization's governance model. But you can see it clearly, name it, and choose where to work with open eyes.
