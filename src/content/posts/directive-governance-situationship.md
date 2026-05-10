---
title: "Tech Companies and Directive Governance: A Situationship"
published: 2026-04-16
tags:
  - governance
  - 'directive-governance'
  - 'tech-industry'
  - 'organizational-theory'
abbrlink: 'directive-governance-situationship'
image: /assets/images/directive-governance-situationship-cover.jpg
lang: ''
---



Most large tech companies operate top-down. Information flows up through a reporting chain. Decisions are made centrally. Directives flow back down. This is true regardless of what their culture decks say. Unfortunately, it is the wrong way to govern for software engineering. Top-down governance works when information flowing upstream is compressible, the metrics that decision makers see are a good proxy for org health and success, and decision-making and execution are distinct from each other. None of these hold for software engineering. I have detailed all the wrongness in ["Cargo Cult Governance".](https://srikanth.sastry.name/cargo-cult-governance/)

If you take my claim of wrongness at face value, the natural follow-up question is the one my nine-year-old asks regularly: "why?" If the structural mismatch is that clear, and the existence proofs are that abundant, why don't large tech companies change?

Before going into the "Why", we need to answer the "What?". Specifically, what is "directive governance"?

## The "what": Directive governance

The colloquial term for this is "[command and control](/garden/command-control-misnomer/)." That term is imprecise and means different things to different people. What dominates the tech industry is something more specific. Burns and Stalker come close with the notion of [mechanistic organization](https://en.wikipedia.org/wiki/Mechanistic_and_organic_systems) in 1961: rigid hierarchy, top-down decision-making, formal procedures, accountability through the chain of command.

In practice, tech companies are not purely mechanistic. They bolt on organic elements: hackathons, "innovation time," autonomous-team branding. The mechanistic core stays intact. I call this **[directive governance](/garden/directive-governance/)**:

> **Information flows up** (compressed and possibly lossy). **Decisions are made centrally** based on whatever survives the trip. **Directives flow back down** for execution. **Accountability is for compliance**: did you execute the directive? Not: did you achieve the outcome?

Directive governance works when the three preconditions I mentioned earlier hold: information is compressible without critical loss, quantitative metrics correlate with reality, and decision-making is separable from execution. In manufacturing, these hold. In software, they structurally don't.

So... why don't companies switch? The answer is a [ratchet](/garden/crisis-centralization-ratchet/).

## The "Why": The ratchet

The ratchet hypothesis.

> Tech companies centralize quickly during crisis and decentralize very slowly afterward.

The asymmetry has three layers, and they compound.

**Layer one: mechanical asymmetry.** Centralizing is a directive. "All decisions go through me now." That can happen overnight. Decentralizing is a culture. It requires building judgment, trust, and context at every level of the hierarchy. The transition to decentralization itself requires some level of decentralization. Culture takes years.

**Layer two: loss aversion.** Even when organizations are no longer in crisis, can afford to decentralize, *and see the benefits of it*, they do not start. Because being caught mid-transition when the next crisis arrives feels worse than staying centralized. A fully centralized org can respond quickly, even if the response is wrong. A half-decentralized org has neither the speed of centralization nor the distributed judgment of full decentralization. So you wait. And the next crisis arrives. And the waiting becomes permanent.

**Layer three: competitive pressure as the only loosening force.** Peacetime loosening is not voluntary. It is forced by upstarts that are nimble and innovative. When smaller competitors are shipping faster and stealing talent, the pressure to federate becomes hard to ignore. But because it is reactive rather than deliberate, it produces shallow structural changes. Skunkworks. Federated org charts. Squad models. Autonomous teams that still need VP sign-off. The structure gets decentralized. The culture does not; remember, it can take years. That is why it snaps back the moment crisis returns.

The three layers compound. The transition is mechanistically slow, psychologically avoided, and when it happens at all, shallow and reversible. If crises come faster than the loosening rate, centralization accumulates.

The ratchet makes a falsifiable prediction.

> Long peace produces observable loosening. Frequent crises produce persistent centralization.

The evidence fits this prediction. Consider the last fifteen years in the tech industry. From 2012 to 2018, a long peace produced observable loosening. Facebook was federated: "move fast and break things," teams shipping independently. Google let teams launch products with minimal central approval. Nadella took over Microsoft in 2014 and killed the stack ranking system that had crippled the company for a decade. Peacetime loosening, exactly as the ratchet predicts. Some products from that era failed (Google Allo, Amazon Fire Phone, Google Glass, Meta Portal, etc.), and others broke new ground (Google Cloud and Microsoft Azure, the [Transformer paper](https://arxiv.org/abs/1706.03762), etc.). You do not get to cherry-pick the hits without accepting the misses. The product graveyard is not evidence of federation failing. It is the cost of federation succeeding.

Then came the crises: Trade tensions, COVID, the hiring binge and the correction, AI panic, layoff waves. Every eighteen to twenty-four months, another shock. Zuckerberg's "year of efficiency." Google's layoffs. Meta's flattening. The loosening snapped back instantly because it was structural, not cultural. A competitive response, not a deliberate transformation.

The organizations that practice federated decision-making (Amazon, Netflix, Toyota, mission command) escaped all three layers. They invested in culture before they needed it. They did it deliberately and deeply. They maintained it long enough for the slow process to take hold. Their decentralization does not snap back under pressure because it is not shallow. Netflix is the clearest test. Stock crashed 70% in 2022. They laid off staff. They did not re-centralize. Their [2024 culture revision](https://www.hrgrapevine.com/us/content/article/2024-06-26-netflix-announces-rare-revision-of-iconic-culture-playbook) doubled down on "context not control."

## What makes it stick

The ratchet is the spine. Four forces make it stickier.

**Serial [satisficing](https://en.wikipedia.org/wiki/Satisficing) [without learning](/garden/serial-satisficing-without-learning/).** Hire aggressively in 2021. Lay off aggressively in 2023. Pivot to AI in 2023. Each correction is presented as the rational fix to the previous bounded decision. But the claim that any correction is rational is [not falsifiable](/garden/unfalsifiable-organizational-corrections/). Neither is the claim that it is wrong. That is the point. Nobody checks. Nobody builds the feedback mechanisms that would let you check next time. [Pfeffer's research](https://www.gsb.stanford.edu/insights/why-copycat-layoffs-wont-help-tech-companies-or-their-employees) provides the closest thing to empirical traction: companies that did not lay off performed equally well. The honest version of the earnings call: "We are making this correction with equally incomplete information, and we have no way of knowing if it is better than what it replaced." Nobody says that.

**Institutional inertia.** The companies are profitable. The stock is up. Directive governance is not producing visible failures. Why would anyone champion a multi-year cultural transformation with uncertain payoff? The ratchet provides cover during crisis: centralization is plausible enough to be defensible. In peacetime, the status quo is plausible enough to be comfortable. Nobody fixes what appears to work.

**Incentive structures.** Meta recently tied [nearly $1 billion in executive compensation to stock price targets](https://corpgov.law.harvard.edu/2026/04/10/metas-new-executive-pay-plan-ties-nearly-1-billion-to-stock-performance/). Not innovation rate. Not decision quality. Not talent retention. Stock price. The CTO, CPO, COO, and CFO all hold options that pay out only if market capitalization hits specific thresholds. This is not unusual. It is the norm. Executive compensation rewards what directive governance can produce: revenue, cost cuts, market cap. It does not reward what decentralization would improve.

**The Spotify illusion.** Companies that claim to have decentralized but have not. Spotify's squad model was ["part ambition, part approximation."](https://www.jeremiahlee.com/posts/failed-squad-goals/) Co-author Joakim Sundén later admitted people struggled to copy "something that didn't really exist." Spotify itself transitioned back to traditional management. This is the shallow loosening the ratchet predicts: [structural change without cultural change](/garden/delegation-mimicry-without-cultural-substrate/). It looks like adaptation without being adaptation.

These forces do not operate independently. They feed the ratchet. Serial satisficing provides the post-hoc justification for each centralization. Inertia keeps the status quo comfortable. Incentives make change financially unrewarding. The Spotify illusion lets companies claim they have changed when they have not. Together, they ensure that even when competitive pressure forces loosening, the loosening stays shallow.

## How does it make $$$

If directive governance is that broken, why are these companies worth trillions?

Because bad governance is [a tax on performance, not a death sentence](/garden/directive-governance-degrades-not-destroys/). When you have a search monopoly, network effects, or ecosystem lock-in, the monopoly rents absorb the tax. Microsoft lost a decade of market cap under Ballmer and emerged just fine. Google missed the boat on generative AI, despite authoring the seminal Transformer paper, and lost billions playing catchup. Apple and Meta spent billions on VR headsets that have yet to find a market.

The point is not that directive governance leads to death or bankruptcy. The point is that outward success does not mean the organization is healthy. The failure mode for most large tech companies is not death. It is languishing. Profitable enough to survive. Too poorly governed to innovate. The best engineers leave for younger companies where they can make decisions. The products get incrementally worse. The stock price holds up long enough that the board never forces the issue.

The urgency here is personal, not institutional. You can work inside directive governance and function. The company will survive either way. Directive governance ties your ability to drive innovation to the grace of your leader. That grace can be snatched away overnight.

Nadella's Microsoft is the rare counterexample: a deliberate, decade-long cultural investment that has survived multiple crises. The rarity is the point. The escape requires investment on a timeline that exceeds most executive tenures, in a discipline most leaders have never practiced.
