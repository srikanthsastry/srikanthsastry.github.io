---
title: "Cargo Cult Governance"
published: 2026-03-26
tags:
  - governance
  - 'directive-governance'
  - 'software-engineering'
  - 'tech-industry'
  - 'organizational-design'
abbrlink: 'cargo-cult-governance'
image: /assets/images/cargo-cult-governance-cover.jpg
lang: ''
---


In the tech industry, we have been through a corporate rollercoaster in the last few years. First, it was the hiring mania during COVID, followed by widespread layoffs starting 2023. Then there is the pivot at AI, followed by the "flattening" of middle management. Regardless of whether you were laid off, or you carry the survivor's guilt, or you are shoveling AI slop to get to something useful, the mental scars are very real. So is the cynicism that the leadership may not know what it is doing. The decisions feel callous, short-sighted, even whimsical, and based on [wildly inaccurate information](/garden/data-pipeline-is-achilles-heel/).

But does it *have* to work this way? What's actually driving these decisions, and is there a better mechanism? Because if the answer is "this is just how large companies work," that's one kind of problem. If the answer is "there's a specific, diagnosable flaw in how these decisions get made", then that's a different one. One that might be fixable.

## The mechanism: directive governance

The governance model that dominates the technology industry is what I call *directive governance*: information flows up through a reporting chain (compressed and lossy), decisions are made centrally, and directives flow back down for execution. Directive governance is how most large tech companies are actually run, regardless of what their culture decks say. (I formalize this definition in [a follow-up article](/directive-governance-situationship/).)

And there is a reason for that. Directive governance has been very successful in a myriad of industries and organizations: pharmaceutical development, aviation, manufacturing, and even many parts of the military. What we see in the tech industry is a form of [isomorphic mimicry](/garden/isomorphic-mimicry-in-tech-governance/); if it works in those areas, then it should work here too.

However, if you stop to ask why exactly it works in those industries, you start to see the fallacy in [this mimicry](/garden/directive-governance-cargo-cult/). In pharmaceutical development, clinical trial data is structured and quantifiable. The information that matters can travel up the chain without losing its meaning. In aviation, decades of failure analysis have produced checklists and procedures that genuinely capture what matters. The gap between what the front line knows and what leadership sees is narrow by design. In manufacturing, defect rates and throughput are real proxies for operational reality. Cost per unit correlates with what's actually happening on the floor. And the person who designed the part is genuinely distinct from the person who fabricates it to spec.

Briefly, directive governance works really well when information for decision making is highly compressible without losing fidelity, is verifiable, and the decisions are clearly separable from their execution. These conditions are favorably satisfied in the industries mentioned earlier, and hence the success of directive governance in these spheres.

But the tech industry doesn't conform to [these conditions](/garden/directive-governance-preconditions/), and therein lies the problem; the reason directive governance works poorly here.

## The damage

This isn't theoretical. The wreckage is visible and well-documented.

