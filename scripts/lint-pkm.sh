#!/usr/bin/env bash
# lint-pkm.sh — Validate PKM notes for completeness
#
# Checks:
#   1. Wikilink completeness (orphan + cross-reference)
#   2. Missing wikilink detection (advisory)
#   3. published_in validation against garden files
#   4. connects_to format / dangling reference check
#   5. published_in entries point to actual published posts
#
# Exit 0 if no errors (warnings OK), exit 1 if any errors.

set -euo pipefail

# ── Defaults ──────────────────────────────────────────────────────────────────
NOTES_DIR="brain/notes"
GARDEN_DIR=""
FILES=()
SHOW_HELP=0

# ── Usage ─────────────────────────────────────────────────────────────────────
usage() {
    cat <<'EOF'
Usage: lint-pkm.sh [OPTIONS] [FILE ...]

Lint PKM notes for completeness. When no files are given, lints every
note matching brain/notes/note-*.md.

Options:
  --garden-dir DIR   Path to the digital-garden directory
                     (auto-detected if omitted)
  --help             Show this help and exit

Examples:
  ./brain/scripts/lint-pkm.sh
  ./brain/scripts/lint-pkm.sh brain/notes/note-20260424-confabulation-is-plausible.md
  ./brain/scripts/lint-pkm.sh --garden-dir ~/workspace/srikanthsastry.github.io/_garden/
EOF
    exit 0
}

# ── Parse args ────────────────────────────────────────────────────────────────
while [[ $# -gt 0 ]]; do
    case "$1" in
        --garden-dir)
            GARDEN_DIR="$2"; shift 2 ;;
        --help|-h)
            usage ;;
        *)
            FILES+=("$1"); shift ;;
    esac
done

# ── Resolve workspace root ───────────────────────────────────────────────────
# The script can be invoked from anywhere; anchor relative paths to the
# directory that contains brain/.
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
# brain/scripts → go up two levels to workspace root
WORKSPACE_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
cd "$WORKSPACE_ROOT"

# ── Auto-detect garden dir ────────────────────────────────────────────────────
if [[ -z "$GARDEN_DIR" ]]; then
    for candidate in \
        "$WORKSPACE_ROOT/srikanthsastry.github.io/_garden" \
        "$HOME/workspace/srikanthsastry.github.io/_garden" \
        "$WORKSPACE_ROOT/brain/../srikanthsastry.github.io/_garden"; do
        if [[ -d "$candidate" ]]; then
            GARDEN_DIR="$candidate"
            break
        fi
    done
fi

# ── Auto-detect posts dir (for published_in validation) ──────────────────────
POSTS_DIR=""
if [[ -n "$GARDEN_DIR" ]]; then
    candidate="$(cd "$(dirname "$GARDEN_DIR")" && pwd)/_posts"
    if [[ -d "$candidate" ]]; then
        POSTS_DIR="$candidate"
    fi
fi

