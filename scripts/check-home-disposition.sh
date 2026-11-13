#!/usr/bin/env bash
#
# Homepage disposition check.
#
# 13 Nov 2026: moved onto the new homepage. Its disposition was written, and recorded privately, before this change.
# The 25 Sep disposition's retired strings stay retired; its distinctive strings and anchors are replaced by the new page's.
# Against the homepage at 70360c8 this check fails, as it must.
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

# --- 1b. Further words a public homepage must not carry ---------------------------
for s in "Partners & Licensing" "Partners &amp; Licensing" "licence" "license" "Transformation Miner" "MTDR" "harness"; do absent_i "$s"; done
if printf '%s' "$page" | grep -Eq '(^|[^A-Za-z])TIM([^A-Za-z]|$)'; then echo "  internal name present: \"TIM\""; fail=1; fi

# --- 2. The new homepage's words: present, case-sensitive ------------------------------------
distinctive=(
  "Understand your organisation."
  "Design better customer propositions."
  "Deliver change you can prove."
  "DTA provides strategic advisory, organisational discovery and design, customer proposition design, and engineering and assurance."
  "Make better decisions"
  "Design customer propositions"
  "Engineer and assure change"
  "Manage a bill"
  "Pay someone new"
  "Explore the bank"
  "See the approach working"
  "One connected approach"
  "How clients engage us"
  "Evidence, thinking and contact"
)
for s in "${distinctive[@]}"; do present "$s"; done

# --- 3. Scoped anchors: four buyer choices, three demonstration choices -----------------------
offers=$(printf '%s' "$page" | grep -o '<a[^>]*data-offer="[^"]*"[^>]*>')
n=$(printf '%s' "$offers" | grep -c '<a' | tr -d ' ')
[ "$n" = "4" ] || { echo "  expected four buyer choices, found $n"; fail=1; }
for o in strategic-advisory organisational-discovery customer-jobs engineering-assurance; do
  printf '%s' "$offers" | grep -q "data-offer=\"$o\"" && printf '%s' "$offers" | grep "data-offer=\"$o\"" | grep -q "href=\"/$o/\"" \
    || { echo "  the buyer choice $o does not open /$o/"; fail=1; }
done
demos=$(printf '%s' "$page" | grep -o 'data-demo="[^"]*"' | sort -u | wc -l | tr -d ' ')
[ "$demos" = "3" ] || { echo "  expected three demonstration choices, found $demos"; fail=1; }
for d in bill pay explore; do
  block=$(printf '%s' "$page" | tr '\n' ' ' | grep -o "data-demo=\"$d\".*" | sed 's/<\/div>[[:space:]]*<\/div>.*//')
  printf '%s' "$block" | grep -q 'href="/composable-bank/' || { echo "  the demonstration choice $d opens nothing in the bank"; fail=1; }
done

# --- 4. Positive controls: the deferred surfaces still carry the old words --------------
has   "$observatory" "Eight Intelligences"  || { echo "  POSITIVE CONTROL FAILED: /observatory/ no longer says \"Eight Intelligences\" (that surface has its own disposition)"; fail=1; }
has_i "$approach"    "institutional memory" || { echo "  POSITIVE CONTROL FAILED: /approach/ no longer says \"institutional memory\" (that surface has its own disposition)"; fail=1; }

# --- 5. Link targets --------------------------------------------------------------------
targets="/strategic-advisory/ /organisational-discovery/ /customer-jobs/ /engineering-assurance/ /what-we-do/ /enquiry/ /insights/ /composable-bank/ /composable-bank/bills/ /composable-bank/pay-someone-new/ /composable-bank/organisation/ /composable-bank/change/ /about/ /agentic-delivery/"
if [ "$mode" = "live" ]; then
  for p in $targets; do curl -fsI "$SITE$p" >/dev/null || { echo "  link target unreachable: $p"; fail=1; }; done
else
  for p in $targets; do [ -f "_site${p}index.html" ] || { echo "  link target missing in _site: $p"; fail=1; }; done
fi

if [ "$fail" -ne 0 ]; then echo ""; echo "Disposition check FAILED ($mode)."; exit 1; fi
echo "Disposition check passed ($mode)."
