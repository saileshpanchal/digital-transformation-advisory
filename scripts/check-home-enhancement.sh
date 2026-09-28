#!/usr/bin/env bash
#
# Homepage progressive-enhancement check (28 Sep 2026).
#
# The designer's review brought the site its first JavaScript: the hero's dot
# field and the word-by-word reveal of the hero's one line. Readable content
# must never depend on it. This is the static half of the no-JavaScript
# acceptance test (the dynamic half is the browser pass with the script tags
# stripped): the stylesheet renders the reveal at full opacity by default; the
# enhancement class is only ever added by the script; both scripts load with
# defer; the canvas is decorative; both scripts honour prefers-reduced-motion;
# and the hero's mask sits on the background layer, never on the section, so it
# can fade the field but not the argument.
#
# Usage:
#   scripts/build-site.sh && scripts/check-home-enhancement.sh
set -uo pipefail
cd "$(git rev-parse --show-toplevel)"
fail=0

for f in _site/index.html _site/assets/css/corporate.css _site/assets/js/sonar-field.js _site/assets/js/scroll-reveal.js; do
  [ -f "$f" ] || { echo "missing $f (run: scripts/build-site.sh)"; exit 1; }
done
. scripts/lib/require-fresh-build.sh && require_fresh_build

echo "Checking the homepage's progressive enhancement (_site)…"
page=$(cat _site/index.html)
css=$(tr -d ' \n\t' < _site/assets/css/corporate.css)

# 1. Without a script, every word of the reveal is readable.
printf '%s' "$css" | grep -Fq '.reveal__statementspan{opacity:1' \
  || { echo "  the stylesheet's default for reveal words is not opacity:1"; fail=1; }

# 2. The enhancement class is added by the script, never baked into the markup.
if printf '%s' "$page" | grep -Fq 'reveal--enhanced'; then
  echo "  reveal--enhanced is present in the built HTML (enhancement baked into markup)"; fail=1
fi

# 3. Both scripts present and deferred.
for s in sonar-field.js scroll-reveal.js; do
  printf '%s' "$page" | grep -Eq "<script[^>]*defer[^>]*/assets/js/$s|<script[^>]*/assets/js/$s[^>]*defer" \
    || { echo "  $s is not loaded with defer"; fail=1; }
done

# 4. The canvas is decorative.
printf '%s' "$page" | grep -Eq '<canvas[^>]*aria-hidden="true"' || { echo "  the hero canvas lacks aria-hidden"; fail=1; }

# 5. Both scripts honour prefers-reduced-motion.
for s in sonar-field.js scroll-reveal.js; do
  grep -Fq 'prefers-reduced-motion' "_site/assets/js/$s" || { echo "  $s has no prefers-reduced-motion query"; fail=1; }
done

# 6. The mask fades the field, never the copy: on .hero-field__bg, not .hero-field.
if printf '%s' "$css" | grep -Eq '\.hero-field\{[^}]*mask-image'; then
  echo "  mask-image on .hero-field itself (it would fade the copy and the links)"; fail=1
fi
printf '%s' "$css" | grep -Eq '\.hero-field__bg\{[^}]*mask-image' || { echo "  no mask-image on .hero-field__bg"; fail=1; }

# 7. The hero copy is in the markup, not painted by script (the strings themselves are check-home-disposition.sh's job).
printf '%s' "$page" | grep -Eq '<h1[^>]*class="[^"]*hero-field__h' || { echo "  the hero h1 is not in the markup"; fail=1; }

if [ "$fail" -ne 0 ]; then echo ""; echo "Enhancement check FAILED."; exit 1; fi
echo "Enhancement check passed: the homepage reads without its scripts."
