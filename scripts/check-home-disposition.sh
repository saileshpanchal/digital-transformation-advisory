#!/usr/bin/env bash
#
# Homepage disposition check.
#
# The homepage was rebuilt on 25 Sep 2026 to lead with the change in the world
# rather than with what DTA built (dta-internal/home-claims-disposition.md):
# change -> consequence -> proposition -> proof -> how we help -> Transformation
# Intelligence -> close. Every Retired or Superseded string must be ABSENT from
# the BUILT page; the seven moves' distinctive strings must be PRESENT; the
# anchors that carry the argument into the Accountable Bank and the TI page are
# checked by scoped data attributes.
#
# Two POSITIVE CONTROLS prove retired vocabulary still lives on surfaces that
# were deliberately deferred (/observatory/ and /approach/), so nobody widens
# this check into a site-wide clean-up by accident. The homepage itself was the
# second control for the other two checks until this rebuild; that control was
# moved on purpose, as /platform/'s was.
#
# Usage:
#   scripts/build-site.sh && scripts/check-home-disposition.sh
#   scripts/check-home-disposition.sh --live          against the deployed site
set -uo pipefail
cd "$(git rev-parse --show-toplevel)"

SITE="${TI_SITE:-https://digital-transformation-advisory.com}"
fail=0
mode="_site"

if [ "${1:-}" = "--live" ]; then
  mode="live"
  page=$(curl -fsSL -H 'Cache-Control: no-cache' "$SITE/") || { echo "cannot fetch $SITE/"; exit 1; }
  observatory=$(curl -fsSL -H 'Cache-Control: no-cache' "$SITE/observatory/") || { echo "cannot fetch $SITE/observatory/"; exit 1; }
  approach=$(curl -fsSL -H 'Cache-Control: no-cache' "$SITE/approach/") || { echo "cannot fetch $SITE/approach/"; exit 1; }
else
  for f in _site/index.html _site/observatory/index.html _site/approach/index.html; do
    [ -f "$f" ] || { echo "missing $f (run: scripts/build-site.sh)"; exit 1; }
  done
  page=$(cat _site/index.html)
  observatory=$(cat _site/observatory/index.html)
  approach=$(cat _site/approach/index.html)
  . scripts/lib/require-fresh-build.sh && require_fresh_build
fi

echo "Checking / ($mode)…"

has_i()    { printf '%s' "$1" | grep -Fqi -- "$2"; }
has()      { printf '%s' "$1" | grep -Fq  -- "$2"; }
absent_i() { if has_i "$page" "$1"; then echo "  RETIRED string present: \"$1\""; fail=1; fi; }
present()  { if ! has "$page" "$1"; then echo "  missing (case-sensitive): \"$1\""; fail=1; fi; }

# --- 1. Retired and Superseded strings: absent -----------------------------------
retired=(
  "Eight ways in"
  "See the eight"
  "Start anywhere"
  "AI-first"
  "transformation measurable"
  "See and coordinate change"
  "Board-ready proof, not a deck"
  "see, decide and move"
  "idea behind the platform"
  "pound of capital"
  "deciding faster than you can evidence"
  "Five pressures"
  "Trust Ledger"
  "Transformation Intelligence Platform"
  "Know yourself. Question yourself. Change yourself."
  "should not care"
)
for s in "${retired[@]}"; do absent_i "$s"; done
EMDASH=$'\xe2\x80\x94'
if has "$page" "$EMDASH"; then echo "  em-dash present (voice-lint hard fail)"; fail=1; fi

# --- 2. The seven moves' distinctive strings: present -------------------------------
distinctive=(
  "Execution is getting faster. Organisations aren't."
  "Move the bank forward without betting it"
  "fixing AI rather than redesigning the organisation"
  "designed for human-speed organisations"
  "Design it around the work"
  "The job should not depend on"
  "Ask the organisation"
  "Start where it hurts"
  "One organisation. Many questions."
  "Records · Projections · Reconstructions"
  "Know your organisation. Question it. Change it with evidence."
  "executable model of the organisation"
  "dg-arrow-job"
)
for s in "${distinctive[@]}"; do present "$s"; done

# --- 3. Scoped anchors ------------------------------------------------------------------
check_anchor() {   # $1 data-check value, $2 required href fragment
  local tags n
  tags=$(printf '%s' "$page" | grep -o "<a[^>]*data-check=\"$1\"[^>]*>")
  n=$(printf '%s' "$tags" | grep -c '<a' | tr -d ' ')
  if [ "$n" != "1" ]; then echo "  expected exactly one anchor data-check=\"$1\", found $n"; fail=1; return; fi
  printf '%s' "$tags" | grep -Eq "href=\"[^\"]*$2" || { echo "  anchor $1 does not link $2"; fail=1; }
}
check_anchor "home-bank-hero" "/composable-bank/"
check_anchor "home-bank"      "/composable-bank/"
check_anchor "home-ti"        "/transformation-intelligence/"
asks=$(printf '%s' "$page" | grep -o '<a[^>]*data-ask="[^"]*"[^>]*>')
n=$(printf '%s' "$asks" | grep -c '<a' | tr -d ' ')
[ "$n" = "7" ] || { echo "  expected seven Ask-the-organisation anchors, found $n"; fail=1; }
bad=$(printf '%s' "$asks" | grep -v 'href="[^"]*/composable-bank/' | grep -c '<a' | tr -d ' ')
[ "$bad" = "0" ] || { echo "  $bad Ask-the-organisation anchor(s) do not link into /composable-bank/"; fail=1; }
chips=$(printf '%s' "$page" | grep -o 'class="ichip"' | wc -l | tr -d ' ')
[ "$chips" = "8" ] || { echo "  expected the eight entry-point cards, found $chips"; fail=1; }

# --- 4. Positive controls: the deferred surfaces still carry the old words --------------
has   "$observatory" "Eight Intelligences"  || { echo "  POSITIVE CONTROL FAILED: /observatory/ no longer says \"Eight Intelligences\" (that surface has its own disposition)"; fail=1; }
has_i "$approach"    "institutional memory" || { echo "  POSITIVE CONTROL FAILED: /approach/ no longer says \"institutional memory\" (that surface has its own disposition)"; fail=1; }

# --- 5. Link targets --------------------------------------------------------------------
targets="/composable-bank/ /composable-bank/organisation/ /composable-bank/change/ /composable-bank/family-wealth/ /transformation-intelligence/ /solutions/ /agentic-delivery/"
if [ "$mode" = "live" ]; then
  for p in $targets; do curl -fsI "$SITE$p" >/dev/null || { echo "  link target unreachable: $p"; fail=1; }; done
else
  for p in $targets; do [ -f "_site${p}index.html" ] || { echo "  link target missing in _site: $p"; fail=1; }; done
fi

if [ "$fail" -ne 0 ]; then echo ""; echo "Disposition check FAILED ($mode)."; exit 1; fi
echo "Disposition check passed ($mode)."
