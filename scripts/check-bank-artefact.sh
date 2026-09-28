#!/usr/bin/env bash
#
# Bank artefact coherence check: the consumer's side of the publish chain.
#
# composable-bank/ is synced into this repository by the prototype's build and
# published verbatim. On 28 Sep 2026 a sync replaced the bundle and the root
# page but left the ten route pages referencing the deleted assets, and every
# inner route of the public bank served a blank page until repaired by hand.
# The producer now stages by content and checks what it pushes; this is the
# second line: whatever the source of a change to composable-bank/ (the bot, a
# hand repair, a merge), the artefact this site is about to publish must be
# whole, or the build fails and the last good version stays live.
#
# Whole means: the root page references a bundle; every page references only
# assets that exist beside it; every route page is exactly the root page with
# ./assets/ rewritten to ../assets/, as the prototype's build-routes.mjs writes
# it. The subject is the tracked folder, which is the artefact as delivered
# (this site renders its own pages into _site/composable-bank/ too, so the
# published tree is not the artefact alone); when _site exists, every page of
# the artefact must also have been published byte for byte. Pass a directory
# to check another tree on its own.
#
# Usage:
#   scripts/check-bank-artefact.sh            (both deploy paths run this after the build)
#   scripts/check-bank-artefact.sh <dir>
set -uo pipefail
cd "$(git rev-parse --show-toplevel)"
dir="${1:-composable-bank}"
fail=0

[ -f "$dir/index.html" ] || { echo "ERROR: $dir/index.html is missing — the bank artefact is not there to check."; exit 1; }
echo "Checking the bank artefact ($dir)…"

bundle=$(grep -o 'assets/index-[A-Za-z0-9_-]*\.js' "$dir/index.html" | head -1 | sed 's#.*/##')
[ -n "$bundle" ] || { echo "  the root page references no bundle"; fail=1; }

pages=$(find "$dir" -maxdepth 2 -name index.html | sort)
for page in $pages; do
  for ref in $(grep -o 'assets/[A-Za-z0-9_.-]*' "$page" | sed 's#^assets/##' | sort -u); do
    [ -f "$dir/assets/$ref" ] || { echo "  ${page#"$dir"/} references a missing asset: $ref"; fail=1; }
  done
done

routes=0
for page in $pages; do
  [ "$page" = "$dir/index.html" ] && continue
  routes=$((routes + 1))
  sed 's#\./assets/#../assets/#g' "$dir/index.html" | cmp -s - "$page" \
    || { echo "  ${page#"$dir"/} is not the root page with ../assets/ (a partial sync, or a stale route page)"; fail=1; }
done

# The published copy must be the artefact, byte for byte.
if [ $# -eq 0 ] && [ -d _site/composable-bank ]; then
  for f in $pages $(find "$dir/assets" -type f | sort); do
    cmp -s "$f" "_site/$f" || { echo "  _site/$f is not the tracked file (not published verbatim)"; fail=1; }
  done
fi

if [ "$fail" -ne 0 ]; then
  echo ""
  echo "Bank artefact FAILED: partial or incoherent; not publishing it."
  exit 1
fi
echo "Bank artefact coherent: the root page and $routes route pages on bundle $bundle$( [ $# -eq 0 ] && [ -d _site/composable-bank ] && printf ', published verbatim')."
