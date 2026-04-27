---
title: "Defense in Depth Needs Visibility"
garden_type: note
maturity: evergreen
tags: [software-engineering, defense-in-depth, monitoring, operations]
created: 2026-04-27
related_posts:
  - /defense-in-depth-vs-locality-of-behavior/
related_notes: []
excerpt_text: >
  Defense-in-depth — layering safeguards so that if one fails, another takes over — only works if every fallback layer is visible and monitored.
---

Defense-in-depth — layering safeguards so that if one fails, another takes over — only works if every fallback layer is visible and monitored. Unmonitored fallbacks mask root causes, allowing decay to accumulate silently until a larger blast radius triggers catastrophic failure.

The pattern: a cheap primary mechanism (minor compaction) fails silently, an expensive fallback (major compaction) kicks in unnoticed, the fallback works fine on small inputs, and no one investigates the primary failure. Then larger inputs arrive and the expensive fallback blows up.

The lesson: if a deeper defense activates, treat it as an incident signal. Alert aggressively when fallbacks fire. The whole point of defense-in-depth is redundancy, not invisibility — if you don't know your primary defense failed, your "resilience" is just hiding decay.
