#!/usr/bin/env bash
set -euo pipefail

# pkm-to-garden.sh — Convert PKM files to digital garden entries
#
# The garden is a pure derivation from PKM. This script never preserves
# or merges data from an existing garden file. Instead, when --force is
# used, a pre-sync guard compares the would-be output against the
# existing garden file and refuses to overwrite if any data would be lost.
#
# Usage:
#   ./scripts/pkm-to-garden.sh [--force] <pkm-file> [<pkm-file> ...]
#
# Examples:
#   ./scripts/pkm-to-garden.sh ~/workspace/brain/thoughts/thought-20260424-directive-gap.md
#   ./scripts/pkm-to-garden.sh --force ~/workspace/brain/sources/source-netflix-context-not-control.md
#   ./scripts/pkm-to-garden.sh ~/workspace/brain/thoughts/thought-20260424-*.md

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
GARDEN_DIR="$REPO_DIR/_garden"

FORCE=false
FILES=()

# Parse arguments
for arg in "$@"; do
    case "$arg" in
        --force) FORCE=true ;;
        --help|-h)
            echo "Usage: $0 [--force] <pkm-file> [<pkm-file> ...]"
            echo ""
            echo "Convert PKM files to digital garden entries in _garden/"
            echo ""
            echo "Options:"
            echo "  --force    Overwrite existing garden files (with safety guard)"
            echo "  --help     Show this help"
            echo ""
            echo "Examples:"
            echo "  $0 ~/workspace/brain/thoughts/thought-20260424-directive-gap.md"
            echo "  $0 --force ~/workspace/brain/sources/source-netflix-context-not-control.md"
            exit 0
            ;;
        *) FILES+=("$arg") ;;
    esac
done

if [ ${#FILES[@]} -eq 0 ]; then
    echo "Error: No input files provided."
    echo "Usage: $0 [--force] <pkm-file> [<pkm-file> ...]"
    exit 1
fi

mkdir -p "$GARDEN_DIR"

# ── Helper functions ──────────────────────────────────────────────

# Extract a YAML frontmatter value by key (first match, single-line values only)
# Handles both inline arrays [a, b] and plain strings
get_fm() {
    local file="$1" key="$2"
    sed -n '/^---$/,/^---$/p' "$file" | grep -m1 "^${key}:" | sed "s/^${key}:[[:space:]]*//" || true
}

# Extract multi-line YAML list values (for keys like connects_to, related with list items)
get_fm_list() {
    local file="$1" key="$2"
    sed -n '/^---$/,/^---$/p' "$file" | awk -v key="$key:" '
        $0 ~ "^"key {found=1; next}
        found && /^[[:space:]]*- / {gsub(/^[[:space:]]*- /, ""); print; next}
        found && /^[a-zA-Z]/ {exit}
    '
}

# Extract body (everything after the second --- line)
get_body() {
    local file="$1"
    awk 'BEGIN{n=0} /^---$/{n++; if(n==2){found=1; next}} found{print}' "$file"
}

# Detect PKM type from filename
detect_type() {
    local basename="$1"
    case "$basename" in
        thought-*) echo "thought" ;;
        note-*)    echo "note" ;;
        source-*)  echo "source" ;;
        src-*)     echo "source" ;;
        *)         echo "thought" ;;  # fallback
    esac
}

# Strip type prefix and date from filename to get the garden slug
# thought-20260424-directive-gap.md → directive-gap
# note-20260424-guardrail-erosion-synthesis.md → guardrail-erosion-synthesis
# source-netflix-context-not-control.md → netflix-context-not-control
# src-20260326-gifted-distractible.md → gifted-distractible
make_slug() {
    local basename="$1"
    local slug="${basename%.md}"
    # Strip type prefix
    slug=$(echo "$slug" | sed -E 's/^(thought|note|source|src)-//')
    # Strip date prefix (YYYYMMDD or YYYY-MM-DD)
    slug=$(echo "$slug" | sed -E 's/^[0-9]{8}-//' | sed -E 's/^[0-9]{4}-[0-9]{2}-[0-9]{2}-//')
    echo "$slug"
}

# Convert kebab-case to Title Case
kebab_to_title() {
    echo "$1" | sed 's/-/ /g' | awk '{for(i=1;i<=NF;i++){$i=toupper(substr($i,1,1)) tolower(substr($i,2))}}1'
}

