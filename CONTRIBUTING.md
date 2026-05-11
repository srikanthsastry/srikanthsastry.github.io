# Contributing

## Publishing a Blog Post (with Garden Notes)

Every blog post ships alongside its digital garden notes in the same branch/PR.

> **Astro vs Jekyll:** This repo has migrated from Jekyll to Astro. The workflows below are for Astro. Legacy Jekyll instructions are at the bottom for reference.

### 1. Identify Garden-Worthy Notes

Review PKM items (thoughts, notes, sources) related to the post. Not everything needs a garden entry — only concepts the post references that benefit from standalone exposition.

**Include:** Concepts the post introduces or leans on that a reader would want to explore independently.
**Skip:** Implementation details, raw research intake, things fully explained in the post itself.

### 2. Convert PKM to Garden

```bash
./scripts/pkm-to-garden-astro.sh ~/workspace/brain/thoughts/thought-20260424-*.md
./scripts/pkm-to-garden-astro.sh ~/workspace/brain/sources/source-some-reference.md
```

The script generates `src/content/garden/` files with frontmatter derived from your PKM. Review and adjust:
- **Title** — auto-derived from the slug if missing; verify it reads well
- **Maturity** — auto-derived from PKM status; override if wrong
- **Excerpt** — auto-extracted first sentence; tighten if needed
- **Related notes** — auto-populated from PKM cross-refs; add any missing

Use `--force` to regenerate an existing garden file.

### 3. Add Cross-Links

**Blog post → Garden notes:**
Add inline links at the first meaningful mention of each concept. High-signal only — don't link every noun, only where the garden note provides genuine additional depth.

```markdown
# Bad: linking everything
The [agent](/garden/ai-agent-category-error/) uses [local context](/garden/ambient-to-local/)
to [pursue goals](/garden/goal-vs-intent/) via [friction](/garden/friction-requires-intent/)...

# Good: linking key concepts that benefit from exposition
This [directive gap](/garden/directive-gap/) is the root cause of most suggestible-actor failures.
```

**Garden notes → Blog post:**
Add the post's permalink to `related_posts` in each new garden note's frontmatter:

```yaml
related_posts:
  - /the-suggestible-actor/
```

**Garden notes → Other garden notes:**
Add `related_notes` slugs and body links for connected concepts.

### 4. Audit Cross-Links

Read each new garden note. For every concept mentioned that has its own garden entry, verify there's a link in the body text and an entry in `related_notes`.

### 5. Set Maturity Levels

Review each note and assign the right maturity:

| Maturity | When to use | PKM equivalent |
|----------|-------------|----------------|
| 🌱 `seedling` | Early idea, might change substantially | `raw` or no status |
| 🌿 `budding` | Developed argument with room to grow | `developing` or `draft` |
| 🌳 `evergreen` | Stable definition/framework, unlikely to change | `connected` or `stable` |

Sources default to `evergreen`.

### 6. Commit Together

Blog post + new garden notes + any updates to existing garden notes — all in one branch/PR.

```bash
git checkout main && git pull
git checkout -b post/your-post-slug
# ... make changes ...
git add src/content/posts/YYYY-MM-DD-your-post-slug.md src/content/garden/*.md
git commit -m "Add post: Your Title + garden notes"
git push origin post/your-post-slug
```

### 7. Update PKM Status

After publishing, update the PKM thought `status` fields to match the garden maturity:

| Garden maturity | PKM status |
|----------------|------------|
| `seedling` | `raw` |
| `budding` | `developing` |
| `evergreen` | `connected` |

---

## Drafts

In Astro, there is no `_drafts/` directory. Instead, add `draft: true` to frontmatter in `src/content/posts/`:

```yaml
---
title: "My Draft Post"
published: '2026-06-01'
draft: true
# ... other frontmatter ...
---
```

Drafts are visible in `astro dev` but filtered out of production builds. When ready to publish, remove the `draft: true` line (or set it to `false`).

---

## Blog Post File Naming

Post files in `src/content/posts/` use date-prefixed filenames matching their publication date:

```
src/content/posts/YYYY-MM-DD-slug.md
```

For example: `src/content/posts/2026-05-10-my-new-post.md`

The URL slug comes from the `abbrlink` frontmatter field, not the filename. The date prefix is for filesystem organization only.

---

## Garden Entry Frontmatter Reference

```yaml
---
title: "The Directive Gap"
garden_type: thought          # thought | note | source
maturity: evergreen           # seedling | budding | evergreen
tags: [ai, software-design]
created: 2026-04-24
related_posts:
  - /the-suggestible-actor/
related_notes:
  - confabulation-is-plausible
  - ambient-to-local
excerpt_text: >
  First sentence or two for the index card.
# Source-specific (only for garden_type: source)
source_author: "Author Name"
source_year: 2020
source_url: "https://..."
---
```

## Garden URL Pattern

All garden notes live at `/garden/<slug>/`. The slug is the filename without `.md`.

## PKM Scripts

| Script | Purpose |
|--------|---------|
| `scripts/pkm-to-garden-astro.sh` | Convert PKM files to `src/content/garden/` entries |
| `scripts/lint-pkm-astro.sh` | Lint PKM notes (validates against `src/content/garden/` and `src/content/posts/`) |

---

## Jekyll (Legacy)

<details>
<summary>Expand for legacy Jekyll workflow</summary>

The Jekyll scripts and paths are preserved for reference. They target `_garden/` and `_posts/` which no longer exist on the Astro branch.

### Scripts

| Script | Purpose |
|--------|---------|
| `scripts/pkm-to-garden.sh` | Convert PKM files to `_garden/` entries |
| `scripts/lint-pkm.sh` | Lint PKM notes (validates against `_garden/` and `_posts/`) |

### Convert PKM to Garden (Jekyll)

```bash
./scripts/pkm-to-garden.sh ~/workspace/brain/thoughts/thought-20260424-*.md
./scripts/pkm-to-garden.sh ~/workspace/brain/sources/source-some-reference.md
```

### Drafts (Jekyll)

Jekyll uses a `_drafts/` directory. Place draft posts in `_drafts/` (without date prefix). They won't appear in the built site until moved to `_posts/` with a date prefix.

</details>
