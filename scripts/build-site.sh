#!/usr/bin/env bash
#
# Build the site so that a downstream check can prove which commit produced
# the artefact it examines. Deletes _site first, so a build that fails leaves
# no stale output to "verify" against; builds; then stamps _site/.built-from
# with the commit and a clean/dirty flag (tracked files only).
#
# Locally, when the default bundler shim cannot load (a Ruby upgrade stranded
# it on 25 Sep 2026): BUNDLE_CMD="bundle _4.0.20_" scripts/build-site.sh
# Netlify and the Pages workflow keep calling `bundle exec jekyll build`
# directly on a fresh checkout; they have no stale _site to protect against.
set -euo pipefail
cd "$(git rev-parse --show-toplevel)"
rm -rf _site
${BUNDLE_CMD:-bundle} exec jekyll build "$@"
{
  git rev-parse HEAD
  if [ -n "$(git status --porcelain --untracked-files=no)" ]; then echo dirty; else echo clean; fi
} > _site/.built-from
echo "built $(git rev-parse --short HEAD) into _site ($(sed -n 2p _site/.built-from) tree)"
