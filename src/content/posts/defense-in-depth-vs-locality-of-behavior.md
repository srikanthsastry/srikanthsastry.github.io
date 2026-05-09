---
title: "Defense in Depth vs Locality of Behavior"
published: 2025-07-14
tags:
  - 'software engineering'
abbrlink: 'defense-in-depth-vs-locality-of-behavior'
lang: ''
---

Defense-in-depth—borrowed from military and security strategy—means layering safeguards so that if one fails, another takes over ([Cloudflare](https://www.cloudflare.com/learning/security/glossary/what-is-defense-in-depth/), [Wikipedia](https://en.wikipedia.org/wiki/Defense_in_depth_(computing))). Defensive programming is a software take on the same idea: add checks and fallbacks so bugs don't escalate.

Meanwhile, the principle of [locality of behavior](https://alexkondov.com/locality-of-behavior-react/) (or “locality of behaviour” in htmx) says that "the behavior of a unit of code should be obvious by looking only at that unit" [[source](https://htmx.org/essays/locality-of-behaviour/)]. It draws on older ideas of cohesion: keep related logic together.

So when should you favor layering defenses, and when should you co-locate behavior? This isn’t that post. Instead, here’s a story about how leaning on defensive programming without scrutiny let a critical bug stay hidden for far too long.

**Background: minor and major compaction.** I was working on a big data system that performed repeated mutations on datasets via commits. Over time, reading slowed down—each read had to apply more mutations. To fix this, my service relied on cheap minor compactions. But unbeknownst to me, there was a fallback: a slow, expensive major compaction if too many mutations piled up. (See https://orc.apache.org/docs/acid.html.)

**Unexpected failures.** Suddenly, my service slowed down and sometimes timed out. Digging in, I found it was triggering major compactions. These were so costly that jobs exceeded timeouts and got killed.

Asking around, I learned this was an intentional fallback. It was a defensive programming safeguard in case minor compactions failed. Everyone thought this was great resilience.

**Increasingly brittle.** Then I asked: why did minor compactions fail in the first place? Silence. No alerts, no monitoring; no one knew.

Logs revealed major compactions had been quietly running on small datasets for ages due to a bug in minor compaction discovery. The problem stayed hidden because small datasets finished quickly. When larger ones arrived, everything blew up.

Ironically, the fallback meant we never fixed the root issue. Our supposed resilience made the system more fragile.

**Could we have seen this coming?** If major compactions didn’t exist—or at least raised an alarm every time—they’d have forced us to fix minor compactions long ago, before the blast radius grew.

So next time you violate locality of behavior for defense-in-depth, think hard. And always alert aggressively when deeper defenses kick in.

Building on these well-trodden ideas, this incident is just one more caution: [defense-in-depth only works if every fallback is visible and monitored](/garden/defense-in-depth-needs-visibility/). Otherwise, your “resilience” may just be hiding decay.
