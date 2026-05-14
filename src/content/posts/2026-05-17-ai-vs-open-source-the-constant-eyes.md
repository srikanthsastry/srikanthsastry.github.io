---

title: "AI vs. Open Source, Part 3: The Constant Eyes"
published: 2026-05-17
tags:

- 'ai'
- 'open source'
- 'security'
- 'software engineering'
abbrlink: 'ai-vs-open-source-the-constant-eyes'
lang: ''
excerpt: >
  Linus's Law assumed the number of eyes was the bottleneck for security.
  AI removed the bottleneck. When vulnerability discovery runs through a handful
  of frontier models, the "many" in "many eyes" collapses to a constant.
categories:
- Professional
series: 'Generative AI vs. Open Source'
series\_order: 3
image: /assets/images/ai-vs-open-source-constant-eyes-cover.jpg

---

In his book [The Cathedral and the Bazaar](https://en.wikipedia.org/wiki/The_Cathedral_and_the_Bazaar), Eric Raymond came up with Linus's Law: "Given enough eyeballs, all bugs are shallow." It has been held as a truism, and the argument is compelling. When source code is public, more people can inspect it. More inspection means more bugs found. More bugs found means more bugs fixed. Therefore, from a security perspective, open source code trumps closed source. "Security through obscurity" by hiding code reduces the number of eyes, therefore reduces security.

## Many Eyes

Deconstruct Linus's law within the scope of security and you see an assumption smuggled in: security reviewers are scarce, and getting a team of reviewers with complementary skills such as kernel, cryptography, compilers is harder still. When reviewers are human, this is true. And more reviewers from varied backgrounds genuinely provide superior coverage and analysis.

The frontier AI models have shattered this assumption, and with that have opened a new line of attack on open source's "unfair advantage".

## The Constant Eyes

With today's frontier models, you can spin up an orchestrator to interrogate a codebase with multiple expert subagents, each with a different specialization. The number of distinct capabilities and skill levels is not bounded by the number of humans, but by the number of models and the amount of tokens. And only a handful of frontier models exist today. A single security team with access to the models and the tokens can run all the same analysis against a codebase that a federated team of five thousand individuals could. The scale comes from the models and compute, and no humans.

The "many" in "many eyes" collapsed to a constant. The bottleneck moved from "how many people are looking" to "how capable is the model."

Yes, LLMs are probabilistic. Five thousand sessions produce five thousand different outputs. Some sessions might catch a vulnerability that others miss. But five thousand people running Claude is no different from one team running five thousand sessions. The "many eyes" advantage reduces to compute cost. And compute is increasingly cheap.

This is not security through obscurity, which claims that hiding code *makes* it secure. The constant-eyes argument claims something different: that opening code no longer provides a security *advantage*. The defensive coverage is the same either way, because the eyes that matter are the same frontier AI models. Open source did not get less secure. It lost the security premium that justified the exposure.

## The Evidence

The constant eyes are proving to be more capable than many eyes.

Google's [Big Sleep](https://projectzero.google/2024/10/from-naptime-to-big-sleep.html) found [20 previously unknown security flaws](https://www.computing.co.uk/news/2025/security/big-sleep-finds-20-flaws-in-open-source-software) in open source software, including FFmpeg and ImageMagick. Its most notable find: a critical [zero-day in SQLite](https://thehackernews.com/2024/11/googles-ai-tool-big-sleep-finds-zero.html) (CVE-2025-6965, CVSS 7.2) that had survived years of fuzzing, static analysis, and manual review. Big Sleep found it by reasoning about the code's semantics, not by pattern-matching known vulnerability signatures.

Microsoft's [Security Copilot](https://www.microsoft.com/en-us/security/blog/2025/03/31/analyzing-open-source-bootloaders-finding-vulnerabilities-faster-with-ai/) identified [20 vulnerabilities in GRUB2, U-Boot, and Barebox](https://www.bleepingcomputer.com/news/security/microsoft-uses-ai-to-find-flaws-in-grub2-u-boot-barebox-bootloaders/) bootloaders: integer overflows, buffer overflows, a cryptographic weakness, several of which could bypass Secure Boot.

The `curl` project brings this AI amplification into sharp relief. This is a 178k-line C codebase that already ran the pickiest compiler options, continuous fuzzing, and rigorous manual review. The code was among the most scrutinized in open source. AI still found hundreds of issues that human eyes and traditional tools had missed. AI-powered security tools have driven "[between two and three hundred bugfixes](https://daniel.haxx.se/blog/2026/05/11/mythos-finds-a-curl-vulnerability/)" and "probably a dozen or more" CVEs in `curl` over the past eight to ten months. Security researchers now "use AI extensively and effectively," generating a "[high volume of high quality security reports](https://daniel.haxx.se/blog/2026/04/22/high-quality-chaos/)."

And the offense is keeping pace. In May 2026, Google's Threat Intelligence Group [confirmed](https://cloud.google.com/blog/topics/threat-intelligence/ai-vulnerability-exploitation-initial-access) the first AI-assisted zero-day exploit developed in the wild. Attackers used an AI model to analyze an open source web admin tool's two-factor authentication design; it detected an invariant violation that was then weaponized to gain root access.

Firefox CTO Bobby Holley's [response](https://blog.mozilla.org/en/privacy-security/ai-security-zero-day-vulnerabilities/) to the flood of AI-discovered vulnerabilities captures the zeitgeist: "For a hardened target, just one such bug would have been red-alert in 2025, and so many at once makes you stop to wonder whether it's even possible to keep up."

## The Asymmetry

If defensive coverage is constant regardless of whether source is open or closed, the only remaining variable is attacker access.

In the case of open source, the attacker points a frontier model at the public repository. They incur the floor cost of finding a vulnerability: tokens. Take away the source, but not the binary, and the attacker's cost goes up significantly. They now have to decompile the binary, which is lossy, and perform binary analysis, which is even noisier; the AI models reason less effectively without the source code. Now, take away the binary and provide a service API, and the attacker's cost is now  higher still. All the attackers have access to is a black box of outputs for inputs, and a limited number of attempts before discovery.

The defender's posture is equal in all these cases. The defender has access to both the source code and the same AI models. The cost of defense is the floor cost of finding a vulnerability: tokens. What changes is the attacker's cost. Attacking open source software is the cheapest, and attacking a closed source service API is the highest.

This is an inversion of Linus's Law. With open source, the defender no longer has an advantage with "many eyes", and the attacker has all the advantage of "the constant eyes". With closed source, the defender has the advantage of "the constant eyes", and without source access, the attacker's advantage with "the constant eyes" is muted. Closed source wins out.

## The Treadmill

When both sides have source access and both sides can throw tokens at the code, the exploit window compresses. Attackers can now find vulnerabilities overnight, and the defender must match AI-speed offense continuously: every commit, every release, every day. AI red-teams become table stakes for release time testing. The defender must scan their codebase with all known AI models, and rescan with each new model release. Every new release starts a clock: scan, patch, and ship before attackers run the same model against the public source. Defense becomes a permanent sprint at the pace of the fastest attacker.

For closed source, the higher cost of attack affords the defender some breathing room: the option to defend at a pace proportional to the threat level, rather than locked to the maximum offensive capability of every frontier model with full source access. While this is not a free pass, it is as marked a difference as 4-day work week vs. 996.

"Many eyes" was always partly idealistic for many open source projects. A lot of the engineering contributions came from corporate sponsors, not volunteer contributions. For instance, the people running Big Sleep on FFmpeg are Google engineers, not volunteer contributors. The corporations now face the same security engineering challenge against a vastly larger threat surface, with no commensurate increase in the effectiveness of community defense. The marginal security cost of defending open source went up by an order of magnitude, but the marginal benefit of openness barely moved.

## The eyes still see

All the above does not automatically mean that the security conscious should be lobbying against open source. Open source continues to confer several advantages in the security realm. It gives you auditability; you know what you are executing. You get supply chain verification, and so your software provenance is clear (e.g., your device driver was not written by a dodgy North Korean spy network). Your builds are reproducible. You get trust from inspection instead of relying on contracts and blackbox verification. The "many eyes", and the human eyes continue to offer security benefits for open source, just not the kind that the AI models do.

## Where to next?

The three posts in this series map to three structural layers. [Part 1](/ai-vs-open-source-the-empty-grant/): the legal foundation. Copyright is the sole enforcement mechanism for open source licenses, and AI-generated code is not copyrightable. [Part 2](/ai-vs-open-source-the-hollow-commons/): the social contract. Contributor trust, community integrity, and the iterated game that sustains the commons are fracturing. Part 3: the security economics. The cost of defending publicly available code against AI-powered offense increased by an order of magnitude while the benefit of public review collapsed from "many eyes" to "the constant eyes".

All three are failing simultaneously, and for the same underlying reason: the frameworks that sustain open source were built for a world where humans write, review, and analyze code. That world is ending. The question is not whether open source will adapt. It always has. The question is whether the adaptation can outpace the collapse.