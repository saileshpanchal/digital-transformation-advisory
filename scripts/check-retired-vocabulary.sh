#!/usr/bin/env bash
#
# Retired public vocabulary sweep.
#
# "Retired" has ONE definition: absent from every undated page of this site's
# built output. Two exclusions, stated here and nowhere else:
#   _site/composable-bank/   the synced demonstrator, governed in its own
#                            repository (its landing's line is recorded in
#                            dta-internal/claim-register.md, retired vocabulary)
#   _site/20*/ and feed.xml  dated posts, and the feed that carries their
#                            bodies: history is not rewritten
# The terms are the register's retired-vocabulary table. The Eight-Intelligences
# terms are deliberately still live on deferred surfaces (/observatory/, the
# homepage), where the per-page checks hold them as positive controls; they are
# NOT swept here until those surfaces have their own dispositions.
#
# Usage: scripts/build-site.sh && scripts/check-retired-vocabulary.sh
set -uo pipefail
cd "$(git rev-parse --show-toplevel)"
if [ "${1:-}" != "--discovery" ]; then
  . scripts/lib/require-fresh-build.sh && require_fresh_build
fi

terms=(
  "Shared Trust Ledger"
  "Trust Ledger"
  "institutional memory"
  "organisational memory"
  "Transformation Intelligence Platform"
)
# Surfaces found carrying retired vocabulary at the discovery sweep of 25 Sep
# 2026 (built tree f0c633c), each awaiting its own disposition. A hit on one of
# these is a REVIEW line so the debt stays visible on every run; a hit anywhere
# else FAILS. Removing a path from this list requires that page's disposition,
# never a copy edit made to get the sweep green.
pending=(
  "/agentic-delivery/"          # Trust Ledger
  "/solutions/accountability/"  # Trust Ledger
  "/building-capability/"       # institutional memory
  "/approach/"                  # institutional memory
)
is_pending() { local p; for p in "${pending[@]}"; do [ "$1" = "$p" ] && return 0; done; return 1; }
fail=0
echo "Sweeping undated pages of _site for retired vocabulary…"
files=$(find _site -name '*.html' -not -path '_site/composable-bank/*' -not -path '_site/20*')
for t in "${terms[@]}"; do
  hits=$(printf '%s\n' "$files" | xargs grep -l -i -F -- "$t" 2>/dev/null || true)
  [ -z "$hits" ] && continue
  while IFS= read -r f; do
    path=$(printf '%s' "$f" | sed 's|^_site||; s|/index.html$|/|')
    if is_pending "$path"; then
      echo "  review: \"$t\" still on $path (pending its own disposition)"
    else
      echo "  \"$t\" on $path: not a recorded pending surface"; fail=1
    fi
  done <<< "$hits"
done
if [ "$fail" -ne 0 ]; then echo ""; echo "Retired vocabulary sweep FAILED."; exit 1; fi
n=${#pending[@]}
echo "Retired vocabulary sweep passed: no retired term outside the $n recorded pending surfaces (review lines above)."