# ── Collect target files ─────────────────────────────────────────────────────
if [[ ${#FILES[@]} -eq 0 ]]; then
    mapfile -t FILES < <(find "$NOTES_DIR" -maxdepth 1 -name 'note-*.md' -type f | sort)
fi

if [[ ${#FILES[@]} -eq 0 ]]; then
    echo "No PKM notes found to lint."
    exit 0
fi

# ── Helper functions ──────────────────────────────────────────────────────────

# Extract a single-line frontmatter value
get_fm() {
    local file="$1" key="$2"
    sed -n '/^---$/,/^---$/p' "$file" | grep -m1 "^${key}:" | sed "s/^${key}:[[:space:]]*//" || true
}

# Extract a multi-line YAML list (returns one item per line, stripped)
get_fm_list() {
    local file="$1" key="$2"
    sed -n '/^---$/,/^---$/p' "$file" | awk -v key="$key:" '
        $0 ~ "^"key {found=1; next}
        found && /^[[:space:]]*- / {gsub(/^[[:space:]]*- /, ""); print; next}
        found && /^[a-zA-Z]/ {exit}
    '
}

# Extract body text (everything after the second ---)
get_body() {
    local file="$1"
    awk 'BEGIN{n=0} /^---$/{n++; if(n==2){found=1; next}} found{print}' "$file"
}

# note-20260424-directive-gap.md → directive-gap
make_slug() {
    local basename="$1"
    local slug="${basename%.md}"
    # Strip prefixes: note- / thought- / source- / src-
    slug=$(echo "$slug" | sed -E 's/^(thought|note|source|src)-//')
    # Strip date prefixes: YYYYMMDD- or YYYY-MM-DD-
    slug=$(echo "$slug" | sed -E 's/^[0-9]{8}-//' | sed -E 's/^[0-9]{4}-[0-9]{2}-[0-9]{2}-//')
    echo "$slug"
}

# ── Build slug index ──────────────────────────────────────────────────────────
# Map: slug → full filename (relative path)
declare -A SLUG_TO_FILE
declare -A ALL_SLUGS   # just for quick existence check
mapfile -t ALL_NOTE_FILES < <(find "$NOTES_DIR" -maxdepth 1 -name 'note-*.md' -type f | sort)

for f in "${ALL_NOTE_FILES[@]}"; do
    bname="$(basename "$f")"
    s="$(make_slug "$bname")"
    SLUG_TO_FILE["$s"]="$f"
    ALL_SLUGS["$s"]=1
done

# ── Accumulators ──────────────────────────────────────────────────────────────
declare -A FILE_ERRORS   # file → newline-separated error strings
declare -A FILE_WARNINGS # file → newline-separated warning strings
TOTAL_ERRORS=0
TOTAL_WARNINGS=0

add_error() {
    local file="$1" msg="$2"
    if [[ -n "${FILE_ERRORS[$file]+x}" ]]; then
        FILE_ERRORS["$file"]+=$'\n'"$msg"
    else
        FILE_ERRORS["$file"]="$msg"
    fi
    (( TOTAL_ERRORS++ )) || true
}

add_warning() {
    local file="$1" msg="$2"
    if [[ -n "${FILE_WARNINGS[$file]+x}" ]]; then
        FILE_WARNINGS["$file"]+=$'\n'"$msg"
    else
        FILE_WARNINGS["$file"]="$msg"
    fi
    (( TOTAL_WARNINGS++ )) || true
}

# ── Lint each file ────────────────────────────────────────────────────────────
for filepath in "${FILES[@]}"; do
    if [[ ! -f "$filepath" ]]; then
        add_error "$filepath" "[FILE_NOT_FOUND] $filepath does not exist"
        continue
    fi

    bname="$(basename "$filepath")"
    my_slug="$(make_slug "$bname")"
    body="$(get_body "$filepath")"

    # ── Gather frontmatter lists ──────────────────────────────────────────
    mapfile -t connects_to_raw < <(get_fm_list "$filepath" "connects_to")
    mapfile -t related_raw    < <(get_fm_list "$filepath" "related")
    mapfile -t published_in_raw < <(get_fm_list "$filepath" "published_in")

    # Build sets of slugs referenced in connects_to and related
    declare -A ct_slugs=()
    declare -A ct_paths=()
    for entry in "${connects_to_raw[@]}"; do
        [[ -z "$entry" ]] && continue
        ct_paths["$entry"]=1
        # Extract slug from path like brain/notes/note-20260424-directive-gap.md
        entry_bname="$(basename "$entry")"
        entry_slug="$(make_slug "$entry_bname")"
        ct_slugs["$entry_slug"]=1
    done

    declare -A rel_slugs=()
    for entry in "${related_raw[@]}"; do
        [[ -z "$entry" ]] && continue
        entry_bname="$(basename "$entry")"
        entry_slug="$(make_slug "$entry_bname")"
        rel_slugs["$entry_slug"]=1
    done

    # ── Check 1: Wikilink completeness ────────────────────────────────────
    # Extract all wikilinks from body: [[slug]] or [[slug|display text]]
    mapfile -t wikilinks < <(echo "$body" | grep -oP '\[\[([^\]|]+)' | sed 's/^\[\[//' | sort -u)

    for wl_slug in "${wikilinks[@]}"; do
        [[ -z "$wl_slug" ]] && continue
        # Trim whitespace
        wl_slug="$(echo "$wl_slug" | xargs)"

        # Orphan check: does a note with this slug exist?
        if [[ -z "${ALL_SLUGS[$wl_slug]+x}" ]]; then
            add_error "$bname" "[ORPHAN_WIKILINK] [[$wl_slug]] references no existing note"
        fi

        # Cross-reference check: is this slug in connects_to or related?
        if [[ -z "${ct_slugs[$wl_slug]+x}" ]] && [[ -z "${rel_slugs[$wl_slug]+x}" ]]; then
            add_error "$bname" "[MISSING_CONNECTS_TO] [[$wl_slug]] in body but not in connects_to or related"
        fi
    done

    # ── Check 4: connects_to dangling references ──────────────────────────
    for ct_path in "${connects_to_raw[@]}"; do
        [[ -z "$ct_path" ]] && continue
        if [[ ! -f "$ct_path" ]]; then
            add_error "$bname" "[DANGLING_CONNECTS_TO] connects_to entry '$ct_path' does not exist"
        fi
    done

    # ── Check 3: published_in validation ──────────────────────────────────
    if [[ -n "$GARDEN_DIR" ]]; then
        garden_file="$GARDEN_DIR/${my_slug}.md"
        if [[ -f "$garden_file" ]]; then
            # Garden file exists — PKM should have published_in
            # Extract related_posts from garden file
            mapfile -t garden_related_posts < <(get_fm_list "$garden_file" "related_posts")

            if [[ ${#garden_related_posts[@]} -gt 0 ]] && [[ -n "${garden_related_posts[0]}" ]]; then
                # Garden has related_posts — check published_in
                if [[ ${#published_in_raw[@]} -eq 0 ]] || [[ -z "${published_in_raw[0]}" ]]; then
                    # Build a readable list of related_posts
                    rp_display=""
                    for rp in "${garden_related_posts[@]}"; do
                        [[ -z "$rp" ]] && continue
                        if [[ -n "$rp_display" ]]; then
                            rp_display+=", $rp"
                        else
                            rp_display="$rp"
                        fi
                    done
                    add_error "$bname" "[MISSING_PUBLISHED_IN] garden file exists with related_posts [$rp_display] but no published_in in PKM"
                else
                    # Both exist — check for mismatches
                    declare -A pi_set=()
                    for pi in "${published_in_raw[@]}"; do
                        [[ -z "$pi" ]] && continue
                        pi_set["$pi"]=1
                    done
                    for rp in "${garden_related_posts[@]}"; do
                        [[ -z "$rp" ]] && continue
                        if [[ -z "${pi_set[$rp]+x}" ]]; then
                            add_error "$bname" "[PUBLISHED_IN_MISMATCH] garden related_posts has '$rp' but PKM published_in does not"
                        fi
                    done
                    unset pi_set
                fi
            elif [[ ${#published_in_raw[@]} -eq 0 ]] || [[ -z "${published_in_raw[0]}" ]]; then
                # Garden exists but no related_posts — still flag missing published_in
                add_error "$bname" "[MISSING_PUBLISHED_IN] garden file exists at ${garden_file} but no published_in in PKM"
            fi
        fi
    fi

    # ── Check 5: published_in entries point to actual published posts ─────
    if [[ -n "$POSTS_DIR" ]] && [[ ${#published_in_raw[@]} -gt 0 ]]; then
        for pi in "${published_in_raw[@]}"; do
            [[ -z "$pi" ]] && continue
            # Strip leading/trailing slashes to get the slug
            # Check if any post in _posts/ has this permalink in its frontmatter
            if ! grep -rl "^permalink: ${pi}$" "$POSTS_DIR/" >/dev/null 2>&1; then
                add_error "$bname" "[UNPUBLISHED_IN_PUBLISHED_IN] published_in '$pi' has no matching post in _posts/"
            fi
        done
    fi

    # ── Check 2: Missing wikilink detection (advisory) ────────────────────
    # Convert body to lowercase for case-insensitive matching
    body_lower="$(echo "$body" | tr '[:upper:]' '[:lower:]')"

    for candidate_slug in "${!ALL_SLUGS[@]}"; do
        # Skip self
        [[ "$candidate_slug" == "$my_slug" ]] && continue

        # Skip if already wikilinked
        already_linked=0
        for wl in "${wikilinks[@]}"; do
            if [[ "$wl" == "$candidate_slug" ]]; then
                already_linked=1
                break
            fi
        done
        [[ "$already_linked" -eq 1 ]] && continue

        # Convert slug kebab-case to space-separated words
        phrase="$(echo "$candidate_slug" | tr '-' ' ')"

        # Only flag if the full phrase appears as a word-boundary match
        # Use grep -w for word boundaries, but multi-word phrases need \b
        if echo "$body_lower" | grep -qiP "\b\Q${phrase}\E\b" 2>/dev/null; then
            add_warning "$bname" "[POTENTIAL_WIKILINK] body mentions \"$phrase\" which matches note slug '$candidate_slug' but is not wikilinked"
        fi
    done

    # Clean up associative arrays for next iteration
    unset ct_slugs ct_paths rel_slugs
done

# ── Report ────────────────────────────────────────────────────────────────────
echo ""
echo "=== PKM Lint Report ==="
echo ""

if [[ $TOTAL_ERRORS -gt 0 ]]; then
    echo "ERRORS (must fix before garden sync):"
    for file in $(echo "${!FILE_ERRORS[@]}" | tr ' ' '\n' | sort); do
        echo "  $file:"
        while IFS= read -r line; do
            echo "    - $line"
        done <<< "${FILE_ERRORS[$file]}"
    done
    echo ""
fi

if [[ $TOTAL_WARNINGS -gt 0 ]]; then
    echo "WARNINGS (advisory):"
    for file in $(echo "${!FILE_WARNINGS[@]}" | tr ' ' '\n' | sort); do
        echo "  $file:"
        while IFS= read -r line; do
            echo "    - $line"
        done <<< "${FILE_WARNINGS[$file]}"
    done
    echo ""
fi

if [[ $TOTAL_ERRORS -eq 0 ]] && [[ $TOTAL_WARNINGS -eq 0 ]]; then
    echo "All clear — no issues found."
    echo ""
fi

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  Files checked: ${#FILES[@]}"
echo "  Errors: $TOTAL_ERRORS"
echo "  Warnings: $TOTAL_WARNINGS"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

if [[ $TOTAL_ERRORS -gt 0 ]]; then
    exit 1
else
    exit 0
fi
