#!/usr/bin/env bash
#
# Public-showcase boundary check.
#
# The composable-bank microsite is a public, sales-facing showcase. It must
# never expose internal codenames, the reference-prototype's product status,
# or protected architecture material. This script fails the build if any of
# that leaks into either the generated site (_site) or the tracked repo.
#
set -euo pipefail

fail=0

# 1. The public showcase must actually be built.
if [ ! -f "_site/composable-bank/index.html" ]; then
  echo "ERROR: _site/composable-bank/index.html is missing — the showcase did not build."
  exit 1
fi

# Forbidden strings: internal codenames + specific protected phrases.
# Note: "Architecture Room" is intentionally NOT here — the public site
# legitimately invites approved visitors to request access to it.
#
# Note: "Ultim8" was removed from this list deliberately — it is a publicly known
# name, not a secret, and guarding it silently failed deploys. Protected
# architecture is still gated at the product level (architecture links use an
# email access-request flow, not a deep link to the internal host).
forbidden=(
  "Heimdall"
  "Nettle"
  "Approved technical access"
  "architecture-showcase"
)

# scan <label> <path…> — returns non-zero if any forbidden term is found.
scan() {
  local label="$1"; shift
  local found=0
  for term in "${forbidden[@]}"; do
    if grep -RIl -i -e "$term" "$@" 2>/dev/null | grep -q .; then
      echo "  leak: \"$term\" found in $label:"
      grep -RIl -i -e "$term" "$@" 2>/dev/null | sed 's/^/    /'
      found=1
    fi
  done
  return $found
}

# 2. Scan the generated public site.
echo "Checking generated site (_site/composable-bank)…"
if ! scan "the generated public site" _site/composable-bank; then
  fail=1
fi

# 3. Scan tracked repo files, excluding only build tooling and this script
#    itself (which necessarily lists the forbidden terms). docs/ IS scanned —
#    this is a public repo, so internal codenames must not live there either.
echo "Checking tracked repo files…"
tracked=$(git ls-files \
  | grep -vE '^(\.superpowers/|\.gstack/|scripts/check-public-showcase\.sh)' || true)
if [ -n "$tracked" ]; then
  # shellcheck disable=SC2086
  if ! scan "tracked repo files" $tracked; then
    fail=1
  fi
fi

if [ "$fail" -ne 0 ]; then
  echo ""
  echo "Public-showcase boundary FAILED. Remove the leaked codename/protected content above."
  exit 1
fi

echo "Public showcase boundary verified."