# Derive maturity from PKM status and type
derive_maturity() {
    local pkm_type="$1" status="$2"
    # Sources default to evergreen
    if [ "$pkm_type" = "source" ]; then
        echo "evergreen"
        return
    fi
    case "$status" in
        evergreen|connected|stable) echo "evergreen" ;;
        budding|developing|draft)   echo "budding" ;;
        seedling|raw|"")            echo "seedling" ;;
        *)                          echo "seedling" ;;
    esac
}

# Parse inline YAML array [a, b, c] into newline-separated values
parse_inline_array() {
    local val="$1"
    # Strip brackets and quotes
    echo "$val" | sed 's/^\[//;s/\]$//;s/,/\n/g' | sed 's/^[[:space:]]*//;s/[[:space:]]*$//;s/^"//;s/"$//' | grep -v '^$'
}

# Convert a PKM reference path to a garden slug
# brain/thoughts/thought-20260424-foo.md → foo
# thoughts/thought-20260424-foo.md → foo
# published/actor-model-ai-coding → (skip, these go to related_posts)
# maps/guardrail-erosion → guardrail-erosion-map
ref_to_slug() {
    local ref="$1"
    # Strip brain/ prefix if present
    ref="${ref#brain/}"
    # Strip .md suffix if present
    ref="${ref%.md}"
    # Get the basename
    local base
    base=$(basename "$ref")
    local dir
    dir=$(dirname "$ref")

    # Skip published refs (those should be related_posts, handled separately)
    case "$dir" in
        published|*/published) echo "PUBLISHED:$base"; return ;;
    esac

    # Maps get a -map suffix
    local slug
    slug=$(make_slug "$base")
    case "$dir" in
        maps|*/maps) slug="${slug}-map" ;;
    esac

    echo "$slug"
}

# Extract first sentence from body for excerpt
first_sentence() {
    local body="$1"
    # Skip markdown headings and blank lines, get first real paragraph
    local line
    line=$(echo "$body" | grep -v '^#' | grep -v '^$' | head -1 || true)
    if [ -z "$line" ]; then
        echo ""
        return
    fi
    echo "$line" | \
        sed -E 's/\[([^]]*)\]\([^)]*\)/\1/g' | \
        sed -E 's/\*+([^*]*)\*+/\1/g' | \
        sed -E 's/`([^`]*)`/\1/g' | \
        awk '{
            # Find first sentence-ending punctuation
            match($0, /[.!?]/)
            if (RSTART > 0) {
                print substr($0, 1, RSTART)
            } else {
                print $0
            }
        }' | head -1
}

# Convert wikilinks to markdown links
# [[slug|display text]] → [display text](/garden/slug/)
# [[slug]]              → [slug](/garden/slug/)
convert_wikilinks() {
    local text="$1"
    # Normalize full-ID wikilinks: [[note-YYYYMMDD-slug]] → [[slug]]
    text=$(echo "$text" | sed -E 's/\[\[(note|thought|source|src)-[0-9]{8}-([^]|]+)\]\]/[[\2]]/g')
    # Also normalize full-ID with pipe: [[note-YYYYMMDD-slug|text]] → [[slug|text]]
    text=$(echo "$text" | sed -E 's/\[\[(note|thought|source|src)-[0-9]{8}-([^]|]+)\|([^]]+)\]\]/[[\2|\3]]/g')
    # Handle pipe syntax [[slug|display text]]
    text=$(echo "$text" | sed -E 's/\[\[([^]|]+)\|([^]]+)\]\]/[\2](\/garden\/\1\/)/g')
    # Handle plain [[slug]]
    text=$(echo "$text" | sed -E 's/\[\[([^]]+)\]\]/[\1](\/garden\/\1\/)/g')
    echo "$text"
}

# ── Main conversion loop ─────────────────────────────────────────

created_count=0
skipped_count=0
blocked_count=0
error_count=0

