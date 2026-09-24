#!/usr/bin/env bash
#
# /transformation-intelligence/ disposition check.
#
# The page was reconstructed against the consolidated North Star on 24 Sep 2026
# (dta-internal/transformation-intelligence-claims-disposition.md). Every claim
# the disposition classified Retired or Superseded must be ABSENT from the BUILT
# page, and the reconstruction's distinctive strings must be PRESENT. Includes
# are expanded and {% seo %} has emitted the front matter, so the scan covers
# the title, description and every figure, not only the body copy.
#
# Two POSITIVE CONTROLS prove the retired strings still live on surfaces that
# were deliberately deferred (/observatory/ and the homepage). They are there so
# nobody widens this check into a site-wide clean-up by accident: those surfaces
# get their own disposition, not a grep. The first control was /platform/ until
# 25 Sep 2026, when /platform/ was migrated on purpose and the control did its
# job by forcing the question; it now points at the next deferred surface.
#
# Usage:
#   scripts/check-ti-disposition.sh          against _site/ (run `bundle exec jekyll build` first)
#   scripts/check-ti-disposition.sh --live   against the deployed site; nothing is written
#
# A review gate run by hand. Deliberately NOT wired into netlify.toml or the
# Pages workflow.
set -uo pipefail

SITE="${TI_SITE:-https://digital-transformation-advisory.com}"
fail=0
mode="_site"

if [ "${1:-}" = "--live" ]; then
  mode="live"
  page=$(curl -fsSL -H 'Cache-Control: no-cache' "$SITE/transformation-intelligence/") || { echo "cannot fetch $SITE/transformation-intelligence/"; exit 1; }
  observatory=$(curl -fsSL -H 'Cache-Control: no-cache' "$SITE/observatory/") || { echo "cannot fetch $SITE/observatory/"; exit 1; }
  home=$(curl -fsSL -H 'Cache-Control: no-cache' "$SITE/") || { echo "cannot fetch $SITE/"; exit 1; }
else
  for f in _site/transformation-intelligence/index.html _site/observatory/index.html _site/index.html; do
    [ -f "$f" ] || { echo "missing $f (run: bundle exec jekyll build)"; exit 1; }
  done
  page=$(cat _site/transformation-intelligence/index.html)
  observatory=$(cat _site/observatory/index.html)
  home=$(cat _site/index.html)
fi

if [ "$mode" = "_site" ]; then
  . "$(dirname "$0")/lib/require-fresh-build.sh" && require_fresh_build
fi

echo "Checking /transformation-intelligence/ ($mode)…"

# --- helpers -----------------------------------------------------------------
has_i()    { printf '%s' "$1" | grep -Fqi -- "$2"; }   # case-insensitive fixed string
has()      { printf '%s' "$1" | grep -Fq  -- "$2"; }   # case-sensitive fixed string
has_word() { printf '%s' "$1" | grep -Eq  -- "(^|[^A-Za-z])$2([^A-Za-z]|\$)"; }

absent_i() { if has_i "$page" "$1"; then echo "  RETIRED string present: \"$1\""; fail=1; fi; }
absent_w() { if has_word "$page" "$1"; then echo "  forbidden word present: $1"; fail=1; fi; }
present()  { if ! has "$page" "$1"; then echo "  missing (case-sensitive): \"$1\""; fail=1; fi; }
present_i(){ if ! has_i "$page" "$1"; then echo "  missing: \"$1\""; fail=1; fi; }

# --- 1. Retired and Superseded claims: absent ---------------------------------
retired=(
  "Shared Trust Ledger"
  "Trust Ledger"
  "institutional memory"
  "organisational memory"
  "Eight lenses"
  "Eight Intelligences"
  "MTDR is how you record it"
  "MTDR is the open standard for its entries"
  "The graph is simply how we implement the ledger"
  "Transformation Intelligence Platform"
  "Confluence"
  "constitutional"
  "what can defensibly be established"
  "Bring a decision to reconstruct"
  "27 jobs"
  "21 performed"
  "9 with an accountability"
  "5 propositions"
  "4 authorities"
  "6 principals"
)
for s in "${retired[@]}"; do absent_i "$s"; done
for w in OAR OIR MCP; do absent_w "$w"; done
EMDASH=$'\xe2\x80\x94'
if has "$page" "$EMDASH"; then echo "  em-dash present (voice-lint hard fail)"; fail=1; fi

