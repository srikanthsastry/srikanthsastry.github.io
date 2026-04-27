---
title: "Shadow-Verify-Migrate Pattern"
garden_type: note
maturity: evergreen
tags: [software-engineering, design-patterns, migration, object-composition]
created: 2026-04-27
related_posts:
  - /object-composition-for-service-migration/
related_notes: []
excerpt_text: >
  Migrate between service implementations in three composed steps: shadow, verify, switch.
---

**Migrate between service implementations in three composed steps: shadow, verify, switch.** Compose old and new behind a common interface — delegate real traffic to the old, shadow a percentage to the new, and log mismatches to verify equivalence before anything real moves. Then replace the shadow client with a migration client that routes by configuration — roll forward by adjusting config, roll back by reverting it. Finally, delete the old code.

The key insight: each step is a composition of the same two implementations behind the same interface; the caller never changes. This avoids the common anti-patterns of inheriting old into new (coupling lifecycles), if-else blocks inside the old implementation (degrading it during transition), or skipping verification entirely.
