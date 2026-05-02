---
title: "Align Alerts to SEV Criteria"
garden_type: note
maturity: evergreen
tags: [operations, alerting, monitoring, SLOs, on-call]
created: 2026-04-27
related_posts:
  - /sync-your-alerts-to-your-sev-criteria/
  - let-sleeping-engineers-lie-why-your-alerts-should-match-your-sevs
related_notes: []
excerpt_text: >
  Alerts should fire at or near the threshold where an SLO breach would occur, not well before.
---

**Alerts should fire at or near the threshold where an SLO breach would occur, not well before.** Premature alerts create noise, erode trust in the alerting system, and burn out on-call engineers with false urgency. When alerts fire for conditions that don't correspond to real severity criteria, the on-call workflow degrades: engineers distrust pages, investigate phantom issues, and escalate reflexively rather than with judgment.

The rule: if an alert wakes someone at 4 AM, there should be a clear SEV, an SLO breach, or measurable user impact. If none exist, the threshold needs recalibration.
