---
title: "AI Security Cost Asymmetry Favors Closed Source"
maturity: evergreen
tags: [ai-open-source, security, cost-asymmetry, constant-eyes]
created: 2026-05-12
related_notes:
  - constant-eyes-linus-law-collapse
related_posts:
  - /ai-vs-open-source-the-constant-eyes/
excerpt_text: >
  AI equalizes the defender's security cost across open and closed source but varies the attacker's cost by source availability. This inverts Linus's Law.
---

**AI equalizes the defender's security cost across open and closed source but varies the attacker's cost by source availability. This inverts Linus's Law: openness helps the attacker more than the defender.** The defender always has source access and frontier models; their cost is the floor: tokens. What changes is the attacker's cost. Open source: point a model at the public repository (tokens). Closed binary: decompile first (lossy, noisier analysis). Service API: black box, limited attempts, highest cost. The defender's posture is constant in all three cases. Source availability is now a variable in the attacker's equation only.