for pkm_file in "${FILES[@]}"; do
    if [ ! -f "$pkm_file" ]; then
        echo "⚠  File not found: $pkm_file"
        error_count=$((error_count + 1))
        continue
    fi

    basename=$(basename "$pkm_file")
    pkm_type=$(detect_type "$basename")
    slug=$(make_slug "$basename")
    garden_file="$GARDEN_DIR/${slug}.md"

    # Check for existing file
    if [ -f "$garden_file" ] && [ "$FORCE" = false ]; then
        echo "⏭  Skipping $slug (already exists in _garden/). Use --force to overwrite."
        skipped_count=$((skipped_count + 1))
        continue
    fi

    echo "🌱 Converting: $basename → _garden/${slug}.md"

    # ── Extract PKM frontmatter ──

    pkm_id=$(get_fm "$pkm_file" "id")
    pkm_title=$(get_fm "$pkm_file" "title" | sed 's/^"//;s/"$//')
    pkm_status=$(get_fm "$pkm_file" "status")
    pkm_tags=$(get_fm "$pkm_file" "tags")
    pkm_created=$(get_fm "$pkm_file" "created")
    pkm_date_added=$(get_fm "$pkm_file" "date_added")
    pkm_author=$(get_fm "$pkm_file" "author")
    pkm_year=$(get_fm "$pkm_file" "year")
    pkm_url=$(get_fm "$pkm_file" "url")

    # Collect cross-reference fields
    pkm_source=$(get_fm "$pkm_file" "source")
    pkm_inspired_by=$(get_fm "$pkm_file" "inspired_by")

    # ── Derive garden fields ──

    # Title: use PKM title, or derive from slug
    if [ -z "$pkm_title" ]; then
        title=$(kebab_to_title "$slug")
    else
        title="$pkm_title"
    fi

    # Maturity
    maturity=$(derive_maturity "$pkm_type" "$pkm_status")

    # Tags: parse inline array format [a, b, c]
    tags_line=""
    if [ -n "$pkm_tags" ]; then
        # Inline array format: tags: [a, b, c]
        tags_line="$pkm_tags"
    else
        # Multi-line list format: tags:\n  - a\n  - b
        ml_tags=()
        while IFS= read -r tag; do
            [ -z "$tag" ] && continue
            tag=$(echo "$tag" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')
            ml_tags+=("$tag")
        done < <(get_fm_list "$pkm_file" "tags")
        if [ ${#ml_tags[@]} -gt 0 ]; then
            tags_line="[$(printf '%s' "${ml_tags[0]}"; for t in "${ml_tags[@]:1}"; do printf ', %s' "$t"; done)]"
        fi
    fi

    # Created date: prefer 'created', fallback to 'date_added'
    created="${pkm_created:-$pkm_date_added}"

    # ── Collect related_notes and related_posts ──

    related_notes=()
    related_posts=()

    # 1. Read published_in from PKM → related_posts (permalink format)
    while IFS= read -r pi; do
        [ -z "$pi" ] && continue
        pi=$(echo "$pi" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')
        related_posts+=("$pi")
    done < <(get_fm_list "$pkm_file" "published_in")

    # 2. Process 'connects_to' (multi-line list)
    while IFS= read -r ref; do
        [ -z "$ref" ] && continue
        ref=$(echo "$ref" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')
        resolved=$(ref_to_slug "$ref")
        if [[ "$resolved" == PUBLISHED:* ]]; then
            # Skip: published_in is canonical source for related_posts
            continue
        else
            related_notes+=("$resolved")
        fi
    done < <(get_fm_list "$pkm_file" "connects_to")

    # 3. Process 'related' (inline array or multi-line list)
    pkm_related=$(get_fm "$pkm_file" "related")
    if [ -n "$pkm_related" ]; then
        if [[ "$pkm_related" == \[* ]]; then
            while IFS= read -r ref; do
                [ -z "$ref" ] && continue
                resolved=$(ref_to_slug "$ref")
                if [[ "$resolved" == PUBLISHED:* ]]; then
                    # Skip: published_in is canonical source for related_posts
            continue
                else
                    related_notes+=("$resolved")
                fi
            done < <(parse_inline_array "$pkm_related")
        fi
    fi
    # Also check multi-line related
    while IFS= read -r ref; do
        [ -z "$ref" ] && continue
        ref=$(echo "$ref" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')
        resolved=$(ref_to_slug "$ref")
        if [[ "$resolved" == PUBLISHED:* ]]; then
            # Skip: published_in is canonical source for related_posts
            continue
        else
            related_notes+=("$resolved")
        fi
    done < <(get_fm_list "$pkm_file" "related")

    # 4. Process 'source' (single value)
    if [ -n "$pkm_source" ]; then
        resolved=$(ref_to_slug "$pkm_source")
        if [[ "$resolved" == PUBLISHED:* ]]; then
            # Skip: published_in is canonical source for related_posts
            continue
        else
            related_notes+=("$resolved")
        fi
    fi

    # 5. Process 'inspired_by' (single value, inline array, or multi-line list)
    if [ -n "$pkm_inspired_by" ]; then
        if [[ "$pkm_inspired_by" == \[* ]]; then
            while IFS= read -r ref; do
                [ -z "$ref" ] && continue
                resolved=$(ref_to_slug "$ref")
                if [[ "$resolved" == PUBLISHED:* ]]; then
                    # Skip: published_in is canonical source for related_posts
            continue
                else
                    related_notes+=("$resolved")
                fi
            done < <(parse_inline_array "$pkm_inspired_by")
        else
            resolved=$(ref_to_slug "$pkm_inspired_by")
            if [[ "$resolved" == PUBLISHED:* ]]; then
                # Skip: published_in is canonical source for related_posts
            continue
            else
                related_notes+=("$resolved")
            fi
        fi
    fi
    # Also check multi-line inspired_by list
    while IFS= read -r ref; do
        [ -z "$ref" ] && continue
        ref=$(echo "$ref" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')
        resolved=$(ref_to_slug "$ref")
        if [[ "$resolved" == PUBLISHED:* ]]; then
            # Skip: published_in is canonical source for related_posts
            continue
        else
            related_notes+=("$resolved")
        fi
    done < <(get_fm_list "$pkm_file" "inspired_by")

    # ── Deduplicate related_notes ──

    if [ ${#related_notes[@]} -gt 0 ]; then
        mapfile -t related_notes < <(printf '%s\n' "${related_notes[@]}" | sort -u)
    fi

    # ── Validate related_notes: only keep slugs that exist in _garden/ ──

    validated_notes=()
    for rn in "${related_notes[@]}"; do
        if [ -f "$GARDEN_DIR/${rn}.md" ]; then
            validated_notes+=("$rn")
        else
            echo "   ⚠  Dropping related_note '$rn' (no garden file exists)"
        fi
    done
    related_notes=("${validated_notes[@]+"${validated_notes[@]}"}")

    # ── Deduplicate related_posts ──

    if [ ${#related_posts[@]} -gt 0 ]; then
        mapfile -t related_posts < <(printf '%s\n' "${related_posts[@]}" | sort -u)
    fi

    # ── Gate: garden notes require at least one linked post ──

    if [ ${#related_posts[@]} -eq 0 ]; then
        echo "⏭  Skipping $slug (no related_posts — garden notes require at least one linked post)"
        skipped_count=$((skipped_count + 1))
        continue
    fi

    # ── Extract and process body ──

    body=$(get_body "$pkm_file")
    # Convert wikilinks (including pipe syntax)
    body=$(convert_wikilinks "$body")

    # Extract excerpt (first sentence of body, stripped of markdown)
    excerpt=$(first_sentence "$body")

    # ── Pre-sync guard: refuse if --force would lose data ──

    if [ "$FORCE" = true ] && [ -f "$garden_file" ]; then
        losses=()

        # (a) Inline link loss: /garden/ links in existing body not present in would-be body
        existing_body=$(get_body "$garden_file")
        existing_inline_slugs=()
        while IFS= read -r link_slug; do
            [ -z "$link_slug" ] && continue
            existing_inline_slugs+=("$link_slug")
        done < <(echo "$existing_body" | grep -oE '\(/garden/[^)]+/\)' | sed -E 's|^\(/garden/||;s|/\)$||' | sort -u)

        missing_inline=()
        for es in "${existing_inline_slugs[@]+"${existing_inline_slugs[@]}"}"; do
            if ! echo "$body" | grep -qF "/garden/${es}/"; then
                missing_inline+=("$es")
            fi
        done

        # (b) related_notes loss
        existing_rnotes=()
        while IFS= read -r ern; do
            [ -z "$ern" ] && continue
            ern=$(echo "$ern" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')
            existing_rnotes+=("$ern")
        done < <(get_fm_list "$garden_file" "related_notes")

        missing_rnotes=()
        for ern in "${existing_rnotes[@]+"${existing_rnotes[@]}"}"; do
            found=false
            for rn in "${related_notes[@]+"${related_notes[@]}"}"; do
                if [ "$rn" = "$ern" ]; then
                    found=true
                    break
                fi
            done
            if [ "$found" = false ]; then
                missing_rnotes+=("$ern")
            fi
        done

        # (c) related_posts loss
        existing_rposts=()
        while IFS= read -r erp; do
            [ -z "$erp" ] && continue
            erp=$(echo "$erp" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')
            existing_rposts+=("$erp")
        done < <(get_fm_list "$garden_file" "related_posts")

        missing_rposts=()
        for erp in "${existing_rposts[@]+"${existing_rposts[@]}"}"; do
            found=false
            for rp in "${related_posts[@]+"${related_posts[@]}"}"; do
                if [ "$rp" = "$erp" ]; then
                    found=true
                    break
                fi
            done
            if [ "$found" = false ]; then
                missing_rposts+=("$erp")
            fi
        done

        # Report losses and block if any
        has_loss=false

        if [ ${#missing_inline[@]} -gt 0 ]; then
            has_loss=true
        fi
        if [ ${#missing_rnotes[@]} -gt 0 ]; then
            has_loss=true
        fi
        if [ ${#missing_rposts[@]} -gt 0 ]; then
            has_loss=true
        fi

        if [ "$has_loss" = true ]; then
            echo "🛑 $slug: would lose data on --force"
            if [ ${#missing_inline[@]} -gt 0 ]; then
                inline_display=""
                for mi in "${missing_inline[@]}"; do
                    [ -n "$inline_display" ] && inline_display+=", "
                    inline_display+="[[$mi]]"
                done
                echo "   Missing inline links in PKM body: $inline_display"
            fi
            if [ ${#missing_rnotes[@]} -gt 0 ]; then
                rnotes_display=""
                for mr in "${missing_rnotes[@]}"; do
                    [ -n "$rnotes_display" ] && rnotes_display+=", "
                    rnotes_display+="$mr"
                done
                echo "   Missing connects_to in PKM: $rnotes_display"
            fi
            if [ ${#missing_rposts[@]} -gt 0 ]; then
                rposts_display=""
                for mp in "${missing_rposts[@]}"; do
                    [ -n "$rposts_display" ] && rposts_display+=", "
                    rposts_display+="$mp"
                done
                echo "   Missing published_in in PKM: $rposts_display"
            fi
            echo "   Fix the PKM note first, then re-run."
            blocked_count=$((blocked_count + 1))
            continue
        fi
    fi

    # ── Write garden file ──

    {
        echo "---"
        echo "title: \"$title\""
        echo "garden_type: $pkm_type"
        echo "maturity: $maturity"
        if [ -n "$tags_line" ]; then
            echo "tags: $tags_line"
        fi
        if [ -n "$created" ]; then
            echo "created: $created"
        fi

        # Related posts
        echo "related_posts:"
        for rp in "${related_posts[@]}"; do
            echo "  - $rp"
        done

        # Related notes
        if [ ${#related_notes[@]} -gt 0 ]; then
            echo "related_notes:"
            for rn in "${related_notes[@]}"; do
                echo "  - $rn"
            done
        else
            echo "related_notes: []"
        fi

        # Source-specific fields
        if [ "$pkm_type" = "source" ]; then
            [ -n "$pkm_author" ] && echo "source_author: \"$pkm_author\""
            [ -n "$pkm_year" ] && echo "source_year: $pkm_year"
            [ -n "$pkm_url" ] && echo "source_url: \"$pkm_url\""
        fi

        # Excerpt
        if [ -n "$excerpt" ]; then
            echo "excerpt_text: >"
            echo "  $excerpt"
        fi

        echo "---"
        echo "$body"
    } > "$garden_file"

    echo "   ✅ Created _garden/${slug}.md (${maturity})"
    created_count=$((created_count + 1))
done

# ── Summary ──

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  Created: $created_count"
echo "  Blocked: $blocked_count"
echo "  Skipped: $skipped_count"
echo "  Errors:  $error_count"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
if [ $created_count -gt 0 ]; then
    echo "Next steps:"
    echo "  1. Review generated files in _garden/"
    echo "  2. Adjust titles, maturity levels, and excerpt_text"
    echo "  3. Add published_in permalinks to PKM notes for related_posts"
    echo "  4. Add related_notes slugs for connected garden entries"
    echo "  5. Add inline wikilinks in PKM body for garden cross-references"
fi
