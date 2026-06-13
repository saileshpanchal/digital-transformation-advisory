#!/usr/bin/env bash
set -euo pipefail

test -f "_site/composable-bank/index.html"

if find _site -type f -print0 | xargs -0 grep -I -l \
  -e "Heimdall technical due diligence" \
  -e "Approved technical access" \
  -e "architecture-showcase" \
  > /tmp/dta-protected-leaks.txt; then
  echo "Protected architecture content was found in the public site:"
  cat /tmp/dta-protected-leaks.txt
  exit 1
fi

echo "Public showcase boundary verified."
