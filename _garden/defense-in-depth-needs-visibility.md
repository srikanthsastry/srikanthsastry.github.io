---
title: "Defense in Depth Needs Visibility"
maturity: evergreen
tags: [software-engineering, defense-in-depth, monitoring, operations]
created: 2026-04-27
related_posts:
  - /defense-in-depth-vs-locality-of-behavior/
related_notes:
  - align-alerts-to-sev-criteria
excerpt_text: >
  Defense-in-depth only works if every fallback layer is visible and monitored.
---

**Defense-in-depth only works if every fallback layer is visible and monitored.** Unmonitored fallbacks mask root causes, allowing decay to accumulate silently until catastrophic failure. The pattern: a cheap primary mechanism fails silently, an expensive fallback kicks in unnoticed, works fine on small inputs, and nobody investigates. Then larger inputs arrive and the fallback blows up.

If a deeper defense activates, treat it as an incident signal. [align-alerts-to-sev-criteria](/garden/align-alerts-to-sev-criteria/) when fallbacks fire. The whole point of defense-in-depth is redundancy, not invisibility. If you don't know your primary defense failed, your "resilience" is just hiding decay.
