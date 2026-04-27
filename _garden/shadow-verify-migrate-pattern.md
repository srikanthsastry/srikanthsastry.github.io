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
  When migrating from one service implementation to another, object composition provides a clean three-step pattern that avoids the common pitfalls of inheritance-based or if-else-based migration hacks.
---

When migrating from one service implementation to another, object composition provides a clean three-step pattern that avoids the common pitfalls of inheritance-based or if-else-based migration hacks.

## Step 1: Shadow and verify equivalence

Compose old and new implementations behind a common interface. The composed object delegates to the old service for real traffic, optionally shadows a percentage of calls to the new service, and logs any response mismatches. This verifies functional equivalence *before* any real traffic migrates.

## Step 2: Configure migration

Replace the shadow client with a migration client that routes traffic to old or new based on configuration. This allows gradual migration — roll forward by adjusting config, roll back by reverting config, no code changes needed.

## Step 3: Clean up

After 100% migration, replace the migration client with the new implementation directly and delete all old code.

The key insight: each step is a composition of the same two underlying implementations behind the same interface. The caller never changes. The migration machinery is layered *around* the implementations rather than tangled *inside* them.

Common anti-patterns this avoids:
- Inheritance from old to new (couples their lifecycles)
- If-else blocks inside the old implementation (makes the old code worse during transition)
- Skipping shadow verification entirely (risks service incidents)
