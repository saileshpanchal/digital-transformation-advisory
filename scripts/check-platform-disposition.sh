#!/usr/bin/env bash
#
# /platform/ disposition check.
#
# The page was reconstructed on 25 Sep 2026 as the junction into the proof
# (dta-internal/dta-platform-page-claims-disposition.md). Every claim the
# disposition classified Retired or Superseded must be ABSENT from the BUILT
# page (includes expanded, front matter emitted by seo), and the reconstruction's
# distinctive strings must be PRESENT. The three entrances into the Accountable
# Bank and the hero's two CTAs are checked by scoped data-check attributes,
# because the site chrome legitimately links elsewhere.
#
# Two POSITIVE CONTROLS prove retired vocabulary still lives on surfaces that
# were deliberately deferred (/observatory/ and the homepage), so nobody widens
# this check into a site-wide clean-up by accident.
#
# Usage:
#   scripts/check-platform-disposition.sh          against _site/ (run `bundle exec jekyll build` first)
#   scripts/check-platform-disposition.sh --live   against the deployed site; nothing is written
#
# A review gate run by hand. Deliberately NOT wired into netlify.toml or the
# Pages workflow.
set -uo pipefail

SITE="${TI_SITE:-https://digital-transformation-advisory.com}"
fail=0
mode="_site"

if [ "${1:-}" = "--live" ]; then
  mode="live"
  page=$(curl -fsSL -H 'Cache-Control: no-cache' "$SITE/platform/") || { echo "cannot fetch $SITE/platform/"; exit 1; }
  observatory=$(curl -fsSL -H 'Cache-Control: no-cache' "$SITE/observatory/") || { echo "cannot fetch $SITE/observatory/"; exit 1; }
  home=$(curl -fsSL -H 'Cache-Control: no-cache' "$SITE/") || { echo "cannot fetch $SITE/"; exit 1; }
else
  for f in _site/platform/index.html _site/observatory/index.html _site/index.html; do
    [ -f "$f" ] || { echo "missing $f (run: bundle exec jekyll build)"; exit 1; }
  done
  page=$(cat _site/platform/index.html)
  observatory=$(cat _site/observatory/index.html)
  home=$(cat _site/index.html)
fi

echo "Checking /platform/ ($mode)…"

has_i()    { printf '%s' "$1" | grep -Fqi -- "$2"; }
has()      { printf '%s' "$1" | grep -Fq  -- "$2"; }
has_word() { printf '%s' "$1" | grep -Eq  -- "(^|[^A-Za-z])$2([^A-Za-z]|\$)"; }
absent_i() { if has_i "$page" "$1"; then echo "  RETIRED string present: \"$1\""; fail=1; fi; }
absent_w() { if has_word "$page" "$1"; then echo "  forbidden word present: $1"; fail=1; fi; }
present()  { if ! has "$page" "$1"; then echo "  missing (case-sensitive): \"$1\""; fail=1; fi; }

# --- 1. Retired and Superseded claims: absent ---------------------------------
retired=(
  "Shared Trust Ledger"
  "Trust Ledger"
  "governed memory"
  "same reality"
  "works from governed knowledge"
  "Decisioning Loop"
  "Journeys, each a projection"
  "Repositioning DTA"
  "family-wealth-model"
  "every intelligence"
  "designed, not yet built"
  "added as the graph grows"
  "Transformation Intelligence Platform"
  "constitutional"
  "not yet applicable"
)
for s in "${retired[@]}"; do absent_i "$s"; done
for w in OAR OIR MCP; do absent_w "$w"; done
EMDASH=$'\xe2\x80\x94'
if has "$page" "$EMDASH"; then echo "  em-dash present (voice-lint hard fail)"; fail=1; fi

# --- 2. The reconstruction's distinctive strings: present ---------------------
distinctive=(
  "See where the organisation's work converges"
  "Not another system of record"
  "Shared work"
  "One organisation. Different questions."
  "One model. Many questions."
  "What should hold instead"
  "Build the bank"
  "Change the bank"
  "Inspect the bank"
  "cannot establish"
  "dg-arrow-chain"
)
for s in "${distinctive[@]}"; do present "$s"; done

# --- 3. Scoped anchors: the three entrances and the two hero CTAs -------------
check_anchor() {   # $1 data-check value, $2 required href fragment, $3 forbidden href fragment
  local tags n
  tags=$(printf '%s' "$page" | grep -o "<a[^>]*data-check=\"$1\"[^>]*>")
  n=$(printf '%s' "$tags" | grep -c '<a' | tr -d ' ')
  if [ "$n" != "1" ]; then echo "  expected exactly one anchor data-check=\"$1\", found $n"; fail=1; return; fi
  printf '%s' "$tags" | grep -Eq "href=\"[^\"]*$2" || { echo "  anchor $1 does not link $2"; fail=1; }
  if [ -n "$3" ] && printf '%s' "$tags" | grep -Fq "$3"; then echo "  anchor $1 links $3"; fail=1; fi
}
check_anchor "bank-build"   "/composable-bank/" "/platform/"
check_anchor "bank-change"  "/composable-bank/change/" "/platform/"
check_anchor "bank-inspect" "/composable-bank/platform/" "/platform/dta"
check_anchor "cta-bank"     "/composable-bank/" "/platform/"
check_anchor "cta-ti"       "/transformation-intelligence/" ""

# --- 4. Positive controls: the deferred surfaces still carry the old words ----
has "$observatory" "Eight Intelligences" || { echo "  POSITIVE CONTROL FAILED: /observatory/ no longer says \"Eight Intelligences\" (that surface has its own disposition)"; fail=1; }
has "$home"        "Eight ways in"       || { echo "  POSITIVE CONTROL FAILED: / no longer says \"Eight ways in\" (that surface has its own disposition)"; fail=1; }

# --- 5. Link targets ----------------------------------------------------------
targets="/composable-bank/ /composable-bank/change/ /composable-bank/platform/ /transformation-intelligence/ /observatory/ /solutions/architecture/ /solutions/value/ /solutions/capability/ /solutions/accountability/ /connect/"
if [ "$mode" = "live" ]; then
  for p in $targets; do curl -fsI "$SITE$p" >/dev/null || { echo "  link target unreachable: $p"; fail=1; }; done
else
  for p in $targets; do [ -f "_site${p}index.html" ] || { echo "  link target missing in _site: $p"; fail=1; }; done
fi

# --- 6. Review-only reports -----------------------------------------------------
body=$(printf '%s' "$page" | perl -0pe 's/<nav class="navbar".*?<\/nav>//s; s/<footer class="site-footer".*?<\/footer>//s')
c=$(printf '%s' "$body" | grep -o -i '\breconstruct' | wc -l | tr -d ' ')
[ "$c" != "0" ] && echo "  review: \"reconstruct\" appears $c times; every use must be the ruled sense (what should hold instead)"
if has_word "$body" "[Ee]ight"; then echo "  review: a bare \"eight\" appears in the body"; fi

if [ "$fail" -ne 0 ]; then echo ""; echo "Disposition check FAILED ($mode)."; exit 1; fi
echo "Disposition check passed ($mode)."