# --- 2. The reconstruction's distinctive strings: present ---------------------
distinctive=(
  "Most organisations cannot see themselves"
  "Intelligent Transformation"
  "institutional latency"
  ">Records<"
  ">Projections<"
  ">Reconstructions<"
  "What should hold instead"
  "Know Yourself"
  "See Yourself"
  "Question Yourself"
)
for s in "${distinctive[@]}"; do present "$s"; done
present_i "the participant is a selection"

# --- 3. The triad figure, scoped: one figure, three rows ----------------------
triad_tag=$(printf '%s' "$page" | grep -o '<[^>]*data-check="triad"[^>]*>' | head -1)
if [ -z "$triad_tag" ]; then
  echo "  triad figure (data-check=\"triad\") not found"; fail=1
else
  for n in Records Projections Reconstructions; do
    printf '%s' "$triad_tag" | grep -Fq "$n" || { echo "  triad aria-label lacks $n"; fail=1; }
  done
fi
rows=$(printf '%s' "$page" | grep -o 'data-triad="[a-z]*"' | sort -u | wc -l | tr -d ' ')
[ "$rows" = "3" ] || { echo "  expected 3 distinct data-triad rows, found $rows"; fail=1; }

# --- 4. The Accountable Bank card, scoped: the nav and footer also link
#        /platform/, so only THIS anchor is checked --------------------------
cards=$(printf '%s' "$page" | grep -o '<a[^>]*data-check="accountable-bank"[^>]*>')
n=$(printf '%s' "$cards" | grep -c '<a' | tr -d ' ')
if [ "$n" != "1" ]; then
  echo "  expected exactly one Accountable Bank card anchor, found $n"; fail=1
else
  printf '%s' "$cards" | grep -Eq 'href="[^"]*/composable-bank/' || { echo "  Accountable Bank card does not link /composable-bank/"; fail=1; }
  if printf '%s' "$cards" | grep -Fq '/platform/'; then echo "  Accountable Bank card links /platform/"; fail=1; fi
fi

# --- 5. Positive controls: the deferred surfaces still carry the old words ----
has   "$observatory" "Eight Intelligences" || { echo "  POSITIVE CONTROL FAILED: /observatory/ no longer says \"Eight Intelligences\" (that surface has its own disposition)"; fail=1; }
has   "$home"     "Eight ways in" || { echo "  POSITIVE CONTROL FAILED: / no longer says \"Eight ways in\" (that surface has its own disposition)"; fail=1; }

# --- 6. Link targets ----------------------------------------------------------
if [ "$mode" = "live" ]; then
  for p in /composable-bank/ /decision-records/ /connect/; do
    curl -fsI "$SITE$p" >/dev/null || { echo "  link target unreachable: $p"; fail=1; }
  done
else
  for p in composable-bank decision-records connect; do
    [ -f "_site/$p/index.html" ] || { echo "  link target missing in _site: /$p/"; fail=1; }
  done
fi

# --- 7. Review-only reports (never fail) ---------------------------------------
body=$(printf '%s' "$page" | perl -0pe 's/<nav class="navbar".*?<\/nav>//s; s/<footer class="site-footer".*?<\/footer>//s')
c=$(printf '%s' "$body" | grep -c 'href="[^"]*/platform/"' | tr -d ' ')
[ "$c" != "0" ] && echo "  review: $c href to /platform/ outside nav and footer"
c=$(printf '%s' "$body" | grep -o -i '\breconstruct' | wc -l | tr -d ' ')
[ "$c" != "0" ] && echo "  review: \"reconstruct\" appears $c times; every use must be the ruled sense (what should hold instead)"
if has_word "$body" "[Ee]ight"; then echo "  review: a bare \"eight\" appears in the body"; fi

if [ "$fail" -ne 0 ]; then
  echo ""
  echo "Disposition check FAILED ($mode)."
  exit 1
fi
echo "Disposition check passed ($mode)."