- During Microsoft's [lost decade](https://www.vanityfair.com/news/business/2012/08/microsoft-lost-mojo-steve-ballmer), stack ranking destroyed collaboration across the company. It was a centralized performance system that forced bell-curve grading. As a result, employees optimized against each other instead of for the product. Market cap fell from $580 billion to $249 billion. Leadership could see attrition rates and shipping dates. They could not see the innovation that wasn't happening.
- In 2011, Google made the top-down decision to compete with Facebook on social and mandated that all teams across Google integrate Google+ into their products. Decision was made, and the teams were expected to execute. But "integrate social" is not a specification. Each team made their own decisions about what integration meant for their product. The decisions that determined whether the product would be coherent were not made by Google leadership. They were made by dozens of teams independently, at the execution layer, with no mechanism to coordinate them. The result was a Frankenstein. Google+ was shut down in 2019.
- After Elon Musk laid off roughly 80% of Twitter's staff, [a single remaining SRE](https://www.platformer.news/how-a-single-engineer-brought-down/) made a configuration change that broke the entire platform: links, images, internal tools, everything. "You may not see negative effects immediately," NYU's Justin Cappos [observed](https://engineering.nyu.edu/news/what-twitters-outage-says-about-over-zealous-downsizing). "A month later you start to take a hit, and then the wheels start to fall off." Musk couldn't see which engineers were load-bearing because their contributions didn't show up in the metrics visible from the top.
- In March 2026, OpenAI [killed Sora](https://petapixel.com/2026/03/24/openai-kills-sora-and-loses-disneys-1b-investment/), its video generation tool, because it was a "distraction". The pivot to ChatGPT-first left the Sora and DALL-E teams starved and feeling like [second-class citizens](https://www.digit.in/features/general/openai-ignoring-research-sora-and-dall-e-suggest-people-leaving-chatgpt-maker.html/amp/). The result was an exodus of significant talent from OpenAI. In summary: centralized leadership greenlit a scatter of products, discovered the strategy was incoherent, and corrected with another centralized decision. The cost wasn't just a cancelled product. It was the people who walked out the door.

You have seen some version of this play out in your own workplace. It might be at a lower scale and with lower stakes, but the pattern is the same. What you might not have seen is the mechanism that produces it.

## When does directive governance break?

Directive governance rests on [three implicit assumptions](/garden/three-assumptions-framework/) about the information pipeline connecting the people who decide to the people who do:

1. **Compression.** When information is summarized upward, the compression preserves the signal that matters.
2. **Proxy validity.** The quantitative metrics available to decision-makers correlate with the reality they're managing.
3. **Separability.** Decision-making and execution are distinct activities that can be cleanly divided between levels of the hierarchy.

These assumptions hold in many industries. In manufacturing, summarizing production into throughput metrics *does* preserve what matters. Cost per unit *does* correlate with operational reality. And the engineer who designed the part is genuinely distinct from the worker who fabricates it to spec.

But these don't hold true in tech. To understand why, we need to go back to Hayek and Austin. [Hayek recognized](https://www.econlib.org/library/Essays/hykKnw.html) that in any complex system, knowledge is often inherently distributed, tacit, and contextual. It resists centralized aggregation by its nature. And Robert Austin [demonstrated in 1996](https://www.oreilly.com/library/view/measuring-and-managing/9780133488425/) that if only some dimensions of work are measurable, then [measurement-based management actively degrades what cannot be measured](/garden/partial-measurement-worse-than-none/). The combination of these two conditions in the tech industry invalidates the three assumptions above.

## Why tech specifically

In 1986, Fred Brooks drew a distinction in ["No Silver Bullet"](https://www.cin.ufpe.br/~phmb/ip/MaterialDeEnsino/BrooksNoSilverBullet.html) that remains true despite all the advances in software engineering: software has *essential* complexity (the irreducible difficulty of the problem itself) and *accidental* complexity (the incidental difficulties of our tools and processes). Tools can attack accidental complexity. They cannot touch essential complexity, because it *is* the problem.

This argument [extends to governing the people who build it](/garden/essential-complexity-makes-software-ungovernable/). When you apply it there, all three assumptions collapse.

**Compression fails.** Essential complexity is irreducible by definition. You can compress "we shipped 15 features this quarter" into a slide, but you cannot compress "we chose this abstraction boundary because of how three subsystems will need to evolve independently over the next two years" into anything a non-participant can evaluate. The compression directive governance requires strips precisely the signal that matters. This goes back to Hayek's observation about knowledge's resistance to centralization.

**Separability fails.** This is where software diverges most sharply from other industries. In manufacturing, you do the same thing repeatedly. The design decision was already made, and execution follows a spec. Micro-decisions on the line are local and ephemeral. They don't compound.

Everything you build in software is new (if it weren't, you'd just call the API that already does it), and consequently, the act of building software itself is decision making: choosing an abstraction, defining an interface, decomposing a system. And unlike manufacturing, software decisions compound. Every abstraction choice constrains every future choice built on top of it. A manufacturing micro-decision lives and dies in the moment. A software decision shapes the codebase for years.

In software, [execution *is* decision-making](/garden/in-software-execution-is-decision-making/). Directive governance depends on a separation between the two that doesn't exist.

**Proxy validity fails.** [The metrics that survive the reporting chain](/garden/metrics-measure-maintenance-not-creation/) (uptime, sprint velocity, cost per headcount) track what keeps the lights on. They don't track what makes the company thrive. Innovation, architectural soundness, the quality of an abstraction, whether a team's trajectory is sustainable: none of these fit in a dashboard. As per Austin's observation, the metrics don't just miss creativity and innovation; they actively redirect effort away from it and toward maintenance.

The tech industry fails these three assumptions structurally and inherently, and the problem is only getting more acute. All of our advances in software engineering (Agile, CI/CD, cloud infrastructure, AI-assisted coding) [serve only to eliminate accidental complexity](/garden/tooling-advances-prove-brooks-right/). This leaves the essential complexity to dominate the signal loss in upward communication and to force leveraged decision-making in execution, while continuing to remain in the blindspot like a ghost moving the metrics.

## The structural implication

If directive governance fails because the tech industry is structurally not convivial to it, then we need structural changes to how decisions are made. The structural fix here is that [decisions get made where the information actually lives](/garden/subsidiarity/). But [subsidiarity is not the same as flattening the org chart](/garden/subsidiarity-is-not-flat-organization/).

Does that mean we should 'flatten' the org chart? Is all this talk of 'flattening' really going somewhere? Sigh. I wish. It has been tried, and it produces its own pathologies. Valve's famous flat structure [concealed a hidden hierarchy](https://www.pcgamer.com/valves-flat-structure-contains-hidden-layer-of-powerful-management-claims-ex-employee/) of informal cliques. Jo Freeman [diagnosed this dynamic in 1970](https://www.jofreeman.com/joreen/tyranny.htm): [structurelessness doesn't prevent hierarchy, it prevents *accountable* hierarchy](/garden/structurelessness-hides-hierarchy/). The loudest and most politically savvy end up in charge, with no formal mechanism for review or appeal. Spotify's squad model [never actually worked at Spotify](https://www.jeremiahlee.com/posts/failed-squad-goals/). "Even at the time we wrote it, we weren't doing it," co-author Joakim Sundén admitted. When Zappos adopted holacracy and gave employees an [ultimatum to embrace self-management or leave](https://www.entrepreneur.com/business-news/looks-like-zappos-self-management-system-isnt-for-everyone/246076), 14% of the company walked out the door. Eliminating hierarchy doesn't solve the information problem. It just makes power invisible.

But there are organizations, across industries, at massive scale, that have kept hierarchy while relocating decision authority within it.

- Toyota gives any assembly line worker the authority to [pull the *andon* cord](https://www.amazon.com/Toyota-Way-Management-Principles-Manufacturer/dp/0071392319) and stop the entire production line when they spot a defect. Why? Because the worker has specific knowledge no dashboard can capture.
- Amazon scales by [multiplying small teams](https://workingbackwards.com/concepts/amazon-single-threaded-teams/), not layering hierarchy. The "two-pizza team" is small enough that one leader can have full context. It is directive governance at a scope where the information precondition actually holds, federated across thousands of teams.
- Netflix operates on the [explicit principle](https://www.amazon.com/dp/1984877860) that leadership's job is to communicate *what* and *why*; the people doing the work decide *how*.
- Warren Buffett runs Berkshire Hathaway, a $900 billion conglomerate, with [roughly 30 people at headquarters](https://www.berkshirehathaway.com/letters/letters.html). He handles capital allocation, where a bird's-eye view helps. Subsidiary CEOs handle everything else, where local knowledge is what matters.
- And the US Army, an institution built on hierarchy and obedience, formalized [mission command](https://www.army.mil/article/225414/combined_arms_center_launches_new_mission_command_doctrine): commanders communicate intent, subordinates decide execution. L. David Marquet [transformed the USS Santa Fe](https://www.amazon.com/Turn-Ship-Around-Turning-Followers/dp/1591846404) from the worst-performing submarine in the fleet to the best by replacing "permission to" with "I intend to."

Notice that none of these examples eliminated hierarchy. They all redesigned where decisions happen within it. The tech industry didn't need to discover a new governance structure. It just needs to snap out of its dogma and stop ignoring what works.
