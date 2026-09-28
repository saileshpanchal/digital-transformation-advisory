#!/usr/bin/env bash
#
# Homepage progressive-enhancement check (28 Sep 2026).
#
# The designer's review brought the site its first JavaScript: the hero's dot
# field and the word-by-word reveal of the hero's one line. Readable content
# must never depend on it. This is the static half of the no-JavaScript
# acceptance test; the dynamic half is the browser pass with the script tags
# stripped.
#
# Usage:
#   scripts/build-site.sh && scripts/check-home-enhancement.sh
set -uo pipefail
cd "$(git rev-parse --show-toplevel)"
fail=0
page=_site/index.html
js=(sonar-field.js scroll-reveal.js)

for f in "$page" _site/assets/css/corporate.css; do
  [ -f "$f" ] || { echo "missing $f (run: scripts/build-site.sh)"; exit 1; }
done
. scripts/lib/require-fresh-build.sh && require_fresh_build
css=$(tr -d ' \n\t' < _site/assets/css/corporate.css)

echo "Checking the homepage's progressive enhancement (_site)…"

# 1. Without a script, every word of the reveal is readable.
printf '%s' "$css" | grep -Fq '.reveal__statementspan{opacity:1' \
  || { echo "  the stylesheet's default for reveal words is not opacity:1"; fail=1; }

# 2. The enhancement class is added by the script, never baked into the markup.
grep -Fq 'reveal--enhanced' "$page" \
  && { echo "  reveal--enhanced is present in the built HTML (enhancement baked into markup)"; fail=1; }

# 3. Each script is present, loaded with defer, and honours prefers-reduced-motion.
for s in "${js[@]}"; do
  [ -f "_site/assets/js/$s" ] || { echo "  missing _site/assets/js/$s"; fail=1; continue; }
  grep -o "<script[^>]*/assets/js/$s[^>]*>" "$page" | grep -qw defer || { echo "  $s is not loaded with defer"; fail=1; }
  grep -Fq 'prefers-reduced-motion' "_site/assets/js/$s" || { echo "  $s has no prefers-reduced-motion query"; fail=1; }
done

# 4. The canvas is decorative.
grep -Eq '<canvas[^>]*aria-hidden="true"' "$page" || { echo "  the hero canvas lacks aria-hidden"; fail=1; }

# 5. The mask fades the field, never the copy: on .hero-field__bg, not .hero-field.
printf '%s' "$css" | grep -Eq '\.hero-field\{[^}]*mask-image' \
  && { echo "  mask-image on .hero-field itself (it would fade the copy and the links)"; fail=1; }
printf '%s' "$css" | grep -Eq '\.hero-field__bg\{[^}]*mask-image' || { echo "  no mask-image on .hero-field__bg"; fail=1; }

if [ "$fail" -ne 0 ]; then echo ""; echo "Enhancement check FAILED."; exit 1; fi
echo "Enhancement check passed: the homepage reads without its scripts."
